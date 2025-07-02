#!/usr/bin/env bash
# Portable shebang that works on macOS, Linux, and Windows (Git Bash/WSL/Cygwin)

# =============================================================================
# Claude Custom Commands Management Hub
# =============================================================================
# Comprehensive tool for managing Claude custom commands across project and global scopes
#
# Author: Ventsislav Stoevski (Cordona)
# Version: 2.0.0-portable
# License: Apache 2.0
# Compatibility: macOS, Linux, Windows (Git Bash/WSL/Cygwin), BSD, Solaris
# =============================================================================

# Enable strict mode for better error handling (portable across bash versions)
set -e  # Exit on error
set -u  # Exit on undefined variable
# Note: pipefail may not be available in all bash versions, so we omit it for max compatibility

# =============================================================================
# CONFIGURATION CONSTANTS (immutable)
# =============================================================================

readonly SCRIPT_NAME="Claude Custom Commands Management Hub"
readonly SCRIPT_VERSION="2.0.0-portable"
readonly SUCCESS=0
readonly FAILURE=1
readonly MAX_RETRIES=3

# Input validation constants
readonly YES="yes"
readonly NO="no"

# Color codes for professional logging (with fallback for non-color terminals)
if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
  readonly COLOR_RESET="\033[0m"
  readonly COLOR_BLUE="\033[34m"      # [INFO]
  readonly COLOR_GREEN="\033[32m"     # [SUCCESS]
  readonly COLOR_RED="\033[31m"       # [ERROR]
  readonly COLOR_YELLOW="\033[33m"    # [WARNING]
else
  # No color support or non-interactive terminal
  readonly COLOR_RESET=""
  readonly COLOR_BLUE=""
  readonly COLOR_GREEN=""
  readonly COLOR_RED=""
  readonly COLOR_YELLOW=""
fi

# Directory exclusion configuration
readonly EXCLUDED_DIRS=("info")

# =============================================================================
# RUNTIME STATE VARIABLES (mutable)
# =============================================================================

# OS and environment detection
DETECTED_OS=""
OS_VERSION=""
CLAUDE_GLOBAL_DIR=""
CLAUDE_GLOBAL_COMMANDS_DIR=""

# Scope availability and selection
PROJECT_AVAILABLE=false
GLOBAL_AVAILABLE=false
SELECTED_ACTION=""
SELECTED_SCOPE=""
PROJECT_COMMANDS_DIR=""

# =============================================================================
# COMPUTED VALUES (derived from state)
# =============================================================================

# These will be set by helper functions
BACKUP_BASE_DIR=""

# Navigation state variables
NAV_DIRS=()
NAV_FILES=()
NEXT_OPTION_NUM=""

# =============================================================================
# HELPER FUNCTIONS - Cross-Platform Utilities
# =============================================================================

# Description: Create a temporary file with portable path handling
# Parameters:
#   $1 - prefix: Prefix for temp file name
# Returns: Echoes temp file path
create_temp_file() {
  local prefix="${1:-temp}"

  # Use TMPDIR if available, otherwise fallback to platform-specific temp directories
  local temp_dir
  if [[ -n "${TMPDIR:-}" ]]; then
    temp_dir="$TMPDIR"
  elif [[ "$DETECTED_OS" == "Windows" ]]; then
    temp_dir="${TEMP:-${TMP:-/tmp}}"
  else
    temp_dir="/tmp"
  fi

  # Ensure temp directory exists
  mkdir -p "$temp_dir" 2>/dev/null || true

  # Create unique temp file
  local temp_file
  temp_file="$temp_dir/${prefix}_$$_$(date +%s)"
  touch "$temp_file" 2>/dev/null || {
    # Fallback to current directory if temp dir is not writable
    temp_file="./${prefix}_$$_$(date +%s)"
    touch "$temp_file"
  }

  echo "$temp_file"
}

# Description: Portable path normalization
# Parameters:
#   $1 - path: Path to normalize
# Returns: Echoes normalized path
normalize_path() {
  local path="$1"
  [[ -z "$path" ]] && return

  # Convert Windows backslashes to forward slashes
  path="${path//\\//}"

  # Remove duplicate slashes
  while [[ "$path" == *"//"* ]]; do
    path="${path//\/\/\/}/"
  done

  # Remove trailing slash unless it's the root
  if [[ "$path" != "/" && "$path" == */ ]]; then
    path="${path%/}"
  fi

  echo "$path"
}

# Description: Cross-platform realpath implementation
# Parameters:
#   $1 - path: Path to resolve
# Returns: Echoes absolute path
portable_realpath() {
  local path="$1"
  [[ -z "$path" ]] && return 1

  # Try native realpath first
  if command -v realpath >/dev/null 2>&1; then
    realpath "$path" 2>/dev/null && return
  fi

  # Fallback implementation
  if [[ -d "$path" ]]; then
    (cd "$path" && pwd)
  elif [[ -f "$path" ]]; then
    local dir file
    dir=$(dirname "$path")
    file=$(basename "$path")
    (cd "$dir" && echo "$(pwd)/$file")
  else
    # Path doesn't exist, try to resolve as much as possible
    local dir file
    dir=$(dirname "$path")
    file=$(basename "$path")
    if [[ -d "$dir" ]]; then
      (cd "$dir" && echo "$(pwd)/$file")
    else
      echo "$path"
    fi
  fi
}

# =============================================================================
# HELPER FUNCTIONS - File & Directory Operations
# =============================================================================

# Description: Find all command files in a directory with exclusion filtering
# Parameters:
#   $1 - target_directory: Directory to search in
# Returns: SUCCESS/FAILURE
# Global: Populates FOUND_COMMAND_FILES array
find_command_files() {
  local target_dir="$1"
  [[ -z "$target_dir" ]] && { log "ERROR" "find_command_files: Missing target directory"; return $FAILURE; }
  [[ ! -d "$target_dir" ]] && { log "ERROR" "find_command_files: Directory not found: $target_dir"; return $FAILURE; }

  FOUND_COMMAND_FILES=()

  # Portable file finding - avoid process substitution for Windows compatibility
  local temp_file
  temp_file=$(create_temp_file "found_files")
  find "$target_dir" -name "*.md" -type f 2>/dev/null | sort > "$temp_file"

  while IFS= read -r file; do
    if [[ -n "$file" ]] && ! is_file_excluded "$file" "$target_dir"; then
      FOUND_COMMAND_FILES+=("$file")
    fi
  done < "$temp_file"

  rm -f "$temp_file"
  return $SUCCESS
}

# Description: Check if a file is in an excluded directory
# Parameters:
#   $1 - file_path: Full path to file
#   $2 - base_dir: Base directory to check exclusions relative to
# Returns: 0 if excluded, 1 if not excluded
is_file_excluded() {
  local file_path="$1"
  local base_dir="$2"
  [[ -z "$file_path" || -z "$base_dir" ]] && return 1

  local parent_path
  parent_path=$(dirname "$file_path")

  # Check each parent directory up to base_dir
  while [[ "$parent_path" != "$base_dir" && "$parent_path" != "/" ]]; do
    local dir_name
    dir_name=$(basename "$parent_path")
    if is_directory_excluded "$dir_name"; then
      return 0  # File is excluded
    fi
    parent_path=$(dirname "$parent_path")
  done

  return 1  # File is not excluded
}

# Description: Get backup directory path based on scope
# Parameters:
#   $1 - scope: "global" or "project"
#   $2 - backup_type: Type of backup (optional)
# Returns: SUCCESS/FAILURE
# Global: Sets BACKUP_BASE_DIR
get_backup_directory() {
  local scope="$1"
  local backup_type="${2:-commands}"
  [[ -z "$scope" ]] && { log "ERROR" "get_backup_directory: Missing scope"; return $FAILURE; }

  case "$scope" in
    "global")
      BACKUP_BASE_DIR="$HOME/.claude-backups/$backup_type"
      ;;
    "project")
      local target_dir project_root
      target_dir=$(get_target_directory)
      [[ -z "$target_dir" ]] && { log "ERROR" "get_backup_directory: Could not determine target directory"; return $FAILURE; }
      project_root=$(dirname "$target_dir" | sed 's|/.claude/commands$||')
      BACKUP_BASE_DIR="$project_root/.claude-backups/$backup_type"
      ;;
    *)
      log "ERROR" "get_backup_directory: Invalid scope: $scope"
      return $FAILURE
      ;;
  esac

  return $SUCCESS
}

# Description: Create a backup of a file with timestamp
# Parameters:
#   $1 - source_file: File to backup
#   $2 - backup_type: Type of backup for directory organization
# Returns: SUCCESS/FAILURE
create_backup() {
  local source_file="$1"
  local backup_type="$2"
  [[ -z "$source_file" || -z "$backup_type" ]] && { log "ERROR" "create_backup: Missing required parameters"; return $FAILURE; }
  [[ ! -f "$source_file" ]] && { log "ERROR" "create_backup: Source file not found: $source_file"; return $FAILURE; }

  if ! get_backup_directory "$SELECTED_SCOPE" "$backup_type"; then
    return $FAILURE
  fi

  local backup_dir
  backup_dir="$BACKUP_BASE_DIR/$(date +%Y%m%d)"
  local file_name
  file_name=$(basename "$source_file")
  local backup_file
  backup_file="$backup_dir/${file_name%.md}-$(date +%H%M%S).md"

  if mkdir -p "$backup_dir" && cp "$source_file" "$backup_file"; then
    log "SUCCESS" "Created backup: $backup_file"
    return $SUCCESS
  else
    log "ERROR" "Failed to create backup: $backup_file"
    return $FAILURE
  fi
}

# =============================================================================
# HELPER FUNCTIONS - User Input & Validation
# =============================================================================

# Description: Prompt user with retry logic and validation
# Parameters:
#   $1 - prompt_message: Message to display to user
#   $2 - valid_options: Space-separated valid options
#   $3 - default_value: Default if max retries reached
#   $4 - max_retries: Maximum retry attempts (optional, defaults to MAX_RETRIES)
# Returns: SUCCESS/FAILURE
# Global: Sets USER_INPUT
prompt_with_retry() {
  local prompt_message="$1"
  local valid_options="$2"
  local default_value="$3"
  local max_retries="${4:-$MAX_RETRIES}"

  [[ -z "$prompt_message" || -z "$valid_options" || -z "$default_value" ]] && {
    log "ERROR" "prompt_with_retry: Missing required parameters"
    return $FAILURE
  }

  local retries=0
  USER_INPUT=""

  while true; do
    read -rp "$prompt_message: " USER_INPUT

    # Check if input is valid
    for option in $valid_options; do
      if [[ "$USER_INPUT" == "$option" ]]; then
        return $SUCCESS
      fi
    done

    log "ERROR" "Invalid choice. Valid options: $valid_options"
    ((retries++))

    if [[ $retries -ge $max_retries ]]; then
      log "ERROR" "Maximum retries reached. Using default: $default_value"
      USER_INPUT="$default_value"
      return $SUCCESS
    fi
  done
}

# Description: Validate command name format
# Parameters:
#   $1 - command_name: Name to validate
# Returns: 0 if valid, 1 if invalid
validate_command_name() {
  local command_name="$1"
  [[ -z "$command_name" ]] && return 1
  [[ "$command_name" =~ ^[a-z0-9-]+$ ]] && return 0 || return 1
}

# =============================================================================
# HELPER FUNCTIONS - Display & Formatting
# =============================================================================


# =============================================================================
# MAIN WORKFLOW FUNCTIONS
# =============================================================================

# Description: Main entry point for the script
# Parameters: All command line arguments
# Returns: SUCCESS/FAILURE
main() {
  # Initialize computed values
  BACKUP_BASE_DIR=""

  # Execute main workflow
  print_welcome_section
  detect_operating_system
  report_system_detection
  validate_and_setup_directories
  prompt_for_scope_choice
  setup_selected_scope
  scan_existing_commands
  prompt_for_action_type
  execute_selected_operations
  display_completion_summary
}

# =============================================================================
# Welcome and Information Display
# =============================================================================

print_welcome_section() {
  echo
  echo -e "${COLOR_BLUE}=================================================================================${COLOR_RESET}"
  echo -e "${COLOR_BLUE}🛠️  $SCRIPT_NAME v$SCRIPT_VERSION${COLOR_RESET}"
  echo -e "${COLOR_BLUE}=================================================================================${COLOR_RESET}"
  echo
  echo -e "${COLOR_BLUE}This script helps you manage Claude custom commands by:${COLOR_RESET}"
  echo -e "${COLOR_BLUE}  • Copying commands from repository to project or global scope${COLOR_RESET}"
  echo -e "${COLOR_BLUE}  • Updating existing commands in project or global scope${COLOR_RESET}"
  echo -e "${COLOR_BLUE}  • Safely removing commands with automatic backup${COLOR_RESET}"
  echo -e "${COLOR_BLUE}  • Listing and browsing existing commands${COLOR_RESET}"
  echo
  echo -e "${COLOR_BLUE}You can respond to prompts with:${COLOR_RESET}"
  echo -e "${COLOR_BLUE}  • 'y' or 'yes' for confirmation${COLOR_RESET}"
  echo -e "${COLOR_BLUE}  • 'n' or 'no' to decline${COLOR_RESET}"
  echo
}

# =============================================================================
# Operating System Detection
# =============================================================================

# Description: Enhanced cross-platform OS detection with robust fallbacks
detect_operating_system() {
  local os_name
  local os_version
  local claude_global_dir

  log "INFO" "Detecting operating system and environment..."

  # Multi-layer OS detection for maximum compatibility
  # Layer 1: OSTYPE variable (most reliable when available)
  if [[ -n "${OSTYPE:-}" ]]; then
    case "$OSTYPE" in
      darwin*)
        os_name="macOS"
        os_version=$(sw_vers -productVersion 2>/dev/null || echo "Unknown")
        claude_global_dir="$HOME/.claude"
        ;;
      linux-gnu*|linux*)
        os_name="Linux"
        # Try multiple methods to get version
        if command -v lsb_release >/dev/null 2>&1; then
          os_version=$(lsb_release -rs 2>/dev/null)
        elif [[ -f /etc/os-release ]]; then
          os_version=$(grep '^VERSION_ID=' /etc/os-release 2>/dev/null | cut -d'=' -f2 | tr -d '"')
        else
          os_version=$(uname -r)
        fi
        claude_global_dir="$HOME/.claude"
        ;;
      msys*|cygwin*|win32*)
        os_name="Windows"
        # Try to get Windows version
        if command -v cmd.exe >/dev/null 2>&1; then
          os_version=$(cmd.exe /c ver 2>/dev/null | grep -o "[0-9]*\.[0-9]*\.[0-9]*" | head -1)
        fi
        os_version="${os_version:-Unknown}"
        # Windows path handling with multiple fallbacks
        if [[ -n "${APPDATA:-}" ]]; then
          claude_global_dir=$(normalize_path "$APPDATA/.claude")
        elif [[ -n "${USERPROFILE:-}" ]]; then
          claude_global_dir=$(normalize_path "$USERPROFILE/.claude")
        else
          claude_global_dir="$HOME/.claude"
        fi
        ;;
      *)
        # Unknown OSTYPE, fall through to Layer 2
        os_name=""
        ;;
    esac
  fi

  # Layer 2: uname-based detection (fallback)
  if [[ -z "$os_name" ]] && command -v uname >/dev/null 2>&1; then
    case "$(uname -s 2>/dev/null)" in
      Darwin)
        os_name="macOS"
        os_version=$(sw_vers -productVersion 2>/dev/null || uname -r)
        claude_global_dir="$HOME/.claude"
        ;;
      Linux)
        os_name="Linux"
        os_version=$(uname -r)
        claude_global_dir="$HOME/.claude"
        ;;
      MINGW*|MSYS*|CYGWIN*)
        os_name="Windows"
        os_version="Unknown"
        claude_global_dir="${APPDATA:-$HOME}/.claude"
        claude_global_dir=$(normalize_path "$claude_global_dir")
        ;;
      FreeBSD|OpenBSD|NetBSD)
        os_name="BSD ($(uname -s))"
        os_version=$(uname -r)
        claude_global_dir="$HOME/.claude"
        ;;
      SunOS)
        os_name="Solaris"
        os_version=$(uname -r)
        claude_global_dir="$HOME/.claude"
        ;;
      *)
        os_name="Unknown ($(uname -s 2>/dev/null || echo 'Unable to detect'))"
        os_version="Unknown"
        claude_global_dir="$HOME/.claude"
        log "WARNING" "Unsupported or unknown operating system detected: $(uname -s 2>/dev/null || echo 'N/A')"
        ;;
    esac
  fi

  # Layer 3: Last resort fallback
  if [[ -z "$os_name" ]]; then
    os_name="Unknown"
    os_version="Unknown"
    claude_global_dir="$HOME/.claude"
    log "WARNING" "Unable to detect operating system, using defaults"
  fi

  # Normalize and validate the claude directory path
  claude_global_dir=$(normalize_path "$claude_global_dir")

  # Set global variables (avoiding export for portability)
  DETECTED_OS="$os_name"
  OS_VERSION="$os_version"
  CLAUDE_GLOBAL_DIR="$claude_global_dir"
  CLAUDE_GLOBAL_COMMANDS_DIR="$claude_global_dir/commands"

  log "SUCCESS" "Operating system detected successfully"
}

report_system_detection() {
  echo
  log "INFO" "System Detection Results:"
  log "INFO" "Operating System: $DETECTED_OS $OS_VERSION"
  log "INFO" "Architecture: $(uname -m)"
  log "INFO" "Shell: $SHELL"
  log "INFO" "Claude Global Directory: $CLAUDE_GLOBAL_DIR"
  log "INFO" "Claude Commands Directory: $CLAUDE_GLOBAL_COMMANDS_DIR"

  # Additional Windows-specific reporting
  if [[ "$DETECTED_OS" == "Windows" ]]; then
    log "INFO" "Windows Environment: $OSTYPE"
    if [[ -n "$APPDATA" ]]; then
      log "INFO" "Using APPDATA path: $APPDATA"
    else
      log "WARNING" "APPDATA not set, using HOME: $HOME"
    fi
  fi
  echo
}

# =============================================================================
# Directory Validation and Setup
# =============================================================================

validate_and_setup_directories() {
  log "INFO" "Validating Claude directory structure..."

  # Check global Claude directory
  if [[ ! -d "$CLAUDE_GLOBAL_DIR" ]]; then
    log "WARNING" "Global Claude directory not found: $CLAUDE_GLOBAL_DIR"

    local retries
    retries=0
    while true; do
      read -rp "Create global Claude directory? [yes/no]: " create_global
      create_global=$(normalize_input "$create_global")

      if [[ "$create_global" == "$YES" ]]; then
        if mkdir -p "$CLAUDE_GLOBAL_DIR"; then
          log "SUCCESS" "Created global Claude directory: $CLAUDE_GLOBAL_DIR"
          break
        else
          log "ERROR" "Failed to create global Claude directory"
          export GLOBAL_AVAILABLE=false
          return $FAILURE
        fi
      elif [[ "$create_global" == "$NO" ]]; then
        log "WARNING" "Global operations will not be available"
        export GLOBAL_AVAILABLE=false
        break
      else
        log "ERROR" "Invalid input. Please enter 'yes' or 'no'."
        ((retries++))
        if [[ $retries -ge $MAX_RETRIES ]]; then
          log "ERROR" "Maximum retries reached. Global operations disabled."
          export GLOBAL_AVAILABLE=false
          break
        fi
      fi
    done
  else
    log "SUCCESS" "Global Claude directory found: $CLAUDE_GLOBAL_DIR"
    export GLOBAL_AVAILABLE=true
  fi

  # Check/create global commands directory structure
  if [[ "$GLOBAL_AVAILABLE" == true ]] && [[ ! -d "$CLAUDE_GLOBAL_COMMANDS_DIR" ]]; then
    log "INFO" "Creating global commands directory structure..."
    if mkdir -p "$CLAUDE_GLOBAL_COMMANDS_DIR"; then
      log "SUCCESS" "Created global commands directory structure"
    else
      log "ERROR" "Failed to create global commands directory structure"
      export GLOBAL_AVAILABLE=false
    fi
  elif [[ "$GLOBAL_AVAILABLE" == true ]]; then
    log "SUCCESS" "Global commands directory found: $CLAUDE_GLOBAL_COMMANDS_DIR"
  fi
}

# =============================================================================
# Scope Selection and Setup
# =============================================================================

prompt_for_scope_choice() {
  echo
  echo "🌍 Where would you like to manage your Claude custom commands?"
  echo
  echo "📊 **Command Scope Options:**"
  echo
  echo "(global)  Personal commands - Available across ALL your projects"
  echo "          • Location: $CLAUDE_GLOBAL_COMMANDS_DIR"
  echo "          • Command prefix: /user:"
  echo "          • Shared: Only with you"
  echo "          • Use case: Personal productivity commands, shortcuts"
  echo
  echo "(project) Project commands - Shared with your team"
  echo "          • Location: [project]/.claude/commands"
  echo "          • Command prefix: /project:"
  echo "          • Shared: With team members via version control"
  echo "          • Use case: Project-specific workflows, team commands"
  echo

  local retries
  retries=0
  while true; do
    read -rp "Please choose your scope [global/project]: " scope_choice

    case "$scope_choice" in
      global|g)
        export SELECTED_SCOPE="global"
        log "SUCCESS" "Selected global scope - personal commands for all projects"
        break
        ;;
      project|p)
        export SELECTED_SCOPE="project"
        log "SUCCESS" "Selected project scope - team-shared commands"
        break
        ;;
      *)
        log "ERROR" "Invalid choice '$scope_choice'. Please enter 'global' or 'project'."
        ((retries++))
        if [[ $retries -ge $MAX_RETRIES ]]; then
          log "ERROR" "Maximum retries reached. Defaulting to global scope."
          export SELECTED_SCOPE="global"
          break
        fi
        ;;
    esac
  done
}

setup_selected_scope() {
  case "$SELECTED_SCOPE" in
    "global")
      setup_global_scope
      ;;
    "project")
      setup_project_scope
      ;;
    *)
      log "ERROR" "Unknown scope: $SELECTED_SCOPE"
      exit $FAILURE
      ;;
  esac
}

setup_global_scope() {
  log "INFO" "Setting up global scope for personal commands..."

  if [[ "$GLOBAL_AVAILABLE" == true ]]; then
    log "SUCCESS" "Global commands directory ready: $CLAUDE_GLOBAL_COMMANDS_DIR"
    export PROJECT_AVAILABLE=false  # Disable project scope
  else
    log "ERROR" "Global scope not available. Please ensure Claude is properly configured."
    exit $FAILURE
  fi
}

setup_project_scope() {
  log "INFO" "Setting up project scope for team-shared commands..."

  # Prompt for project directory
  echo
  echo "📁 Please specify the absolute path to your Claude Code project:"
  echo
  echo "Examples:"
  echo "  • /path/to/my-project (must contain .claude directory)"
  echo "  • ~/Development/my-app (must contain .claude directory)"
  echo "  • /Users/username/workspace/project (must contain .claude directory)"
  echo
  echo "ℹ️  Note: The project must already have a .claude directory."
  echo "   If not, you can create it manually with: mkdir -p your-project/.claude"
  echo

  local retries
  retries=0
  while true; do
    read -rp "Enter project directory path: " project_path

    if [[ -z "$project_path" ]]; then
      log "ERROR" "Project path cannot be empty. Please provide a valid path."
      ((retries++))
    else
      # Expand tilde and relative paths (portable)
      case "$project_path" in
        \~*)
          project_path="$HOME${project_path#\~}"
          ;;
      esac
      project_path=$(portable_realpath "$project_path")

      if [[ ! -d "$project_path" ]]; then
        log "ERROR" "Directory does not exist: $project_path"
        ((retries++))
      else
        # Check if .claude directory exists
        if [[ ! -d "$project_path/.claude" ]]; then
          log "ERROR" "This is not a Claude Code project. No .claude directory found in: $project_path"
          echo
          echo "📋 To set up a Claude Code project:"
          echo "   1. Navigate to your project: cd $project_path"
          echo "   2. Create the Claude directory: mkdir -p .claude"
          echo "   3. Optionally add CLAUDE.md: echo '# Project Instructions' > .claude/CLAUDE.md"
          echo "   4. Create commands directory: mkdir -p .claude/commands"
          echo "   5. Re-run this script"
          echo
          log "ERROR" "Exiting: Project is not initialized for Claude Code"
          exit $FAILURE
        fi

        # Check if commands directory exists, create if needed
        local commands_dir
        commands_dir="$project_path/.claude/commands"
        if [[ ! -d "$commands_dir" ]]; then
          log "INFO" "Creating commands directory: $commands_dir"
          if mkdir -p "$commands_dir"; then
            log "SUCCESS" "Created commands directory: $commands_dir"
          else
            log "ERROR" "Failed to create commands directory: $commands_dir"
            ((retries++))
            if [[ $retries -ge $MAX_RETRIES ]]; then
              log "ERROR" "Maximum retries reached. Switching to global scope."
              export SELECTED_SCOPE="global"
              setup_global_scope
              return $SUCCESS
            fi
            continue
          fi
        fi

        # Set the commands directory path
        export PROJECT_COMMANDS_DIR="$commands_dir"
        export PROJECT_AVAILABLE=true
        export GLOBAL_AVAILABLE=false  # Disable global scope
        log "SUCCESS" "Project commands directory set to: $PROJECT_COMMANDS_DIR"
        break
      fi
    fi

    if [[ $retries -ge $MAX_RETRIES ]]; then
      log "ERROR" "Maximum retries reached. Switching to global scope."
      export SELECTED_SCOPE="global"
      setup_global_scope
      return $SUCCESS
    fi
  done
}

# =============================================================================
# Command Scanning and User Interaction
# =============================================================================

scan_existing_commands() {
  log "INFO" "Scanning for existing commands..."

  local target_dir
  target_dir=""
  case "$SELECTED_SCOPE" in
    "project")
      target_dir="$PROJECT_COMMANDS_DIR"
      ;;
    "global")
      target_dir="$CLAUDE_GLOBAL_COMMANDS_DIR"
      ;;
  esac

  if [[ ! -d "$target_dir" ]]; then
    log "WARNING" "Target directory not found: $target_dir"
    return $FAILURE
  fi

  # Count commands by category (portable approach without associative arrays)
  local total_count
  total_count=0

  # Create temporary files for storing category data (bash 3.x compatible)
  local categories_temp categories_counts_temp
  categories_temp=$(create_temp_file "categories")
  categories_counts_temp=$(create_temp_file "counts")

  # Dynamically count commands in all directories (excluding documentation)
  for category_path in "$target_dir"/*; do
    if [[ -d "$category_path" ]]; then
      local category
      category=$(basename "$category_path")

      # Skip excluded directories
      if is_directory_excluded "$category"; then
        continue
      fi

      local count
      count=$(find "$category_path" -name "*.md" -type f 2>/dev/null | wc -l)

      # Store category and count in parallel files
      echo "$category" >> "$categories_temp"
      echo "$count" >> "$categories_counts_temp"

      total_count=$((total_count + count))
    fi
  done

  echo
  echo "📊 Commands Summary for $SELECTED_SCOPE scope:"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo

  # Display counts for each category dynamically (portable approach)
  if [[ -f "$categories_temp" && -f "$categories_counts_temp" ]]; then
    local line_num=1
    while IFS= read -r category; do
      local count
      count=$(sed -n "${line_num}p" "$categories_counts_temp")

      if [[ -n "$count" && $count -gt 0 ]]; then
        # Add appropriate emoji based on category name
        local emoji
        case "$category" in
          docs) emoji="📁" ;;
          exec) emoji="⚡" ;;
          git) emoji="🔧" ;;
          *) emoji="📂" ;;  # generic folder emoji for any category
        esac
        printf "   %s  %-28s %5s\n" "$emoji" "$category commands ($category/):" "$count"
      fi

      ((line_num++))
    done < "$categories_temp"
  fi

  # Clean up temporary files
  rm -f "$categories_temp" "$categories_counts_temp"

  echo "   ─────────────────────────────────────────"
  printf "   %s  %-28s %5s\n" "📈" "Total commands:" "$total_count"
  echo
  echo

  if [[ $total_count -eq 0 ]]; then
    log "INFO" "No commands found in $SELECTED_SCOPE scope"
  else
    log "SUCCESS" "Found $total_count commands in $SELECTED_SCOPE scope"
  fi
}

prompt_for_action_type() {
  echo
  echo "🛠️  What would you like to do?"
  echo
  echo "(copy)     Copy commands from repository to $SELECTED_SCOPE scope"
  echo "(update)   Update existing commands in $SELECTED_SCOPE scope"
  echo "(remove)   Remove commands safely from $SELECTED_SCOPE scope"
  echo "(list)     List and compare all commands"
  echo

  local retries
  retries=0
  while true; do
    read -rp "Please enter your choice [copy/update/remove/list]: " action

    case "$action" in
      copy|update|remove|list)
        export SELECTED_ACTION="$action"
        log "SUCCESS" "Selected action: $action"
        break
        ;;
      *)
        log "ERROR" "Invalid choice. Please select a valid action."
        ((retries++))
        if [[ $retries -ge $MAX_RETRIES ]]; then
          log "ERROR" "Maximum retries reached. Defaulting to 'list'."
          export SELECTED_ACTION="list"
          break
        fi
        ;;
    esac
  done
}

# =============================================================================
# Embedded Command Dependency Management
# =============================================================================

# Description: Detect embedded command dependencies in a user command file
# Parameters:
#   $1 - command_file: Path to the user command file to analyze
# Returns: Echoes list of embedded command filenames (one per line)
detect_embedded_dependencies() {
  local command_file="$1"

  if [[ ! -f "$command_file" ]]; then
    log "WARNING" "Command file not found for dependency detection: $command_file"
    return $FAILURE
  fi

  # Extract embedded command references using pattern: .claude/embedded/filename.md
  grep -o '\.claude/embedded/[^[:space:]]*\.md' "$command_file" 2>/dev/null | \
  sed 's|\.claude/embedded/||' | \
  sort -u || true
}

# Description: Copy embedded command dependencies to target directory
# Parameters:
#   $1 - dependencies: Space-separated list of embedded command filenames
#   $2 - target_base_dir: Base target directory (e.g., ~/.claude or project/.claude)
# Returns: Success/failure status
copy_embedded_dependencies() {
  local dependencies="$1"
  local target_base_dir="$2"

  if [[ -z "$dependencies" ]]; then
    return $SUCCESS
  fi

  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local embedded_source_dir="$script_dir/../../../embedded"
  local embedded_target_dir="$target_base_dir/embedded"

  # Ensure embedded target directory exists
  if ! mkdir -p "$embedded_target_dir"; then
    log "ERROR" "Failed to create embedded commands directory: $embedded_target_dir"
    return $FAILURE
  fi

  local success_count=0
  local total_count=0

  # Process each dependency
  for dependency in $dependencies; do
    ((total_count++))
    local source_file="$embedded_source_dir/$dependency"
    local target_file="$embedded_target_dir/$dependency"

    if [[ ! -f "$source_file" ]]; then
      log "ERROR" "Embedded dependency not found: $dependency"
      log "ERROR" "Expected location: $source_file"
      continue
    fi

    if cp "$source_file" "$target_file"; then
      log "SUCCESS" "Embedded dependency copied: $dependency"
      ((success_count++))
    else
      log "ERROR" "Failed to copy embedded dependency: $dependency"
    fi
  done

  if [[ $success_count -eq $total_count ]]; then
    log "SUCCESS" "All embedded dependencies copied successfully ($success_count/$total_count)"
    return $SUCCESS
  else
    log "WARNING" "Some embedded dependencies failed to copy ($success_count/$total_count)"
    return $FAILURE
  fi
}

# Description: Find references to an embedded command in user commands
# Parameters:
#   $1 - embedded_command: Filename of embedded command (e.g., verify-technical-content.md)
#   $2 - target_commands_dir: Directory containing user commands to search
# Returns: Echoes count of references found
find_embedded_references() {
  local embedded_command="$1"
  local target_commands_dir="$2"

  if [[ ! -d "$target_commands_dir" ]]; then
    echo "0"
    return $SUCCESS
  fi

  # Search for references to the embedded command
  local pattern="\.claude/embedded/$embedded_command"
  local ref_count
  ref_count=$(find "$target_commands_dir" -name "*.md" -type f -exec grep -l "$pattern" {} \; 2>/dev/null | wc -l)

  echo "$ref_count"
}

# Description: Clean up orphaned embedded commands (no references in user commands)
# Parameters:
#   $1 - target_base_dir: Base target directory (e.g., ~/.claude or project/.claude)
# Returns: Success/failure status
cleanup_orphaned_embedded() {
  local target_base_dir="$1"
  local embedded_dir="$target_base_dir/embedded"
  local commands_dir="$target_base_dir/commands"

  if [[ ! -d "$embedded_dir" ]]; then
    log "INFO" "No embedded commands directory found - nothing to clean up"
    return $SUCCESS
  fi

  local orphaned_commands=()
  local total_embedded=0

  # Check each embedded command for references
  for embedded_file in "$embedded_dir"/*.md; do
    if [[ ! -f "$embedded_file" ]]; then
      continue
    fi

    ((total_embedded++))
    local embedded_name
    embedded_name=$(basename "$embedded_file")
    local ref_count
    ref_count=$(find_embedded_references "$embedded_name" "$commands_dir")

    if [[ $ref_count -eq 0 ]]; then
      orphaned_commands+=("$embedded_name")
    fi
  done

  if [[ ${#orphaned_commands[@]} -eq 0 ]]; then
    log "SUCCESS" "No orphaned embedded commands found (checked $total_embedded commands)"
    return $SUCCESS
  fi

  echo
  echo "🧹 Orphaned Embedded Commands Detected:"
  for orphaned in "${orphaned_commands[@]}"; do
    echo "   • $orphaned (no longer referenced by any user commands)"
  done
  echo

  read -rp "Remove orphaned embedded commands? [yes/no]: " cleanup_choice
  cleanup_choice=$(normalize_input "$cleanup_choice")

  if [[ "$cleanup_choice" == "$YES" ]]; then
    local removed_count=0
    for orphaned in "${orphaned_commands[@]}"; do
      local orphaned_file="$embedded_dir/$orphaned"
      if rm -f "$orphaned_file"; then
        log "SUCCESS" "Removed orphaned embedded command: $orphaned"
        ((removed_count++))

        # Unified cleanup after embedded file removal
        unified_cleanup_after_file_removal "$orphaned_file" "embedded"
      else
        log "ERROR" "Failed to remove orphaned embedded command: $orphaned"
      fi
    done

    log "SUCCESS" "Cleanup complete: $removed_count/${#orphaned_commands[@]} orphaned commands removed"
  else
    log "INFO" "Orphaned embedded commands preserved (user choice)"
  fi

  return $SUCCESS
}

# Description: Validate that embedded dependencies exist in source
# Parameters:
#   $1 - dependencies: Space-separated list of embedded command filenames
# Returns: Success if all dependencies exist, failure otherwise
validate_embedded_dependencies() {
  local dependencies="$1"

  if [[ -z "$dependencies" ]]; then
    return $SUCCESS
  fi

  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local embedded_source_dir="$script_dir/../../../embedded"

  if [[ ! -d "$embedded_source_dir" ]]; then
    log "ERROR" "Embedded commands source directory not found: $embedded_source_dir"
    return $FAILURE
  fi

  local missing_dependencies=()

  for dependency in $dependencies; do
    local source_file="$embedded_source_dir/$dependency"
    if [[ ! -f "$source_file" ]]; then
      missing_dependencies+=("$dependency")
    fi
  done

  if [[ ${#missing_dependencies[@]} -gt 0 ]]; then
    log "ERROR" "Missing embedded dependencies:"
    for missing in "${missing_dependencies[@]}"; do
      log "ERROR" "  • $missing"
    done
    return $FAILURE
  fi

  return $SUCCESS
}

# =============================================================================
# Action Execution Functions
# =============================================================================

execute_selected_operations() {
  echo
  log "INFO" "Executing action: $SELECTED_ACTION in $SELECTED_SCOPE scope"

  case "$SELECTED_ACTION" in
    "copy")
      execute_copy_operation
      ;;
    "update")
      execute_update_operation
      ;;
    "remove")
      execute_remove_operation
      ;;
    "list")
      execute_list_operation
      ;;
    *)
      log "ERROR" "Unknown action: $SELECTED_ACTION"
      return $FAILURE
      ;;
  esac
}

execute_copy_operation() {
  log "INFO" "Copy operation selected - copying commands from repository"
  local target_dir
  target_dir=$(get_target_directory)

  echo
  echo "📦  Copy Commands from Repository to $SELECTED_SCOPE scope"
  echo "📁  Target directory: $target_dir"
  echo

  # Get source directory path relative to script
  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local source_dir="$script_dir/../../../commands"

  if [[ ! -d "$source_dir" ]]; then
    log "ERROR" "Source commands directory not found: $source_dir"
    echo "Expected location: $source_dir"
    echo "Please ensure you're running this script from the correct location."
    return $FAILURE
  fi

  echo "📂  Source: $source_dir"
  echo

  # Copy mode selection
  echo "📝  Copy Options:"
  echo "    1) Copy all commands (entire collection)"
  echo "    2) Browse and select specific commands"
  echo "    3) Cancel"
  echo

  local copy_mode retries
  copy_mode=""
  retries=0
  while true; do
    read -rp "Select option [1-3]: " copy_mode

    case "$copy_mode" in
      1|all)
        copy_all_commands "$source_dir" "$target_dir"
        return $?
        ;;
      2|browse|select)
        browse_and_select_commands "$source_dir" "$target_dir"
        return $?
        ;;
      3|cancel)
        log "INFO" "Copy operation cancelled by user"
        return $SUCCESS
        ;;
      *)
        log "ERROR" "Invalid choice. Please enter 1, 2, or 3."
        ((retries++))
        if [[ $retries -ge $MAX_RETRIES ]]; then
          log "ERROR" "Maximum retries reached. Cancelling operation."
          return $FAILURE
        fi
        ;;
    esac
  done
}

execute_update_operation() {
  log "INFO" "Update operation selected"
  local target_dir
  target_dir=$(get_target_directory)

  echo
  echo "🔄  Updating existing commands in $SELECTED_SCOPE scope"
  echo "📁  Target directory: $target_dir"
  echo

  # Find all command files and sort by category then name (excluding documentation directories)
  local commands=()
  while IFS= read -r file; do
    # Check if file is in an excluded directory
    local parent_path
    parent_path=$(dirname "$file")

    # Skip files in excluded directories
    local skip_file=false
    while [[ "$parent_path" != "$target_dir" && "$parent_path" != "/" ]]; do
      local dir_name
      dir_name=$(basename "$parent_path")
      if is_directory_excluded "$dir_name"; then
        skip_file=true
        break
      fi
      parent_path=$(dirname "$parent_path")
    done

    if [[ "$skip_file" == false ]]; then
      commands+=("$file")
    fi
  done < <(find "$target_dir" -name "*.md" -type f 2>/dev/null | sort)

  if [[ ${#commands[@]} -eq 0 ]]; then
    log "INFO" "No commands found to update in $target_dir"
    echo
    echo "💡 Would you like to create a new command instead?"
    read -rp "Create new command? [yes/no]: " create_new
    create_new=$(normalize_input "$create_new")

    if [[ "$create_new" == "$YES" ]]; then
      execute_create_operation
    fi
    return $SUCCESS
  fi

  echo "📋  Available commands for updating:"
  echo

  # Calculate dynamic column widths
  local max_no_width=3  # "No."
  local max_name_width=12  # "Command Name"
  local max_category_width=8  # "Category"
  local max_lines_width=5  # "Lines"
  local max_modified_width=13  # "Last Modified"

  # First pass: calculate maximum widths
  for i in "${!commands[@]}"; do
    local cmd_path="${commands[i]}"
    local cmd_name
    cmd_name=$(basename "$cmd_path" .md)
    local cmd_category
    cmd_category=$(basename "$(dirname "$cmd_path")")
    local cmd_size
    cmd_size=$(wc -l < "$cmd_path" 2>/dev/null || echo "0")
    local cmd_modified
    cmd_modified=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M" "$cmd_path" 2>/dev/null || echo "Unknown")

    # Calculate required widths
    local no_text="$((i+1)))"
    local category_text="($cmd_category)"

    [[ ${#no_text} -gt $max_no_width ]] && max_no_width=${#no_text}
    [[ ${#cmd_name} -gt $max_name_width ]] && max_name_width=${#cmd_name}
    [[ ${#category_text} -gt $max_category_width ]] && max_category_width=${#category_text}
    [[ ${#cmd_size} -gt $max_lines_width ]] && max_lines_width=${#cmd_size}
    [[ ${#cmd_modified} -gt $max_modified_width ]] && max_modified_width=${#cmd_modified}
  done

  # Print header directly without variable format strings
  printf "%-${max_no_width}s %-${max_name_width}s %-${max_category_width}s %-${max_lines_width}s %-${max_modified_width}s\n" "No." "Command Name" "Category" "Lines" "Last Modified"

  # Create separator line
  local no_sep
  no_sep=$(printf "%*s" "$max_no_width" "" | tr ' ' '-')
  local name_sep
  name_sep=$(printf "%*s" "$max_name_width" "" | tr ' ' '-')
  local category_sep
  category_sep=$(printf "%*s" "$max_category_width" "" | tr ' ' '-')
  local lines_sep
  lines_sep=$(printf "%*s" "$max_lines_width" "" | tr ' ' '-')
  local modified_sep
  modified_sep=$(printf "%*s" "$max_modified_width" "" | tr ' ' '-')

  printf "%-${max_no_width}s %-${max_name_width}s %-${max_category_width}s %-${max_lines_width}s %-${max_modified_width}s\n" "$no_sep" "$name_sep" "$category_sep" "$lines_sep" "$modified_sep"

  # Second pass: print data with calculated widths
  for i in "${!commands[@]}"; do
    local cmd_path="${commands[i]}"
    local cmd_name
    cmd_name=$(basename "$cmd_path" .md)
    local cmd_category
    cmd_category=$(basename "$(dirname "$cmd_path")")
    local cmd_size
    cmd_size=$(wc -l < "$cmd_path" 2>/dev/null || echo "0")
    local cmd_modified
    cmd_modified=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M" "$cmd_path" 2>/dev/null || echo "Unknown")

    printf "%-${max_no_width}s %-${max_name_width}s %-${max_category_width}s %-${max_lines_width}s %-${max_modified_width}s\n" "$((i+1)))" "$cmd_name" "($cmd_category)" "$cmd_size" "$cmd_modified"
  done
  echo

  # Get user selection
  echo "📝  Update Options:"
  echo "    • Enter a command number (1-${#commands[@]}) to update specific command"
  echo "    • Enter 'all' to update all commands with timestamp"
  echo "    • Enter 'cancel' to abort operation"
  echo

  local retries
  retries=0
  while true; do
    read -rp "Enter your choice: " selection

    if [[ "$selection" == "cancel" ]]; then
      log "INFO" "Update operation cancelled by user"
      return $SUCCESS
    elif [[ "$selection" == "all" ]]; then
      execute_update_all_commands "${commands[@]}"
      return $?
    elif [[ "$selection" =~ ^[0-9]+$ ]] && [[ $selection -ge 1 ]] && [[ $selection -le ${#commands[@]} ]]; then
      break
    else
      log "ERROR" "Invalid selection. Please enter a number (1-${#commands[@]}), 'all', or 'cancel'."
      ((retries++))
      if [[ $retries -ge $MAX_RETRIES ]]; then
        log "ERROR" "Maximum retries reached. Cancelling update operation."
        return $FAILURE
      fi
    fi
  done

  # Get selected command
  local selected_command="${commands[$((selection-1))]}"
  local cmd_name
  cmd_name=$(basename "$selected_command" .md)
  local cmd_category
  cmd_category=$(basename "$(dirname "$selected_command")")

  log "SUCCESS" "Selected command: $cmd_name ($cmd_category)"

  # Show current command content
  echo
  echo "📄 Current command content:"
  echo "════════════════════════════════════════════════════════════════"
  if [[ -f "$selected_command" ]]; then
    head -20 "$selected_command"
    local total_lines
    total_lines=$(wc -l < "$selected_command")
    if [[ $total_lines -gt 20 ]]; then
      echo "... ($((total_lines - 20)) more lines)"
    fi
  else
    echo "❌ File not found: $selected_command"
    return $FAILURE
  fi
  echo "════════════════════════════════════════════════════════════════"
  echo

  # Update options
  echo "🔧 Update options:"
  echo "   (edit)        Open in default editor"
  echo "   (description) Update description only"
  echo "   (tools)       Update allowed tools"
  echo "   (backup)      Create backup and edit"
  echo "   (cancel)      Cancel update"
  echo

  retries=0
  while true; do
    read -rp "Select update option [edit/description/tools/backup/cancel]: " update_option

    case "$update_option" in
      edit)
        update_command_in_editor "$selected_command" "$cmd_name" "$cmd_category"
        break
        ;;
      description)
        update_command_description "$selected_command" "$cmd_name" "$cmd_category"
        break
        ;;
      tools)
        update_command_tools "$selected_command" "$cmd_name" "$cmd_category"
        break
        ;;
      backup)
        update_command_with_backup "$selected_command" "$cmd_name" "$cmd_category"
        break
        ;;
      cancel)
        log "INFO" "Update operation cancelled by user"
        return $SUCCESS
        ;;
      *)
        log "ERROR" "Invalid option. Please select edit, description, tools, backup, or cancel."
        ((retries++))
        if [[ $retries -ge $MAX_RETRIES ]]; then
          log "ERROR" "Maximum retries reached. Defaulting to edit mode."
          update_command_in_editor "$selected_command" "$cmd_name" "$cmd_category"
          break
        fi
        ;;
    esac
  done
}

# =============================================================================
# Update Helper Functions
# =============================================================================

update_command_in_editor() {
  local command_file="$1"
  local cmd_name="$2"
  local cmd_category="$3"

  log "INFO" "Opening command in editor: $command_file"

  # Detect available editors
  local editor=""
  if [[ -n "$EDITOR" ]]; then
    editor="$EDITOR"
  elif command -v code &> /dev/null; then
    editor="code"
  elif command -v nano &> /dev/null; then
    editor="nano"
  elif command -v vim &> /dev/null; then
    editor="vim"
  elif command -v vi &> /dev/null; then
    editor="vi"
  else
    log "ERROR" "No suitable editor found. Please set EDITOR environment variable."
    return $FAILURE
  fi

  log "INFO" "Using editor: $editor"

  # Create backup
  local backup_file
  backup_file="${command_file}.backup.$(date +%Y%m%d-%H%M%S)"
  if cp "$command_file" "$backup_file"; then
    log "SUCCESS" "Created backup: $backup_file"
  else
    log "WARNING" "Failed to create backup"
  fi

  # Open editor
  if $editor "$command_file"; then
    # Handle embedded dependencies after update using reusable function
    local target_dir
    target_dir=$(dirname "$command_file")
    # Navigate to parent directory of commands to find .claude root
    local claude_root
    claude_root=$(dirname "$target_dir")

    handle_embedded_dependencies_on_update "$command_file" "$claude_root"

    log "SUCCESS" "Command updated: $cmd_name"
    echo
    echo "✅ Command updated successfully!"
    echo "📁 File: $command_file"
    echo "💾 Backup: $backup_file"
    echo "🏷️  Category: $cmd_category"
    echo
    return $SUCCESS
  else
    log "ERROR" "Editor exited with error"
    return $FAILURE
  fi
}

update_command_description() {
  local command_file="$1"
  local cmd_name="$2"
  local cmd_category="$3"

  log "INFO" "Updating description for: $cmd_name"

  # Get current description
  local current_desc=""
  if [[ -f "$command_file" ]]; then
    current_desc=$(grep '^description:' "$command_file" | sed 's/description: *"\(.*\)"/\1/' | head -1)
  fi

  echo "Current description: $current_desc"
  echo
  read -rp "Enter new description: " new_description

  if [[ -z "$new_description" ]]; then
    log "INFO" "No description provided. Operation cancelled."
    return $SUCCESS
  fi

  # Create backup
  local backup_file
  backup_file="${command_file}.backup.$(date +%Y%m%d-%H%M%S)"
  if cp "$command_file" "$backup_file"; then
    log "SUCCESS" "Created backup: $backup_file"
  else
    log "WARNING" "Failed to create backup"
  fi

  # Update description in file
  if sed -i.tmp "s/^description: .*/description: \"$new_description\"/" "$command_file" && rm "${command_file}.tmp"; then
    # Handle embedded dependencies after update using reusable function
    local target_dir
    target_dir=$(dirname "$command_file")
    # Navigate to parent directory of commands to find .claude root
    local claude_root
    claude_root=$(dirname "$target_dir")

    handle_embedded_dependencies_on_update "$command_file" "$claude_root"

    log "SUCCESS" "Updated description for: $cmd_name"
    echo
    echo "✅ Description updated successfully!"
    echo "📁 File: $command_file"
    echo "📝 Old: $current_desc"
    echo "📝 New: $new_description"
    echo "💾 Backup: $backup_file"
    echo
    return $SUCCESS
  else
    log "ERROR" "Failed to update description"
    return $FAILURE
  fi
}

update_command_tools() {
  local command_file="$1"
  local cmd_name="$2"
  local cmd_category="$3"

  log "INFO" "Updating allowed tools for: $cmd_name"

  # Get current tools
  local current_tools=""
  if [[ -f "$command_file" ]]; then
    current_tools=$(grep '^allowed-tools:' "$command_file" | head -1)
  fi

  echo "Current tools: $current_tools"
  echo
  echo "📋 Available tools:"
  echo "   Common: Bash, Read, Write, Grep, Glob, LS"
  echo "   Advanced: Edit, MultiEdit, NotebookRead, NotebookEdit"
  echo "   Web: WebFetch, WebSearch"
  echo "   Task: Task, TodoRead, TodoWrite"
  echo
  read -rp "Enter allowed tools (comma-separated): " new_tools

  if [[ -z "$new_tools" ]]; then
    log "INFO" "No tools provided. Operation cancelled."
    return $SUCCESS
  fi

  # Format tools as JSON array
  local formatted_tools=""
  IFS=',' read -ra TOOLS_ARRAY <<< "$new_tools"
  formatted_tools="["
  for i in "${!TOOLS_ARRAY[@]}"; do
    local tool
    tool=$(echo "${TOOLS_ARRAY[i]}" | xargs) # trim whitespace
    if [[ $i -gt 0 ]]; then
      formatted_tools="$formatted_tools, "
    fi
    formatted_tools="$formatted_tools\"$tool\""
  done
  formatted_tools="$formatted_tools]"

  # Create backup
  local backup_file
  backup_file="${command_file}.backup.$(date +%Y%m%d-%H%M%S)"
  if cp "$command_file" "$backup_file"; then
    log "SUCCESS" "Created backup: $backup_file"
  else
    log "WARNING" "Failed to create backup"
  fi

  # Update tools in file
  if sed -i.tmp "s/^allowed-tools: .*/allowed-tools: $formatted_tools/" "$command_file" && rm "${command_file}.tmp"; then
    # Handle embedded dependencies after update using reusable function
    local target_dir
    target_dir=$(dirname "$command_file")
    # Navigate to parent directory of commands to find .claude root
    local claude_root
    claude_root=$(dirname "$target_dir")

    handle_embedded_dependencies_on_update "$command_file" "$claude_root"

    log "SUCCESS" "Updated allowed tools for: $cmd_name"
    echo
    echo "✅ Allowed tools updated successfully!"
    echo "📁 File: $command_file"
    echo "🔧 New tools: $formatted_tools"
    echo "💾 Backup: $backup_file"
    echo
    return $SUCCESS
  else
    log "ERROR" "Failed to update allowed tools"
    return $FAILURE
  fi
}

update_command_with_backup() {
  local command_file="$1"
  local cmd_name="$2"
  local cmd_category="$3"

  log "INFO" "Creating backup and editing: $cmd_name"

  # Create timestamped backup in safe location
  local backup_base_dir
  if [[ "$SELECTED_SCOPE" == "global" ]]; then
    backup_base_dir="$HOME/.claude-backups/commands"
  else
    local target_dir project_root
    target_dir=$(get_target_directory)
    project_root=$(dirname "$target_dir" | sed 's|/.claude/commands$||')
    backup_base_dir="$project_root/.claude-backups/commands"
  fi

  local backup_dir backup_file
  backup_dir="$backup_base_dir/$(date +%Y%m%d)"
  backup_file="$backup_dir/${cmd_name}-$(date +%H%M%S).md"

  if mkdir -p "$backup_dir" && cp "$command_file" "$backup_file"; then
    log "SUCCESS" "Created backup: $backup_file"
  else
    log "ERROR" "Failed to create backup directory or file"
    return $FAILURE
  fi

  # Now proceed with editor (which has its own dependency management)
  update_command_in_editor "$command_file" "$cmd_name" "$cmd_category"
  local result=$?

  if [[ $result -eq $SUCCESS ]]; then
    echo "💾 Backup location: $backup_file"

    # Ask about backup cleanup with secure confirmation
    echo
    echo -e "${COLOR_BLUE}🗑️  Backup Cleanup:${COLOR_RESET}"
    echo -e "${COLOR_BLUE}A backup file was created:${COLOR_RESET}"
    echo -e "${COLOR_BLUE}💾  $backup_file${COLOR_RESET}"
    echo

    read -rp "Remove backup file now? [yes/no]: " cleanup_choice
    cleanup_choice=$(normalize_input "$cleanup_choice")

    if [[ "$cleanup_choice" == "$YES" ]]; then
      echo
      echo -e "${COLOR_RED}⚠️  DESTRUCTIVE ACTION WARNING ⚠️${COLOR_RESET}"
      echo -e "${COLOR_RED}This will permanently delete the backup file.${COLOR_RESET}"
      echo -e "${COLOR_YELLOW}💾 File: $backup_file${COLOR_RESET}"
      echo
      echo -e "${COLOR_YELLOW}To confirm deletion, type exactly: ${COLOR_RESET}${COLOR_RED}REMOVE BACKUP${COLOR_RESET}"

      local retry_count=0
      local max_retries=3
      local confirmation_success=false

      while [[ $retry_count -lt $max_retries ]]; do
        read -rp "Confirmation (attempt $((retry_count + 1))/$max_retries): " confirmation

        if [[ "$confirmation" == "REMOVE BACKUP" ]]; then
          confirmation_success=true
          break
        else
          ((retry_count++))
          if [[ $retry_count -lt $max_retries ]]; then
            echo -e "${COLOR_YELLOW}❌ Incorrect confirmation. Please type exactly: ${COLOR_RED}REMOVE BACKUP${COLOR_RESET}"
          fi
        fi
      done

      if [[ "$confirmation_success" == true ]]; then
        if rm -f "$backup_file"; then
          echo -e "${COLOR_GREEN}✅ Backup file removed: $backup_file${COLOR_RESET}"
          log "SUCCESS" "Backup file removed: $backup_file"
          # Also remove backup directory if empty
          local backup_dir_only
          backup_dir_only=$(dirname "$backup_file")
          if rmdir "$backup_dir_only" 2>/dev/null; then
            echo -e "${COLOR_GREEN}✅ Empty backup directory removed: $backup_dir_only${COLOR_RESET}"
            log "SUCCESS" "Empty backup directory removed: $backup_dir_only"
          fi
        else
          echo -e "${COLOR_RED}❌ Failed to remove backup file: $backup_file${COLOR_RESET}"
          log "ERROR" "Failed to remove backup file: $backup_file"
        fi
      else
        echo -e "${COLOR_RED}🛡️  Maximum retries exceeded - deletion cancelled for security${COLOR_RESET}"
        log "WARNING" "Backup deletion cancelled - maximum confirmation retries exceeded"
        log "INFO" "Backup preserved at: $backup_file"
      fi
    else
      log "INFO" "Backup preserved at: $backup_file"
    fi
  fi

  return $result
}

# =============================================================================
# Bulk Operations
# =============================================================================

execute_update_all_commands() {
  local commands=("$@")

  log "INFO" "Starting bulk update of ${#commands[@]} commands"

  # Define source directory (relative to script location)
  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local source_dir="$script_dir/../../../commands"
  local target_dir
  target_dir=$(get_target_directory)

  # Resolve the relative path to absolute for display
  local source_dir_display
  source_dir_display=$(cd "$source_dir" && pwd 2>/dev/null || echo "$source_dir")

  echo
  echo "🔄  Bulk Update Operation"
  echo "═══════════════════════════════════════════════════════════════"
  echo "This will replace existing commands with latest versions from:"
  echo "📂  Source: $source_dir_display"
  echo "📁  Target: $target_dir"
  echo

  # Check if source directory exists
  if [[ ! -d "$source_dir" ]]; then
    log "ERROR" "Source commands directory not found: $source_dir_display"
    log "ERROR" "Script location: $script_dir"
    log "ERROR" "Expected source path: $source_dir"
    return $FAILURE
  fi

  # Count available updates (from all command subdirectories, excluding documentation)
  local source_commands=()
  while IFS= read -r file; do
    # Check if file is in an excluded directory
    local skip_file=false
    local parent_path
    parent_path=$(dirname "$file")

    # Check each parent directory up to source_dir
    while [[ "$parent_path" != "$source_dir" && "$parent_path" != "/" ]]; do
      local dir_name
      dir_name=$(basename "$parent_path")
      if is_directory_excluded "$dir_name"; then
        skip_file=true
        break
      fi
      parent_path=$(dirname "$parent_path")
    done

    if [[ "$skip_file" == false ]]; then
      source_commands+=("$file")
    fi
  done < <(find "$source_dir" -name "*.md" -type f 2>/dev/null | sort)

  if [[ ${#source_commands[@]} -eq 0 ]]; then
    log "ERROR" "No source commands found in: $source_dir_display"
    return $FAILURE
  fi

  echo "📊  Found ${#source_commands[@]} commands in source directory"
  echo "📊  Found ${#commands[@]} commands in target directory"
  echo

  read -rp "⚠️  Continue with bulk update? This will replace existing commands. [yes/no]: " confirm
  confirm=$(normalize_input "$confirm")

  if [[ "$confirm" != "$YES" ]]; then
    log "INFO" "Bulk update cancelled by user"
    return $SUCCESS
  fi

  # Create backup in safe location (not inside .claude to avoid conflicts)
  local backup_base_dir
  if [[ "$SELECTED_SCOPE" == "global" ]]; then
    backup_base_dir="$HOME/.claude-backups"
  else
    # For project scope, get the project root (parent of .claude)
    local project_root
    project_root=$(dirname "$target_dir" | sed 's|/.claude/commands$||')
    backup_base_dir="$project_root/.claude-backups"
  fi

  local backup_dir
  backup_dir="$backup_base_dir/bulk-update-$(date +%Y%m%d-%H%M%S)"
  if ! mkdir -p "$backup_dir"; then
    log "ERROR" "Failed to create backup directory: $backup_dir"
    return $FAILURE
  fi

  log "SUCCESS" "Created backup directory: $backup_dir"

  # Pre-check which files need backup (only those that will change)
  echo
  echo "📦  Analyzing changes and creating backup..."
  local files_to_backup=()

  for source_file in "${source_commands[@]}"; do
    local relative_path target_file cmd_name
    relative_path="${source_file#"$source_dir"/}"
    target_file="$target_dir/$relative_path"
    cmd_name=$(basename "$source_file")

    # Only backup if file exists and will be changed
    if [[ -f "$target_file" ]] && ! cmp -s "$source_file" "$target_file"; then
      files_to_backup+=("$target_file")
    fi
  done

  # Create backup only for files that will change
  if [[ ${#files_to_backup[@]} -gt 0 ]]; then
    # Calculate max filename width for backup alignment
    local backup_max_width=15
    for cmd_file in "${files_to_backup[@]}"; do
      local cmd_name
      cmd_name=$(basename "$cmd_file")
      [[ ${#cmd_name} -gt $backup_max_width ]] && backup_max_width=${#cmd_name}
    done

    for cmd_file in "${files_to_backup[@]}"; do
      local cmd_name
      cmd_name=$(basename "$cmd_file")
      if cp "$cmd_file" "$backup_dir/"; then
        printf "   %-*s ... ✅ Backed up\n" "$backup_max_width" "$cmd_name"
      else
        printf "   %-*s ... ❌ Backup failed\n" "$backup_max_width" "$cmd_name"
      fi
    done
  fi

  if [[ ${#files_to_backup[@]} -eq 0 ]]; then
    echo "   📋 No files need backup (no changes detected)"
  fi

  # Update commands from source
  local updated_count=0
  local new_count=0
  local no_change_count=0
  local failed_count=0

  echo
  echo "🚀  Updating commands from source..."

  # Calculate max filename width for proper alignment
  local max_name_width=15
  for source_file in "${source_commands[@]}"; do
    local cmd_name
    cmd_name=$(basename "$source_file")
    [[ ${#cmd_name} -gt $max_name_width ]] && max_name_width=${#cmd_name}
  done

  for source_file in "${source_commands[@]}"; do
    local relative_path target_file cmd_name
    relative_path="${source_file#"$source_dir"/}"
    target_file="$target_dir/$relative_path"
    cmd_name=$(basename "$source_file")

    # Create target directory if needed
    local target_file_dir
    target_file_dir=$(dirname "$target_file")
    if [[ ! -d "$target_file_dir" ]]; then
      mkdir -p "$target_file_dir"
    fi

    # Check if target exists and compare
    if [[ -f "$target_file" ]]; then
      # Compare files to see if there are changes
      if cmp -s "$source_file" "$target_file"; then
        printf "   %-*s ... 📋 No changes\n" "$max_name_width" "$cmd_name"
        ((no_change_count++))
        continue
      else
        # Files are different, calculate changes and update
        local diff_stats additions deletions

        # Use git diff --numstat for accurate Git-standard calculation
        if git rev-parse --git-dir >/dev/null 2>&1; then
          # In a git repository - use git diff for perfect accuracy
          diff_stats=$(git diff --no-index --numstat "$target_file" "$source_file" 2>/dev/null | head -1)
          if [[ -n "$diff_stats" ]]; then
            additions=$(echo "$diff_stats" | cut -f1)
            deletions=$(echo "$diff_stats" | cut -f2)
          else
            additions="0"
            deletions="0"
          fi
        else
          # Fallback: improved diff logic to match Git behavior
          local diff_output
          diff_output=$(diff -u "$target_file" "$source_file" 2>/dev/null || true)
          if [[ -n "$diff_output" ]]; then
            # Count additions: lines starting with + but not +++
            additions=$(echo "$diff_output" | grep "^+" | grep -v "^+++" | wc -l | xargs)
            # Count deletions: lines starting with - but not ---
            deletions=$(echo "$diff_output" | grep "^-" | grep -v "^---" | wc -l | xargs)
          else
            additions="0"
            deletions="0"
          fi
        fi

        # Ensure numeric values
        [[ -z "$additions" || "$additions" == "-" ]] && additions="0"
        [[ -z "$deletions" || "$deletions" == "-" ]] && deletions="0"

        # Copy and report result
        if cp "$source_file" "$target_file"; then
          printf "   %-*s ... \033[32m+%s\033[0m \033[31m-%s\033[0m lines\n" "$max_name_width" "$cmd_name" "$additions" "$deletions"
          ((updated_count++))

          # Handle embedded dependencies for updated file using reusable function
          local claude_root
          claude_root=$(dirname "$target_dir")
          handle_embedded_dependencies_on_update "$target_file" "$claude_root"
        else
          printf "   %-*s ... ❌ Update failed\n" "$max_name_width" "$cmd_name"
          ((failed_count++))
        fi
      fi
    else
      # New file
      if cp "$source_file" "$target_file"; then
        printf "   %-*s ... ✨ New file\n" "$max_name_width" "$cmd_name"
        ((new_count++))

        # Handle embedded dependencies for new file using reusable function
        local claude_root
        claude_root=$(dirname "$target_dir")
        handle_embedded_dependencies_on_copy "$target_file" "$claude_root"
      else
        printf "   %-*s ... ❌ Copy failed\n" "$max_name_width" "$cmd_name"
        ((failed_count++))
      fi
    fi
  done

  # Clean up orphaned embedded commands after bulk update
  local claude_root
  claude_root=$(dirname "$target_dir")
  cleanup_orphaned_embedded "$claude_root"

  echo
  echo "📊  Bulk Update Results:"
  echo "   ✅ Commands updated: $updated_count"
  echo "   ✨ New commands added: $new_count"
  echo "   📋 No changes: $no_change_count"
  echo "   ❌ Failed: $failed_count"
  echo "   📦 Backup location: $backup_dir"
  echo

  if [[ $failed_count -eq 0 ]]; then
    log "SUCCESS" "All commands updated successfully from source"
  else
    log "WARNING" "Some commands failed to update"
  fi

  # Ask about backup cleanup with secure confirmation
  echo
  echo "🗑️  Backup Cleanup:"
  echo "The backup directory contains copies of your old commands:"
  echo "📦  $backup_dir"
  echo

  read -rp "Remove backup directory now? [yes/no]: " cleanup_choice
  cleanup_choice=$(normalize_input "$cleanup_choice")

  if [[ "$cleanup_choice" == "$YES" ]]; then
    echo
    echo -e "${COLOR_RED}⚠️  DESTRUCTIVE ACTION WARNING ⚠️${COLOR_RESET}"
    echo -e "${COLOR_RED}This will permanently delete the backup directory and all its contents.${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}📁 Directory: $backup_dir${COLOR_RESET}"
    echo
    echo -e "${COLOR_YELLOW}To confirm deletion, type exactly: ${COLOR_RESET}${COLOR_RED}REMOVE BACKUP${COLOR_RESET}"

    local retry_count=0
    local max_retries=3
    local confirmation_success=false

    while [[ $retry_count -lt $max_retries ]]; do
      read -rp "Confirmation (attempt $((retry_count + 1))/$max_retries): " confirmation

      if [[ "$confirmation" == "REMOVE BACKUP" ]]; then
        confirmation_success=true
        break
      else
        ((retry_count++))
        if [[ $retry_count -lt $max_retries ]]; then
          echo -e "${COLOR_YELLOW}❌ Incorrect confirmation. Please type exactly: ${COLOR_RED}REMOVE BACKUP${COLOR_RESET}"
        fi
      fi
    done

    if [[ "$confirmation_success" == true ]]; then
      if rm -rf "$backup_dir"; then
        echo -e "${COLOR_GREEN}✅ Backup directory removed: $backup_dir${COLOR_RESET}"
        log "SUCCESS" "Backup directory removed: $backup_dir"
      else
        echo -e "${COLOR_RED}❌ Failed to remove backup directory: $backup_dir${COLOR_RESET}"
        log "ERROR" "Failed to remove backup directory: $backup_dir"
      fi
    else
      echo -e "${COLOR_RED}🛡️  Maximum retries exceeded - deletion cancelled for security${COLOR_RESET}"
      log "WARNING" "Backup deletion cancelled - maximum confirmation retries exceeded"
      log "INFO" "Backup preserved at: $backup_dir"
    fi
  else
    log "INFO" "Backup preserved at: $backup_dir"
    echo "💡 You can manually remove it later with: rm -rf $backup_dir"
  fi

  return $SUCCESS
}

execute_remove_operation() {
  log "INFO" "Remove operation selected"

  local target_dir
  target_dir=$(get_target_directory)

  if [[ ! -d "$target_dir" ]]; then
    log "ERROR" "Target directory not found: $target_dir"
    return $FAILURE
  fi

  # Find commands to remove and sort by category then name (excluding documentation directories)
  local commands=()
  while IFS= read -r file; do
    # Check if file is in an excluded directory
    local skip_file=false
    local parent_path
    parent_path=$(dirname "$file")

    # Check each parent directory up to target_dir
    while [[ "$parent_path" != "$target_dir" && "$parent_path" != "/" ]]; do
      local dir_name
      dir_name=$(basename "$parent_path")
      if is_directory_excluded "$dir_name"; then
        skip_file=true
        break
      fi
      parent_path=$(dirname "$parent_path")
    done

    if [[ "$skip_file" == false ]]; then
      commands+=("$file")
    fi
  done < <(find "$target_dir" -name "*.md" -type f 2>/dev/null | sort)

  if [[ ${#commands[@]} -eq 0 ]]; then
    log "INFO" "No commands found to remove in $target_dir"
    return $SUCCESS
  fi

  echo
  echo "📋 Available commands for removal:"
  for i in "${!commands[@]}"; do
    local cmd_path="${commands[i]}"
    local cmd_name
    cmd_name=$(basename "$cmd_path" .md)
    local cmd_category
    cmd_category=$(basename "$(dirname "$cmd_path")")
    echo "  $((i+1))) $cmd_name ($cmd_category)"
  done
  echo

  read -rp "Enter command numbers to remove (e.g., 1,3,5 or 'all' or 'cancel'): " selection

  case "$selection" in
    "all")
      log "WARNING" "Preparing to remove ALL ${#commands[@]} commands"
      perform_safe_removal "${commands[@]}"
      ;;
    "cancel")
      log "INFO" "Remove operation cancelled by user"
      ;;
    *)
      # Parse comma-separated numbers
      local selected_commands=()
      IFS=',' read -ra ADDR <<< "$selection"
      for num in "${ADDR[@]}"; do
        num=$(echo "$num" | xargs) # trim whitespace
        if [[ "$num" =~ ^[0-9]+$ ]] && [[ $num -ge 1 ]] && [[ $num -le ${#commands[@]} ]]; then
          selected_commands+=("${commands[$((num-1))]}")
        else
          log "ERROR" "Invalid selection: $num"
        fi
      done

      if [[ ${#selected_commands[@]} -gt 0 ]]; then
        log "INFO" "Selected ${#selected_commands[@]} commands for removal"
        perform_safe_removal "${selected_commands[@]}"
      else
        log "ERROR" "No valid commands selected"
      fi
      ;;
  esac
}

execute_list_operation() {
  log "INFO" "List operation selected"

  echo
  echo "📊 Complete Commands Inventory"
  echo "════════════════════════════════════════════════════════════════"

  # List project commands if available
  if [[ "$PROJECT_AVAILABLE" == true ]]; then
    echo
    echo "📁 PROJECT COMMANDS ($PROJECT_COMMANDS_DIR):"
    list_commands_in_directory "$PROJECT_COMMANDS_DIR" "  "
  fi

  # List global commands if available
  if [[ "$GLOBAL_AVAILABLE" == true ]]; then
    echo
    echo "🌐 GLOBAL COMMANDS ($CLAUDE_GLOBAL_COMMANDS_DIR):"
    list_commands_in_directory "$CLAUDE_GLOBAL_COMMANDS_DIR" "  "
  fi

  echo
}

copy_all_commands() {
  local source_dir="$1"
  local target_dir="$2"

  echo
  echo "🚀  Copying all commands with dependency resolution..."

  # Collect all command files to copy (excluding documentation directories)
  local command_files=()
  local total_files=0

  for category_path in "$source_dir"/*; do
    if [[ -d "$category_path" ]]; then
      local category
      category=$(basename "$category_path")

      # Skip excluded directories
      if ! is_directory_excluded "$category"; then
        # Find all .md files in this category
        while IFS= read -r -d '' file; do
          command_files+=("$file")
          ((total_files++))
        done < <(find "$category_path" -name "*.md" -type f -print0 2>/dev/null)
      fi
    fi
  done

  echo "   📊 Found $total_files command files to copy (excluding documentation)"
  echo

  read -rp "Proceed with copying all $total_files commands? [yes/no]: " confirm
  confirm=$(normalize_input "$confirm")

  if [[ "$confirm" != "$YES" ]]; then
    log "INFO" "Copy all operation cancelled"
    return $SUCCESS
  fi

  # Copy each command file individually with dependency processing
  local copied_files=0
  local failed_files=0

  echo
  echo "🔄 Processing commands with dependency resolution..."

  for source_file in "${command_files[@]}"; do
    # Calculate relative path from source_dir
    local relative_path="${source_file#$source_dir/}"
    local breadcrumb
    breadcrumb=$(dirname "$relative_path")

    # Handle root level files
    if [[ "$breadcrumb" == "." ]]; then
      breadcrumb=""
    fi

    echo
    echo "📦 Processing: $relative_path"

    if copy_single_file "$source_file" "$target_dir" "$breadcrumb"; then
      ((copied_files++))
    else
      ((failed_files++))
      echo "   ❌ Failed to copy: $relative_path"
    fi
  done

  echo
  echo "═══════════════════════════════════════════════════════════════"

  if [[ $failed_files -eq 0 ]]; then
    log "SUCCESS" "Successfully copied all $copied_files command files with dependency resolution"
    echo "   📊 Summary:"
    echo "      • User commands: $copied_files"
    echo "      • Dependencies: handled automatically"
    echo "   📁 Target: $target_dir"

    # Run orphan cleanup to remove any stale embedded commands
    echo
    echo "🧹 Running dependency cleanup..."
    local target_claude_dir="$target_dir"
    if [[ "$target_dir" == *"/commands" ]]; then
      target_claude_dir="${target_dir%/commands}"
    fi
    cleanup_orphaned_embedded "$target_claude_dir"

  else
    log "ERROR" "Failed to copy $failed_files out of $total_files command files"
    return $FAILURE
  fi

  return $SUCCESS
}

browse_and_select_commands() {
  local source_dir="$1"
  local target_dir="$2"

  echo
  echo "🖼️  Browse and Select Commands"
  echo "═══════════════════════════════════════════════════════════════"

  # Start navigation from root
  navigate_directory "$source_dir" "$target_dir" ""
}

# =============================================================================
# HELPER FUNCTIONS - Directory Navigation
# =============================================================================

# Description: Collect directories and files from current directory with exclusion filtering
# Parameters:
#   $1 - current_dir: Directory to scan
# Global: Populates NAV_DIRS and NAV_FILES arrays
collect_directory_contents() {
  local current_dir="$1"
  [[ -z "$current_dir" ]] && { log "ERROR" "collect_directory_contents: Missing directory"; return $FAILURE; }

  NAV_DIRS=()
  NAV_FILES=()

  # Portable directory and file collection - avoid -print0 and process substitution
  local temp_dirs temp_files
  temp_dirs=$(create_temp_file "nav_dirs")
  temp_files=$(create_temp_file "nav_files")

  # List subdirectories (excluding documentation directories)
  find "$current_dir" -maxdepth 1 -type d ! -path "$current_dir" 2>/dev/null | sort > "$temp_dirs"

  while IFS= read -r dir; do
    if [[ -n "$dir" && -d "$dir" ]]; then
      local dir_name
      dir_name=$(basename "$dir")
      # Skip excluded directories (documentation, etc.)
      if ! is_directory_excluded "$dir_name"; then
        NAV_DIRS+=("$dir")
      fi
    fi
  done < "$temp_dirs"

  # List .md files
  find "$current_dir" -maxdepth 1 -name "*.md" -type f 2>/dev/null | sort > "$temp_files"

  while IFS= read -r file; do
    if [[ -n "$file" && -f "$file" ]]; then
      NAV_FILES+=("$file")
    fi
  done < "$temp_files"

  rm -f "$temp_dirs" "$temp_files"
  return $SUCCESS
}

# Description: Display navigation header and breadcrumb
# Parameters:
#   $1 - breadcrumb: Current navigation path
display_navigation_header() {
  local breadcrumb="$1"

  echo
  if [[ -n "$breadcrumb" ]]; then
    echo "📁  Current: $breadcrumb"
  else
    echo "📁  Root Directory"
  fi
  echo "───────────────────────────────────────────────────────────────"
}

# Description: Display directory listing with numbered options
# Parameters:
#   $1 - option_num: Starting option number
# Global: Uses NAV_DIRS array, returns next option number via NEXT_OPTION_NUM
display_directories_menu() {
  local option_num="$1"
  [[ -z "$option_num" ]] && option_num=1

  if [[ ${#NAV_DIRS[@]} -gt 0 ]]; then
    echo "📁  Directories:"
    for dir in "${NAV_DIRS[@]}"; do
      local dir_name
      dir_name=$(basename "$dir")
      local file_count
      file_count=$(find "$dir" -name "*.md" -type f | wc -l)
      printf "    %d) %s/ (%d commands)\n" "$option_num" "$dir_name" "$file_count"
      ((option_num++))
    done
    echo
  fi

  NEXT_OPTION_NUM="$option_num"
  return $SUCCESS
}

# Description: Display files listing with numbered options
# Parameters:
#   $1 - option_num: Starting option number
# Global: Uses NAV_FILES array, returns next option number via NEXT_OPTION_NUM
display_files_menu() {
  local option_num="$1"
  [[ -z "$option_num" ]] && option_num=1

  if [[ ${#NAV_FILES[@]} -gt 0 ]]; then
    echo "📄  Commands:"
    for file in "${NAV_FILES[@]}"; do
      local file_name
      file_name=$(basename "$file" .md)
      printf "    %d) %s.md\n" "$option_num" "$file_name"
      ((option_num++))
    done
    echo
  fi

  NEXT_OPTION_NUM="$option_num"
  return $SUCCESS
}

# Description: Display navigation options menu
# Parameters:
#   $1 - breadcrumb: Current navigation path
display_navigation_options() {
  local breadcrumb="$1"

  echo "📝  Options:"
  if [[ ${#NAV_DIRS[@]} -gt 0 ]] || [[ ${#NAV_FILES[@]} -gt 0 ]]; then
    echo "    a) Select all items in current directory"
  fi
  if [[ -n "$breadcrumb" ]]; then
    echo "    b) Back to parent directory"
  fi
  echo "    c) Cancel"
  echo
}

# Description: Handle numeric selection from navigation menu
# Parameters:
#   $1 - choice: User's numeric choice
#   $2 - max_option: Maximum valid option number
#   $3 - current_dir: Current directory
#   $4 - target_dir: Target directory for operations
#   $5 - breadcrumb: Current navigation path
# Returns: SUCCESS/FAILURE or recursive call result
handle_numeric_selection() {
  local choice="$1"
  local max_option="$2"
  local current_dir="$3"
  local target_dir="$4"
  local breadcrumb="$5"

  [[ -z "$choice" || -z "$max_option" || -z "$current_dir" || -z "$target_dir" ]] && {
    log "ERROR" "handle_numeric_selection: Missing required parameters"
    return $FAILURE
  }

  if [[ $choice -ge 1 ]] && [[ $choice -lt $max_option ]]; then
    local selected_index=$((choice - 1))

    if [[ $selected_index -lt ${#NAV_DIRS[@]} ]]; then
      # Selected a directory
      local selected_dir="${NAV_DIRS[$selected_index]}"
      local dir_name
      dir_name=$(basename "$selected_dir")
      local new_breadcrumb
      if [[ -n "$breadcrumb" ]]; then
        new_breadcrumb="$breadcrumb/$dir_name"
      else
        new_breadcrumb="$dir_name"
      fi
      navigate_directory "$selected_dir" "$target_dir" "$new_breadcrumb"
      return $?
    else
      # Selected a file
      local file_index=$((selected_index - ${#NAV_DIRS[@]}))
      local selected_file="${NAV_FILES[$file_index]}"
      copy_single_file "$selected_file" "$target_dir" "$breadcrumb"
      return $?
    fi
  else
    log "ERROR" "Invalid selection. Please try again."
    return $FAILURE
  fi
}

# =============================================================================
# MAIN NAVIGATION FUNCTION (Refactored)
# =============================================================================

# Description: Navigate through directory structure with interactive menu (refactored)
# Parameters:
#   $1 - current_dir: Directory to navigate
#   $2 - target_dir: Target directory for operations
#   $3 - breadcrumb: Current navigation path
# Returns: SUCCESS/FAILURE
navigate_directory() {
  local current_dir="$1"
  local target_dir="$2"
  local breadcrumb="$3"

  [[ -z "$current_dir" || -z "$target_dir" ]] && {
    log "ERROR" "navigate_directory: Missing required parameters"
    return $FAILURE
  }

  while true; do
    # Collect directory contents
    if ! collect_directory_contents "$current_dir"; then
      log "ERROR" "Failed to collect directory contents"
      return $FAILURE
    fi

    # Display navigation interface
    display_navigation_header "$breadcrumb"

    local option_num=1
    display_directories_menu "$option_num"
    option_num="$NEXT_OPTION_NUM"

    display_files_menu "$option_num"
    local max_option="$NEXT_OPTION_NUM"

    display_navigation_options "$breadcrumb"

    # Get user choice
    read -rp "Enter choice: " choice

    # Process user choice
    case "$choice" in
      [0-9]*)
        handle_numeric_selection "$choice" "$max_option" "$current_dir" "$target_dir" "$breadcrumb"
        local result=$?
        [[ $result -eq $SUCCESS ]] && return $SUCCESS
        ;;
      a|A|all)
        if [[ ${#NAV_DIRS[@]} -gt 0 ]] || [[ ${#NAV_FILES[@]} -gt 0 ]]; then
          copy_directory_contents "$current_dir" "$target_dir" "$breadcrumb"
          return $?
        else
          log "ERROR" "No items to select"
        fi
        ;;
      b|B|back)
        if [[ -n "$breadcrumb" ]]; then
          # Calculate parent directory and parent breadcrumb
          local parent_dir
          parent_dir=$(dirname "$current_dir")
          local parent_breadcrumb
          if [[ "$breadcrumb" == *"/"* ]]; then
            parent_breadcrumb=$(dirname "$breadcrumb")
          else
            parent_breadcrumb=""
          fi

          # Navigate to parent directory recursively
          navigate_directory "$parent_dir" "$target_dir" "$parent_breadcrumb"
          return $?
        else
          log "ERROR" "Already at root directory"
        fi
        ;;
      c|C|cancel)
        log "INFO" "Copy operation cancelled"
        return $SUCCESS
        ;;
      *)
        log "ERROR" "Invalid choice. Please try again."
        ;;
    esac
  done
}

copy_single_file() {
  local source_file="$1"
  local target_base_dir="$2"
  local breadcrumb="$3"

  local file_name
  file_name=$(basename "$source_file")

  # Determine target path
  local target_file
  if [[ -n "$breadcrumb" ]]; then
    local target_subdir="$target_base_dir/$breadcrumb"
    mkdir -p "$target_subdir"
    target_file="$target_subdir/$file_name"
  else
    target_file="$target_base_dir/$file_name"
  fi

  echo
  echo "💾  Copying: $breadcrumb/$file_name"

  if [[ -f "$target_file" ]]; then
    echo "   ⚠️  File already exists: $target_file"
    read -rp "Overwrite? [yes/no]: " overwrite
    overwrite=$(normalize_input "$overwrite")

    if [[ "$overwrite" != "$YES" ]]; then
      echo "   🚫 Skipped"
      return $SUCCESS
    fi
  fi

  # Copy the user command file
  if cp "$source_file" "$target_file"; then
    echo "   ✅ User command copied to: $target_file"
  else
    echo "   ❌ Failed to copy user command"
    return $FAILURE
  fi

  # Handle embedded dependencies using reusable function
  local target_claude_dir="$target_base_dir"
  if [[ "$target_base_dir" == *"/commands" ]]; then
    target_claude_dir="${target_base_dir%/commands}"
  fi

  handle_embedded_dependencies_on_copy "$source_file" "$target_claude_dir"

  echo "   📊 Copy complete: $(basename "$source_file")"

  return $SUCCESS
}

copy_directory_contents() {
  local source_dir="$1"
  local target_base_dir="$2"
  local breadcrumb="$3"

  echo
  echo "💾  Copying all contents from: $breadcrumb"

  # Determine target directory
  local target_dir
  if [[ -n "$breadcrumb" ]]; then
    target_dir="$target_base_dir/$breadcrumb"
  else
    target_dir="$target_base_dir"
  fi

  # Count files to copy (excluding documentation directories)
  local file_count
  file_count=0

  # If we're at root level, count only non-excluded directories
  if [[ -z "$breadcrumb" ]]; then
    for item_path in "$source_dir"/*; do
      if [[ -d "$item_path" ]]; then
        local item_name
        item_name=$(basename "$item_path")
        if ! is_directory_excluded "$item_name"; then
          local count
          count=$(find "$item_path" -name "*.md" -type f 2>/dev/null | wc -l)
          file_count=$((file_count + count))
        fi
      elif [[ -f "$item_path" && "$item_path" == *.md ]]; then
        file_count=$((file_count + 1))
      fi
    done
  else
    # For subdirectories, count all .md files
    file_count=$(find "$source_dir" -name "*.md" -type f 2>/dev/null | wc -l)
  fi

  echo "   📊 Found $file_count files to copy"

  read -rp "Proceed with copying? [yes/no]: " confirm
  confirm=$(normalize_input "$confirm")

  if [[ "$confirm" != "$YES" ]]; then
    echo "   🚫 Copy cancelled"
    return $SUCCESS
  fi

  # Create target directory structure
  mkdir -p "$target_dir"

  # Copy contents selectively
  local copied_items=0
  local failed_items=0

  for item_path in "$source_dir"/*; do
    local item_name
    item_name=$(basename "$item_path")

    if [[ -d "$item_path" ]]; then
      # For directories, check if excluded (only at root level)
      if [[ -z "$breadcrumb" ]] && is_directory_excluded "$item_name"; then
        echo "   🚫 Skipped: $item_name/ (documentation)"
        continue
      fi

      if cp -r "$item_path" "$target_dir/" 2>/dev/null; then
        ((copied_items++))
        echo "   ✅ Copied: $item_name/"
      else
        ((failed_items++))
        echo "   ❌ Failed: $item_name/"
      fi
    elif [[ -f "$item_path" ]]; then
      if cp "$item_path" "$target_dir/" 2>/dev/null; then
        ((copied_items++))
        echo "   ✅ Copied: $item_name"
      else
        ((failed_items++))
        echo "   ❌ Failed: $item_name"
      fi
    fi
  done

  if [[ $failed_items -eq 0 ]]; then
    echo "   ✅ Successfully copied $copied_items items"

    # Count .md files that were copied
    local copied_count
    copied_count=$(find "$target_dir" -name "*.md" -type f 2>/dev/null | wc -l)
    echo "   📊 Total .md files copied: $copied_count"
  else
    echo "   ⚠️ Copied $copied_items items, failed $failed_items items"
    return $FAILURE
  fi

  return $SUCCESS
}

# =============================================================================
# Safe Removal Operations
# =============================================================================

# Description: Unified cleanup function for all file deletion scenarios
# Handles directory cleanup and embedded orphan cleanup comprehensively
# Parameters:
#   $1 - file_path: Path to the file that was just removed
#   $2 - scope: Optional scope indicator ("bulk", "individual", "embedded")
# Returns: Success status
unified_cleanup_after_file_removal() {
  local file_path="$1"
  local scope="${2:-individual}"

  [[ -z "$file_path" ]] && return $SUCCESS

  log "INFO" "Starting unified cleanup for: $file_path (scope: $scope)"

  # Find the .claude root directory by walking up the path
  local claude_root=""
  local temp_dir="$(dirname "$file_path")"

  while [[ "$temp_dir" != "/" ]] && [[ "$temp_dir" != "." ]]; do
    if [[ "$(basename "$temp_dir")" == ".claude" ]]; then
      claude_root="$temp_dir"
      break
    fi
    temp_dir=$(dirname "$temp_dir")
  done

  if [[ -z "$claude_root" ]]; then
    log "WARNING" "Could not find .claude root directory, skipping cleanup"
    return $SUCCESS
  fi

  log "INFO" "Found .claude root: $claude_root"

  # Step 1: Clean up empty parent directories recursively
  cleanup_empty_directories_recursive "$file_path" "$claude_root"

  # Step 2: Handle embedded commands cleanup (only if we removed regular commands)
  # Check if the removed file was in the commands directory
  if [[ "$file_path" == *"/commands/"* ]]; then
    log "INFO" "Removed file was a command, checking for orphaned embedded dependencies..."
    cleanup_orphaned_embedded_after_command_removal "$claude_root"
  fi

  return $SUCCESS
}

# Description: Recursively remove empty parent directories
# Parameters:
#   $1 - file_path: Path to the removed file
#   $2 - claude_root: Root .claude directory path
cleanup_empty_directories_recursive() {
  local file_path="$1"
  local claude_root="$2"

  local current_dir
  current_dir=$(dirname "$file_path")

  # Track directories removed for reporting
  local removed_dirs=()

  # Recursively check and remove empty parent directories
  while [[ -d "$current_dir" ]] && [[ "$current_dir" != "$claude_root" ]]; do
    log "INFO" "Checking directory: $current_dir"

    # Check if directory is empty (no files, no subdirectories)
    local dir_contents
    dir_contents=$(find "$current_dir" -mindepth 1 -maxdepth 1 2>/dev/null)

    if [[ -z "$dir_contents" ]]; then
      # Directory is empty, remove it
      local dir_relative
      dir_relative="${current_dir#$claude_root/}"

      log "INFO" "Directory is empty, attempting to remove: $dir_relative"

      if rmdir "$current_dir" 2>/dev/null; then
        log "SUCCESS" "Removed empty directory: $dir_relative"
        removed_dirs+=("$dir_relative")
        # Move up to parent directory
        current_dir=$(dirname "$current_dir")
      else
        log "WARNING" "Failed to remove directory: $dir_relative"
        break
      fi
    else
      log "INFO" "Directory not empty, stopping cleanup: $(basename "$current_dir")"
      # List what's still in the directory for debugging
      local remaining_items
      remaining_items=$(find "$current_dir" -mindepth 1 -maxdepth 1 -printf "%f\n" 2>/dev/null | head -3)
      if [[ -n "$remaining_items" ]]; then
        log "INFO" "Directory contains: $(echo "$remaining_items" | tr '\n' ' ')"
      fi
      break
    fi
  done

  # Summary of directory cleanup
  if [[ ${#removed_dirs[@]} -gt 0 ]]; then
    log "SUCCESS" "Directory cleanup complete: removed ${#removed_dirs[@]} empty directories"
  else
    log "INFO" "No empty directories found to remove"
  fi
}

# Description: Check and clean up orphaned embedded commands after command removal
# Parameters:
#   $1 - claude_root: Root .claude directory path
cleanup_orphaned_embedded_after_command_removal() {
  local claude_root="$1"
  local embedded_dir="$claude_root/embedded"
  local commands_dir="$claude_root/commands"

  # Only proceed if embedded directory exists
  if [[ ! -d "$embedded_dir" ]]; then
    log "INFO" "No embedded directory found, skipping orphan cleanup"
    return $SUCCESS
  fi

  # Only proceed if there are no commands left to reference embedded files
  if [[ -d "$commands_dir" ]]; then
    local remaining_commands
    remaining_commands=$(find "$commands_dir" -name "*.md" -type f 2>/dev/null)
    if [[ -n "$remaining_commands" ]]; then
      log "INFO" "Commands still exist, skipping embedded orphan cleanup"
      return $SUCCESS
    fi
  fi

  # If we get here, no commands remain, so all embedded files are orphaned
  log "INFO" "No commands remain, all embedded files are now orphaned"

  local embedded_files
  embedded_files=$(find "$embedded_dir" -name "*.md" -type f 2>/dev/null)

  if [[ -z "$embedded_files" ]]; then
    log "INFO" "No embedded files found to clean up"
    return $SUCCESS
  fi

  local embedded_count
  embedded_count=$(echo "$embedded_files" | wc -l)

  echo
  echo "🧹 All embedded commands are now orphaned (no commands reference them):"
  echo "$embedded_files" | sed "s|$embedded_dir/||g" | sed 's/^/   • /'
  echo

  read -rp "Remove all $embedded_count orphaned embedded commands? [yes/no]: " cleanup_choice
  cleanup_choice=$(normalize_input "$cleanup_choice")

  if [[ "$cleanup_choice" == "$YES" ]]; then
    local removed_count=0

    while IFS= read -r embedded_file; do
      if [[ -f "$embedded_file" ]]; then
        local embedded_name
        embedded_name=$(basename "$embedded_file")

        if rm -f "$embedded_file"; then
          log "SUCCESS" "Removed orphaned embedded command: $embedded_name"
          ((removed_count++))
        else
          log "ERROR" "Failed to remove embedded command: $embedded_name"
        fi
      fi
    done <<< "$embedded_files"

    # After removing embedded files, clean up empty directories
    if [[ $removed_count -gt 0 ]]; then
      cleanup_empty_directories_comprehensive "$claude_root"
    fi

    log "SUCCESS" "Embedded cleanup complete: removed $removed_count/$embedded_count files"
  else
    log "INFO" "Orphaned embedded commands preserved (user choice)"
  fi

  return $SUCCESS
}

# Description: Comprehensive cleanup of all empty directories in .claude structure
# This function handles bulk deletion scenarios where multiple files have been removed
# Parameters:
#   $1 - claude_root: Root .claude directory path
# Returns: Success status
cleanup_empty_directories_comprehensive() {
  local claude_root="$1"
  [[ -z "$claude_root" ]] && return $SUCCESS

  if [[ ! -d "$claude_root" ]]; then
    log "INFO" "Claude directory not found, nothing to clean up"
    return $SUCCESS
  fi

  log "INFO" "Starting comprehensive directory cleanup..."

  local cleaned_dirs=0
  local cleanup_rounds=0
  local max_rounds=10

  # Keep cleaning until no more directories can be removed
  while [[ $cleanup_rounds -lt $max_rounds ]]; do
    ((cleanup_rounds++))
    local round_cleaned=0

    log "INFO" "Cleanup round $cleanup_rounds..."

    # Find all directories in .claude, sorted by depth (deepest first)
    local all_dirs=()
    while IFS= read -r -d '' dir; do
      # Skip the root .claude directory itself
      if [[ "$dir" != "$claude_root" ]]; then
        all_dirs+=("$dir")
      fi
    done < <(find "$claude_root" -type d -print0 2>/dev/null | sort -rz)

    # Try to remove each empty directory
    for dir in "${all_dirs[@]}"; do
      if [[ -d "$dir" ]]; then
        # Check if directory is empty
        local dir_contents
        dir_contents=$(find "$dir" -mindepth 1 -maxdepth 1 2>/dev/null)

        if [[ -z "$dir_contents" ]]; then
          local dir_relative
          dir_relative="${dir#$claude_root/}"

          if rmdir "$dir" 2>/dev/null; then
            log "SUCCESS" "Removed empty directory: $dir_relative"
            ((cleaned_dirs++))
            ((round_cleaned++))
          fi
        fi
      fi
    done

    # Stop if no directories were cleaned in this round
    if [[ $round_cleaned -eq 0 ]]; then
      log "INFO" "No more empty directories found, cleanup complete"
      break
    fi
  done

  if [[ $cleanup_rounds -ge $max_rounds ]]; then
    log "WARNING" "Cleanup stopped after $max_rounds rounds"
  fi

  # Final check - if .claude directory is now empty, offer to remove it
  if [[ -d "$claude_root" ]]; then
    local claude_contents
    claude_contents=$(find "$claude_root" -mindepth 1 -maxdepth 1 2>/dev/null)

    if [[ -z "$claude_contents" ]]; then
      echo
      echo "🗂️  The .claude directory is now completely empty."
      read -rp "Remove the entire .claude directory? [yes/no]: " remove_claude
      remove_claude=$(normalize_input "$remove_claude")

      if [[ "$remove_claude" == "$YES" ]]; then
        if rm -rf "$claude_root" 2>/dev/null; then
          log "SUCCESS" "Removed empty .claude directory: $claude_root"
          ((cleaned_dirs++))
        else
          log "WARNING" "Failed to remove .claude directory: $claude_root"
        fi
      else
        log "INFO" "Preserved empty .claude directory: $claude_root"
      fi
    fi
  fi

  if [[ $cleaned_dirs -gt 0 ]]; then
    log "SUCCESS" "Comprehensive cleanup complete: removed $cleaned_dirs directories in $cleanup_rounds rounds"
  else
    log "INFO" "No empty directories found to remove"
  fi

  return $SUCCESS
}

# =============================================================================
# REUSABLE EMBEDDED DEPENDENCY MANAGEMENT FUNCTIONS
# =============================================================================

# Description: Handle embedded dependencies when copying a command
# Detects and copies required embedded dependencies to target location
# Parameters:
#   $1 - source_command_path: Path to the source command file
#   $2 - target_claude_root: Target .claude directory path
# Returns: Success/failure status
handle_embedded_dependencies_on_copy() {
  local source_command_path="$1"
  local target_claude_root="$2"

  [[ -z "$source_command_path" || -z "$target_claude_root" ]] && return $SUCCESS

  # Detect embedded dependencies in the source command
  local embedded_deps
  embedded_deps=$(detect_embedded_dependencies "$source_command_path")

  if [[ -z "$embedded_deps" ]]; then
    log "INFO" "Command has no embedded dependencies to copy"
    return $SUCCESS
  fi

  log "INFO" "Command requires embedded dependencies: $embedded_deps"

  # Copy embedded dependencies to target
  copy_embedded_dependencies "$embedded_deps" "$target_claude_root"

  return $SUCCESS
}

# Description: Handle embedded dependencies when updating a command
# Detects dependency changes and syncs embedded commands accordingly
# Parameters:
#   $1 - command_path: Path to the command file being updated
#   $2 - claude_root: .claude directory path
#   $3 - dependencies_before: Dependencies before update (optional, will detect if not provided)
# Returns: Success/failure status
handle_embedded_dependencies_on_update() {
  local command_path="$1"
  local claude_root="$2"
  local dependencies_before="${3:-}"

  [[ -z "$command_path" || -z "$claude_root" ]] && return $SUCCESS

  # Detect dependencies before update if not provided
  if [[ -z "$dependencies_before" ]] && [[ -f "$command_path" ]]; then
    dependencies_before=$(detect_embedded_dependencies "$command_path")
  fi

  # Detect dependencies after update
  local dependencies_after
  if [[ -f "$command_path" ]]; then
    dependencies_after=$(detect_embedded_dependencies "$command_path")
  fi

  log "INFO" "Dependencies before update: ${dependencies_before:-none}"
  log "INFO" "Dependencies after update: ${dependencies_after:-none}"

  # Copy any new dependencies
  if [[ -n "$dependencies_after" ]]; then
    copy_embedded_dependencies "$dependencies_after" "$claude_root"
  fi

  # Clean up orphaned dependencies if any were removed
  if [[ "$dependencies_before" != "$dependencies_after" ]]; then
    log "INFO" "Dependencies changed, checking for orphans..."
    cleanup_orphaned_embedded "$claude_root"
  fi

  return $SUCCESS
}

# Description: Handle embedded dependencies when deleting a command
# Checks if any embedded commands are now orphaned and removes them
# Parameters:
#   $1 - deleted_command_path: Path to the command file that was just deleted
#   $2 - claude_root: Root .claude directory path
#   $3 - deleted_dependencies: Space-separated list of embedded dependencies the deleted command had
# Returns: Success/failure status
handle_embedded_dependencies_on_delete() {
  local deleted_command_path="$1"
  local claude_root="$2"
  local deleted_dependencies="$3"

  [[ -z "$deleted_command_path" || -z "$claude_root" ]] && return $SUCCESS

  local embedded_dir="$claude_root/embedded"
  local commands_dir="$claude_root/commands"

  # Only proceed if embedded directory exists
  if [[ ! -d "$embedded_dir" ]]; then
    return $SUCCESS
  fi

  log "INFO" "Checking for orphaned embedded dependencies after deleting: $(basename "$deleted_command_path")"

  if [[ -z "$deleted_dependencies" ]]; then
    log "INFO" "Deleted command had no embedded dependencies"
    return $SUCCESS
  fi

  log "INFO" "Deleted command referenced embedded files: $deleted_dependencies"

  # Check each embedded dependency to see if it's now orphaned
  local orphaned_embedded=()
  for dependency in $deleted_dependencies; do
    local embedded_file="$embedded_dir/$dependency"

    # Skip if embedded file doesn't exist
    if [[ ! -f "$embedded_file" ]]; then
      continue
    fi

    # Count references to this embedded command in remaining commands
    local ref_count
    if [[ -d "$commands_dir" ]]; then
      ref_count=$(find_embedded_references "$dependency" "$commands_dir")
    else
      ref_count=0
    fi

    if [[ $ref_count -eq 0 ]]; then
      orphaned_embedded+=("$dependency")
      log "INFO" "Embedded command '$dependency' is now orphaned (no remaining references)"
    else
      log "INFO" "Embedded command '$dependency' still has $ref_count references"
    fi
  done

  # Remove orphaned embedded commands if any found
  if [[ ${#orphaned_embedded[@]} -gt 0 ]]; then
    echo
    echo "🧹 Embedded commands orphaned by this deletion:"
    for orphaned in "${orphaned_embedded[@]}"; do
      echo "   • $orphaned (no longer referenced)"
    done
    echo

    read -rp "Remove ${#orphaned_embedded[@]} orphaned embedded commands? [yes/no]: " remove_choice
    remove_choice=$(normalize_input "$remove_choice")

    if [[ "$remove_choice" == "$YES" ]]; then
      local removed_count=0

      for orphaned in "${orphaned_embedded[@]}"; do
        local orphaned_file="$embedded_dir/$orphaned"

        if rm -f "$orphaned_file"; then
          log "SUCCESS" "Removed orphaned embedded command: $orphaned"
          ((removed_count++))

          # Clean up directories after removing embedded file
          unified_cleanup_after_file_removal "$orphaned_file" "embedded"
        else
          log "ERROR" "Failed to remove embedded command: $orphaned"
        fi
      done

      log "SUCCESS" "Removed $removed_count/${#orphaned_embedded[@]} orphaned embedded commands"
    else
      log "INFO" "Orphaned embedded commands preserved (user choice)"
    fi
  else
    log "INFO" "No embedded commands were orphaned by this deletion"
  fi

  return $SUCCESS
}

perform_safe_removal() {
  local commands_to_remove=("$@")

  if [[ ${#commands_to_remove[@]} -eq 0 ]]; then
    log "ERROR" "No commands provided for removal"
    return $FAILURE
  fi

  # Create timestamped backup directory in safe location
  local backup_base_dir
  if [[ "$SELECTED_SCOPE" == "global" ]]; then
    backup_base_dir="$HOME/.claude-backups"
  else
    local target_dir project_root
    target_dir=$(get_target_directory)
    project_root=$(dirname "$target_dir" | sed 's|/.claude/commands$||')
    backup_base_dir="$project_root/.claude-backups"
  fi

  local backup_dir
  backup_dir="$backup_base_dir/removal-$(date +%Y%m%d-%H%M%S)"
  log "INFO" "Creating backup directory: $backup_dir"

  if ! mkdir -p "$backup_dir"; then
    log "ERROR" "Failed to create backup directory: $backup_dir"
    return $FAILURE
  fi

  # Backup selected commands
  log "INFO" "Creating backup before removal..."
  for command in "${commands_to_remove[@]}"; do
    if [[ -f "$command" ]]; then
      local cmd_name
      cmd_name=$(basename "$command")
      if cp "$command" "$backup_dir/$cmd_name"; then
        log "INFO" "Backed up: $cmd_name"
      else
        log "ERROR" "Failed to backup: $cmd_name"
        return $FAILURE
      fi
    else
      log "WARNING" "Command file not found: $command"
    fi
  done

  # Show detailed removal plan
  echo
  echo "📋 Removal Plan:"
  for command in "${commands_to_remove[@]}"; do
    echo "  ❌ Will remove: $(basename "$command")"
  done
  echo "  📦 Backup location: $backup_dir"
  echo

  # Final confirmation with retry logic
  local retries
  retries=0
  while true; do
    read -rp "⚠️  This will permanently remove ${#commands_to_remove[@]} commands. Continue? [yes/no]: " confirm
    confirm=$(normalize_input "$confirm")

    if [[ "$confirm" == "$YES" ]]; then
      log "INFO" "User confirmed removal. Proceeding..."

      # Perform removal
      local removed_count=0
      local failed_count=0
      local directories_to_check=()

      for command in "${commands_to_remove[@]}"; do
        if [[ -f "$command" ]]; then
          # Store the directory for later cleanup check
          local cmd_dir
          cmd_dir=$(dirname "$command")
          directories_to_check+=("$cmd_dir")

          # Detect embedded dependencies before deleting the file
          local embedded_deps_before_deletion
          embedded_deps_before_deletion=$(detect_embedded_dependencies "$command")

          if rm "$command"; then
            log "SUCCESS" "Removed: $(basename "$command")"
            ((removed_count++))

            # Handle embedded dependencies for this specific deletion
            if [[ -n "$embedded_deps_before_deletion" ]]; then
              local target_dir
              target_dir=$(get_target_directory)
              local claude_root
              claude_root=$(dirname "$target_dir")

              handle_embedded_dependencies_on_delete "$command" "$claude_root" "$embedded_deps_before_deletion"
            fi

            # Unified cleanup after file removal
            unified_cleanup_after_file_removal "$command" "individual"
          else
            log "ERROR" "Failed to remove: $(basename "$command")"
            ((failed_count++))
          fi
        else
          log "WARNING" "Command file not found (already removed?): $(basename "$command")"
        fi
      done

      # Final comprehensive cleanup after bulk deletion
      if [[ $removed_count -gt 0 ]]; then
        echo
        echo "🧹 Performing final cleanup after bulk deletion..."

        local target_dir
        target_dir=$(get_target_directory)
        local claude_root
        claude_root=$(dirname "$target_dir")

        # Comprehensive directory cleanup
        cleanup_empty_directories_comprehensive "$claude_root"
      fi

      # Summary
      if [[ $failed_count -eq 0 ]]; then
        log "SUCCESS" "All $removed_count commands removed successfully"
      else
        log "WARNING" "Removed $removed_count commands, failed to remove $failed_count commands"
      fi

      log "SUCCESS" "Backup available at: $backup_dir"

      # Ask about backup cleanup for removal operations with secure confirmation
      echo
      echo -e "${COLOR_BLUE}🗑️  Backup Cleanup:${COLOR_RESET}"
      echo -e "${COLOR_BLUE}The backup directory contains copies of your removed commands:${COLOR_RESET}"
      echo -e "${COLOR_BLUE}📦  $backup_dir${COLOR_RESET}"
      echo

      read -rp "Remove backup directory now? [yes/no]: " cleanup_choice
      cleanup_choice=$(normalize_input "$cleanup_choice")

      if [[ "$cleanup_choice" == "$YES" ]]; then
        echo
        echo -e "${COLOR_RED}⚠️  DESTRUCTIVE ACTION WARNING ⚠️${COLOR_RESET}"
        echo -e "${COLOR_RED}This will permanently delete the backup directory and all its contents.${COLOR_RESET}"
        echo -e "${COLOR_YELLOW}📁 Directory: $backup_dir${COLOR_RESET}"
        echo -e "${COLOR_RED}🚨 These removed command backups will be lost forever!${COLOR_RESET}"
        echo
        echo -e "${COLOR_YELLOW}To confirm deletion, type exactly: ${COLOR_RESET}${COLOR_RED}REMOVE BACKUP${COLOR_RESET}"

        local retry_count=0
        local max_retries=3
        local confirmation_success=false

        while [[ $retry_count -lt $max_retries ]]; do
          read -rp "Confirmation (attempt $((retry_count + 1))/$max_retries): " confirmation

          if [[ "$confirmation" == "REMOVE BACKUP" ]]; then
            confirmation_success=true
            break
          else
            ((retry_count++))
            if [[ $retry_count -lt $max_retries ]]; then
              echo -e "${COLOR_YELLOW}❌ Incorrect confirmation. Please type exactly: ${COLOR_RED}REMOVE BACKUP${COLOR_RESET}"
            fi
          fi
        done

        if [[ "$confirmation_success" == true ]]; then
          if rm -rf "$backup_dir"; then
            echo -e "${COLOR_GREEN}✅ Backup directory removed: $backup_dir${COLOR_RESET}"
            log "SUCCESS" "Backup directory removed: $backup_dir"
          else
            echo -e "${COLOR_RED}❌ Failed to remove backup directory: $backup_dir${COLOR_RESET}"
            log "ERROR" "Failed to remove backup directory: $backup_dir"
          fi
        else
          echo -e "${COLOR_RED}🛡️  Maximum retries exceeded - deletion cancelled for security${COLOR_RESET}"
          log "WARNING" "Backup deletion cancelled - maximum confirmation retries exceeded"
          log "INFO" "Backup preserved at: $backup_dir"
        fi
      else
        log "INFO" "Backup preserved at: $backup_dir"
      fi
      break

    elif [[ "$confirm" == "$NO" ]]; then
      log "INFO" "Removal cancelled by user"
      log "INFO" "Backup directory preserved: $backup_dir"
      break
    else
      log "ERROR" "Invalid input. Please enter 'yes' or 'no'."
      ((retries++))
      if [[ $retries -ge $MAX_RETRIES ]]; then
        log "ERROR" "Maximum retries reached. Cancelling removal..."
        break
      fi
    fi
  done
}

# =============================================================================
# Utility Functions
# =============================================================================

get_target_directory() {
  case "$SELECTED_SCOPE" in
    "project")
      echo "$PROJECT_COMMANDS_DIR"
      ;;
    "global")
      echo "$CLAUDE_GLOBAL_COMMANDS_DIR"
      ;;
    *)
      echo ""
      ;;
  esac
}

list_commands_in_directory() {
  local dir="$1"
  local indent="${2:-}"

  if [[ ! -d "$dir" ]]; then
    echo "${indent}❌ Directory not found: $dir"
    return $FAILURE
  fi

  local total_count=0

  # List by category (excluding documentation directories)
  for category_path in "$dir"/*; do
    if [[ -d "$category_path" ]]; then
      local category
      category=$(basename "$category_path")

      # Skip excluded directories
      if is_directory_excluded "$category"; then
        continue
      fi

      local category_dir="$category_path"
      local commands=()
      while IFS= read -r -d '' file; do
        commands+=("$file")
      done < <(find "$category_dir" -name "*.md" -type f -print0 2>/dev/null)

      if [[ ${#commands[@]} -gt 0 ]]; then
        echo "${indent}📁 $category/ (${#commands[@]} commands):"
        for cmd in "${commands[@]}"; do
          local cmd_name
          cmd_name=$(basename "$cmd" .md)
          local subcategory
          subcategory=$(basename "$(dirname "$cmd")")
          if [[ "$subcategory" != "$category" ]]; then
            echo "${indent}   • $cmd_name ($subcategory)"
          else
            echo "${indent}   • $cmd_name"
          fi
        done
        total_count=$((total_count + ${#commands[@]}))
      fi
    fi
  done

  if [[ $total_count -eq 0 ]]; then
    echo "${indent}📭 No commands found"
  else
    echo "${indent}📊 Total: $total_count commands"
  fi
}

# Description: Normalize user input with enhanced portability
# Parameters:
#   $1 - input: User input to normalize
# Returns: Normalized input
normalize_input() {
  local input="$1"
  # Convert to lowercase using tr for maximum compatibility
  local lowercase_input
  if command -v tr >/dev/null 2>&1; then
    lowercase_input=$(echo "$input" | tr '[:upper:]' '[:lower:]')
  else
    # Fallback for systems without tr (extremely rare)
    lowercase_input="$input"
    case "$input" in
      [Yy]*) lowercase_input="y" ;;
      [Nn]*) lowercase_input="n" ;;
    esac
  fi

  case "$lowercase_input" in
    y|yes|true|1) echo "$YES" ;;
    n|no|false|0) echo "$NO" ;;
    *) echo "$input" ;;
  esac
}

# Description: Enhanced logging with cross-platform timestamp support
# Parameters:
#   $1 - prefix: Log level (INFO, SUCCESS, ERROR, WARNING)
#   $2 - message: Log message
log() {
  local prefix="$1"
  local message="$2"
  local color=""
  local timestamp

  # Set color for specific log types
  case "$prefix" in
    "INFO") color="$COLOR_BLUE" ;;
    "SUCCESS") color="$COLOR_GREEN" ;;
    "ERROR") color="$COLOR_RED" ;;
    "WARNING") color="$COLOR_YELLOW" ;;
  esac

  # Portable timestamp generation
  if command -v date >/dev/null 2>&1; then
    # Try ISO format first, fall back to basic format
    timestamp=$(date '+%Y-%m-%d %H:%M:%S' 2>/dev/null || date 2>/dev/null || echo "Time unavailable")
  else
    # Fallback for systems without date command (extremely rare)
    timestamp="Time unavailable"
  fi

  printf "${color}[%s] [%s]: %s${COLOR_RESET}\n" "$prefix" "$timestamp" "$message"
}

display_completion_summary() {
  echo
  echo "════════════════════════════════════════════════════════════════"
  log "SUCCESS" "Command management operation completed!"
  echo
  log "INFO" "Operation Summary:"
  log "INFO" "  • Action: $SELECTED_ACTION"
  log "INFO" "  • Scope: $SELECTED_SCOPE"
  log "INFO" "  • Target: $(get_target_directory)"
  echo
  log "INFO" "Thank you for using $SCRIPT_NAME!"
  echo
}

# =============================================================================
# Directory Filtering Utilities
# =============================================================================

is_directory_excluded() {
  local dir_name="$1"

  for excluded in "${EXCLUDED_DIRS[@]}"; do
    if [[ "$dir_name" == "$excluded" ]]; then
      return 0  # Directory is excluded
    fi
  done

  return 1  # Directory is not excluded
}

# =============================================================================
# Script Execution
# =============================================================================

# Execute main function with all arguments
main "$@"
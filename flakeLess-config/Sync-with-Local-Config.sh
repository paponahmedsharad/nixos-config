#!/bin/sh

file_or_dir_to_copy=(
  # "$HOME/.config/home-manager"
  # "/etc/nixos/"
  # "$HOME/repo/nixos-config/home-manager"
  # "$HOME/repo/nixos-config/nixos"
  "../nixos"
  "../home-manager"
)
destination="."

# ANSI escape sequences for text colors
GREEN='\033[0;32m'  # File
BLUE='\033[0;34m'   # Directory
RED='\033[0;31m'    # Error
MAGENTA='\033[0;35m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'     # Reset text color

copied_files=0
skipped_files=0

printf "\n"

## Copy files and Directory
for ((i = 0; i < ${#file_or_dir_to_copy[@]}; i++)); do
  source_path="${file_or_dir_to_copy[$i]}"

  if [ -e "$source_path" ]; then
    cp -r "$source_path" "$destination"
    file_name=$(basename "$source_path")

    if [ -f "$destination/$file_name" ]; then
      printf "${MAGENTA}%02d. ${YELLOW}%s${RESET} %*s ${MAGENTA}➜ ${RESET}Copied\n" $((i + 1)) "$file_name" $((50 - ${#file_name})) ''
      ((copied_files++))
    elif [ -d "$destination/$file_name" ]; then
      printf "${MAGENTA}%02d. ${BLUE}%s${RESET} %*s ${CYAN}➜ ${RESET}Copied\n" $((i + 1)) "$file_name" $((50 - ${#file_name})) ''
      ((copied_files++))
    fi
  else
    printf "${MAGENTA}%02d. ${RED}%s${RESET} %*s ${CYAN}➜ ${CYAN}Skipping ${CYAN}(does not exist)\n" $((i + 1)) "$source_path" $((50 - ${#source_path})) ''
    ((skipped_files++))
  fi
done


## Summary
printf  "\n${CYAN}─────────────────────────────────────────────────────────────────"
printf "\n${MAGENTA}Summary:${RESET} Copied: ${YELLOW}%d${RESET}, Skipped: ${YELLOW}%d${RESET}\n" "$copied_files" "$skipped_files"
printf  "${CYAN}─────────────────────────────────────────────────────────────────"

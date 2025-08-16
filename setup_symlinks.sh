#!/bin/bash

# Script to create symlinks for product_catalog.json and images folder
# Usage: ./setup_symlinks.sh <target_directory>

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if argument is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No directory specified${NC}"
    echo "Usage: $0 <target_directory>"
    echo "Example: $0 ../my-project"
    exit 1
fi

# Get the target directory from argument
TARGET_DIR="$1"

# Get the absolute path of the project root (where this script is located)
PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"

# Source files
SOURCE_CATALOG="$PROJECT_ROOT/product_catalog.json"
SOURCE_IMAGES="$PROJECT_ROOT/images"

# Check if source files exist
if [ ! -f "$SOURCE_CATALOG" ]; then
    echo -e "${RED}Error: product_catalog.json not found in project root${NC}"
    echo "Expected location: $SOURCE_CATALOG"
    exit 1
fi

if [ ! -d "$SOURCE_IMAGES" ]; then
    echo -e "${RED}Error: images folder not found in project root${NC}"
    echo "Expected location: $SOURCE_IMAGES"
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}Target directory doesn't exist. Creating: $TARGET_DIR${NC}"
    mkdir -p "$TARGET_DIR"
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error: Failed to create target directory${NC}"
        exit 1
    fi
fi

# Get absolute path of target directory
TARGET_ABS="$(cd "$TARGET_DIR" && pwd)"

# Target paths for symlinks
TARGET_CATALOG="$TARGET_ABS/product_catalog.json"
TARGET_IMAGES="$TARGET_ABS/images"

# Function to calculate relative path
# Works on both Linux and macOS
get_relative_path() {
    local source="$1"
    local target="$2"
    
    # Try using realpath if available
    if command -v realpath >/dev/null 2>&1; then
        realpath --relative-to="$target" "$source" 2>/dev/null && return
    fi
    
    # Fallback: manual calculation
    # Convert to arrays
    IFS='/' read -ra source_parts <<< "$source"
    IFS='/' read -ra target_parts <<< "$target"
    
    # Find common prefix length
    common_length=0
    for ((i=0; i<${#source_parts[@]} && i<${#target_parts[@]}; i++)); do
        if [ "${source_parts[$i]}" != "${target_parts[$i]}" ]; then
            break
        fi
        ((common_length++))
    done
    
    # Build relative path
    rel_path=""
    
    # Add ../ for each directory level up from target to common ancestor
    for ((i=common_length; i<${#target_parts[@]}; i++)); do
        if [ -n "${target_parts[$i]}" ]; then
            rel_path="../$rel_path"
        fi
    done
    
    # Add the path from common ancestor to source
    for ((i=common_length; i<${#source_parts[@]}; i++)); do
        if [ -n "${source_parts[$i]}" ]; then
            rel_path="$rel_path${source_parts[$i]}"
            if [ $i -lt $((${#source_parts[@]}-1)) ]; then
                rel_path="$rel_path/"
            fi
        fi
    done
    
    # Remove trailing slash if present
    echo "${rel_path%/}"
}

# Calculate relative paths from target directory to source files
REL_CATALOG=$(get_relative_path "$SOURCE_CATALOG" "$TARGET_ABS")
REL_IMAGES=$(get_relative_path "$SOURCE_IMAGES" "$TARGET_ABS")

# Display what will be created
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Symlink Setup Configuration${NC}"
echo -e "${BLUE}========================================${NC}"
echo
echo -e "${GREEN}Project Root:${NC} $PROJECT_ROOT"
echo -e "${GREEN}Target Directory:${NC} $TARGET_ABS"
echo
echo -e "${YELLOW}The following symlinks will be created:${NC}"
echo -e "  1. ${BLUE}product_catalog.json${NC} -> ${GREEN}$REL_CATALOG${NC}"
echo -e "     (in $TARGET_ABS)"
echo
echo -e "  2. ${BLUE}images${NC} -> ${GREEN}$REL_IMAGES${NC}"
echo -e "     (in $TARGET_ABS)"
echo
echo -e "${BLUE}========================================${NC}"

# Check if symlinks already exist
EXISTING_LINKS=""
if [ -L "$TARGET_CATALOG" ] || [ -e "$TARGET_CATALOG" ]; then
    EXISTING_LINKS="${EXISTING_LINKS}  - product_catalog.json\n"
fi
if [ -L "$TARGET_IMAGES" ] || [ -e "$TARGET_IMAGES" ]; then
    EXISTING_LINKS="${EXISTING_LINKS}  - images\n"
fi

if [ -n "$EXISTING_LINKS" ]; then
    echo -e "${RED}Error: The following items already exist in target directory:${NC}"
    echo -e "$EXISTING_LINKS"
    echo -e "${YELLOW}Please remove them manually before running this script.${NC}"
    echo
    exit 1
fi

# Ask for confirmation
read -p "Are you sure? (y/N): " -n 1 -r
echo # Move to a new line

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Operation cancelled by user${NC}"
    exit 0
fi

echo
echo -e "${BLUE}Creating symlinks...${NC}"

# Move to target directory to create relative symlinks
cd "$TARGET_ABS"

# Create symlink for product_catalog.json
ln -s "$REL_CATALOG" "product_catalog.json"
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Created symlink: product_catalog.json -> $REL_CATALOG${NC}"
else
    echo -e "${RED}✗ Failed to create symlink: product_catalog.json${NC}"
    exit 1
fi

# Create symlink for images folder
ln -s "$REL_IMAGES" "images"
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Created symlink: images -> $REL_IMAGES${NC}"
else
    echo -e "${RED}✗ Failed to create symlink: images${NC}"
    exit 1
fi

echo
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Success! Relative symlinks created${NC}"
echo -e "${GREEN}========================================${NC}"
echo
echo -e "You can now use the outfit mixer in: ${BLUE}$TARGET_ABS${NC}"
echo -e "Place your ${YELLOW}outfit-mixer.html${NC} file there and it will have access to:"
echo -e "  • product_catalog.json (via $REL_CATALOG)"
echo -e "  • images/ (via $REL_IMAGES)"
echo
echo -e "${GREEN}These symlinks use relative paths and can be committed to Git!${NC}"
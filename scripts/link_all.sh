#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"
DESTINATION="$HOME"

FILES=(
)

info() {
    echo -e "\033[0;34m$*\033[0m"
}

success() {
    echo -e "\033[0;32m$*\033[0m"
}

warning() {
    echo -e "\033[0;33m$*\033[0m"
}

error() {
    echo -e "\033[0;31m$*\033[0m"
}

link_file() {
    local source="$1"
    local target="$2"

    if [ ! -e "$source" ]; then
        error "File not found: $source"
        return 1
    fi

    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
            info "Link exists: $target"
            return 0
        fi
        local backup="$target.backup.$(date +%Y%m%d%H%M%S)"
        warning "Replace existing file, backup saved to: $backup"
        mv "$target" "$backup" || {
            error "Failed to create backup: $backup"
            return 1
        }
    fi
    
    ln -s "$source" "$target" || {
        error "Link failed: $target -> $source"
        return 1
    }

    success "Linked: $target -> $source"
    return 0
}

main() {
    info "Linking dotfiles..."
    info "Source: $DOTFILES_DIR"
    info "Target: $DESTINATION"

    for file in "${FILES[@]}"; do
        local src=$(echo "$file" | awk '{print $1}')
        local tar=$(echo "$file" | awk '{print $2}')

        local source_path="$DOTFILES_DIR/$src"
        local target_path="$DESTINATION/$tar"

        link_file "$source_path" "$target_path"
    done

    success "All done"
}

main

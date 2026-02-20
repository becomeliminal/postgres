#!/bin/bash

REQUIRED_TOOLS=("gcc" "make" "automake" "autoconf" "flex" "bison" "perl" "pkg-config")
MISSING_TOOLS=()

if [[ "$(uname)" == "Darwin" ]]; then
    # macOS - use Homebrew
    BREW_PACKAGES=("icu4c" "readline")
    MISSING_BREW=()

    for tool in "${REQUIRED_TOOLS[@]}"; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            MISSING_TOOLS+=("$tool")
        fi
    done

    for pkg in "${BREW_PACKAGES[@]}"; do
        if ! brew list "$pkg" >/dev/null 2>&1; then
            MISSING_BREW+=("$pkg")
        fi
    done

    if [ ${#MISSING_TOOLS[@]} -eq 0 ] && [ ${#MISSING_BREW[@]} -eq 0 ]; then
        echo "All required tools and libraries are already installed."
        exit 0
    fi

    if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
        echo "The following tools are missing:"
        for tool in "${MISSING_TOOLS[@]}"; do
            echo "  - $tool"
        done
    fi

    if [ ${#MISSING_BREW[@]} -gt 0 ]; then
        echo "The following Homebrew packages are missing:"
        for pkg in "${MISSING_BREW[@]}"; do
            echo "  - $pkg"
        done
    fi

    echo ""
    read -p "Do you want to install the missing tools and libraries? (Y/n): " confirm
    confirm=${confirm:-Y}

    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Installation aborted."
        exit 1
    fi

    echo "Installing missing dependencies via Homebrew..."
    ALL_MISSING=("${MISSING_TOOLS[@]}" "${MISSING_BREW[@]}")
    if [ ${#ALL_MISSING[@]} -gt 0 ]; then
        brew install "${ALL_MISSING[@]}"
    fi
else
    # Linux - use apt-get
    REQUIRED_LIBS=("libicu-dev" "libreadline-dev")
    MISSING_LIBS=()

    for tool in "${REQUIRED_TOOLS[@]}"; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            MISSING_TOOLS+=("$tool")
        fi
    done

    for lib in "${REQUIRED_LIBS[@]}"; do
        if ! dpkg -s "$lib" >/dev/null 2>&1; then
            MISSING_LIBS+=("$lib")
        fi
    done

    if [ ${#MISSING_TOOLS[@]} -eq 0 ] && [ ${#MISSING_LIBS[@]} -eq 0 ]; then
        echo "All required tools and libraries are already installed."
        exit 0
    fi

    if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
        echo "The following tools are missing:"
        for tool in "${MISSING_TOOLS[@]}"; do
            echo "  - $tool"
        done
    fi

    if [ ${#MISSING_LIBS[@]} -gt 0 ]; then
        echo "The following libraries are missing:"
        for lib in "${MISSING_LIBS[@]}"; do
            echo "  - $lib"
        done
    fi

    echo ""
    read -p "Do you want to install the missing tools and libraries? (Y/n): " confirm
    confirm=${confirm:-Y}

    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Installation aborted."
        exit 1
    fi

    echo "Installing missing dependencies via apt-get..."
    sudo apt-get update
    if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
        sudo apt-get install -y "${MISSING_TOOLS[@]}"
    fi
    if [ ${#MISSING_LIBS[@]} -gt 0 ]; then
        sudo apt-get install -y "${MISSING_LIBS[@]}"
    fi
fi

echo "All tools and libraries have been installed successfully!"

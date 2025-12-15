#!/usr/bin/env bash
set -e

OMZ_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$OMZ_DIR/custom"
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
FONT_NAME="MesloLGS NF"
P10K_CONFIG="$HOME/.p10k.zsh"
P10K_BACKUP="$HOME/.p10k.zsh.backup.$(date +%Y%m%d%H%M%S)"

OS="$(uname -s)"

report=()

print_header() {
  echo
  echo "Zsh + Oh My Zsh + Powerlevel10k Setup"
  echo "===================================="
  echo
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

check_zsh() {
  if ! command_exists zsh; then
    echo "Zsh not found."
    if [[ "$OS" == "Darwin" ]]; then
      echo "Install via:"
      echo "  brew install zsh"
    else
      echo "Install via your package manager (apt, dnf, pacman)."
    fi
    exit 1
  fi
  report+=("Zsh: installed")
}

install_ohmyzsh() {
  if [[ -d "$OMZ_DIR" ]]; then
    report+=("Oh My Zsh: already installed")
    return
  fi

  echo "Installing Oh My Zsh (official installer)..."
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  report+=("Oh My Zsh: installed")
}

install_powerlevel10k() {
  if [[ -d "$P10K_DIR" ]]; then
    report+=("Powerlevel10k: already installed")
    return
  fi

  echo "Installing Powerlevel10k..."
  git clone --depth=1 \
    https://github.com/romkatv/powerlevel10k.git \
    "$P10K_DIR"

  report+=("Powerlevel10k: installed")
}

apply_compact_p10k_preset() {
  if [[ -f "$P10K_CONFIG" ]]; then
    cp "$P10K_CONFIG" "$P10K_BACKUP"
    report+=("Powerlevel10k config backed up to $P10K_BACKUP")
  fi

  cp p10k/.p10k.zsh ~/
  report+=("Powerlevel10k: compact productivity preset applied")
}

configure_zshrc() {
  local zshrc="$HOME/.zshrc"

  if [[ ! -f "$zshrc" ]]; then
    touch "$zshrc"
  fi

  if ! grep -q "powerlevel10k.zsh-theme" "$zshrc"; then
    sed -i.bak \
      's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' \
      "$zshrc" 2>/dev/null || \
      echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$zshrc"

    report+=("Zsh theme: Powerlevel10k set")
  else
    report+=("Zsh theme: already configured")
  fi
}

install_font_notice() {
  echo
  echo "Font installation required (manual step):"
  echo
  echo "Recommended font:"
  echo "  MesloLGS Nerd Font"
  echo
  echo "Download from:"
  echo "  https://github.com/ryanoasis/nerd-fonts/releases"
  echo
  echo "After installing:"
  echo "- Set your terminal font to 'MesloLGS NF'"
  echo "- Restart terminal"
  echo
  report+=("Font: MesloLGS Nerd Font (manual install required)")
}

status() {
  echo "Status:"
  [[ -d "$OMZ_DIR" ]] && echo "✔ Oh My Zsh" || echo "✘ Oh My Zsh"
  [[ -d "$P10K_DIR" ]] && echo "✔ Powerlevel10k" || echo "✘ Powerlevel10k"
  command_exists zsh && echo "✔ Zsh" || echo "✘ Zsh"
}

print_report() {
  echo
  echo "Report"
  echo "------"
  for item in "${report[@]}"; do
    echo "- $item"
  done
  echo
}

# ------------ZSH PLUGIN INSTALL-------------- #
# --- Zsh custom directory ---
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# --- Helper: install plugin from upstream ---
install_zsh_plugin() {
    local name="$1"
    local repo="$2"
    local dir="$ZSH_CUSTOM/plugins/$name"

    if [[ -d "$dir" ]]; then
        echo "✔ $name already installed"
    else
        echo "Installing $name..."
        git clone --depth=1 "$repo" "$dir"
    fi
}


# Add config to .zshrc
ZSHRC="$HOME/.zshrc"

ZSH_CONFIG_BLOCK=$(cat <<'EOF'
# >>> macos-config zsh setup >>>

# Zsh plugin configuration (managed by macos-config)


# History substring search keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# Accept autosuggestion with TAB if available
bindkey '^I' autosuggest-accept

# Autosuggestions tuning
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

# <<< macos-config zsh setup <<<
EOF
)

update_zshrc() {
    echo "Updating ~/.zshrc ..."

    # Create .zshrc if missing
    if [[ ! -f "$ZSHRC" ]]; then
        touch "$ZSHRC"
        echo "Created ~/.zshrc"
    fi

    # ------- INSTALLING ZSH PLUGIN --------#
    echo "Installing Zsh plugins..."

    install_zsh_plugin zsh-autosuggestions \
        https://github.com/zsh-users/zsh-autosuggestions.git

    install_zsh_plugin zsh-history-substring-search \
        https://github.com/zsh-users/zsh-history-substring-search.git

    install_zsh_plugin zsh-syntax-highlighting \
        https://github.com/zsh-users/zsh-syntax-highlighting.git

    # --------------------------------------#

    # Remove existing managed block if present
    if grep -q ">>> macos-config zsh setup >>>" "$ZSHRC"; then
        echo "Existing macos-config block found, updating..."
        sed -i '' '/# >>> macos-config zsh setup >>>/,/# <<< macos-config zsh setup <<</d' "$ZSHRC"
    else
        echo "No existing macos-config block found, appending..."
    fi

    # Append updated block
    printf "\n%s\n" "$ZSH_CONFIG_BLOCK" >> "$ZSHRC"

    echo "Zsh configuration updated."

    echo ""
    echo "────────────────────────────────────────────"
    echo "MANUAL CONFIGURATION REQUIRED"
    echo "────────────────────────────────────────────"
    echo ""
    echo "This script does NOT edit your Oh My Zsh plugin list."
    echo ""
    echo "To enable recommended plugins, edit ~/.zshrc and ensure:"
    echo ""
    echo "  plugins=("
    echo "    git"
    echo "    zsh-autosuggestions"
    echo "    zsh-history-substring-search"
    echo "    zsh-syntax-highlighting"
    echo "  )"
    echo ""
    echo "IMPORTANT:"
    echo "• This must be placed BEFORE:"
    echo "    source \$ZSH/oh-my-zsh.sh"
    echo ""
    echo "Then restart Zsh with:"
    echo "  exec zsh"
    echo ""
    echo "────────────────────────────────────────────"

}


# ------------ZSH PLUGIN INSTALL-------------- #

### ENTRY POINT ###

print_header

case "$1" in
  install)
    check_zsh
    install_ohmyzsh
    install_powerlevel10k
    configure_zshrc
    install_font_notice
    ;;
  reconfigure)
    if [[ ! -d "$P10K_DIR" ]]; then
      echo "Powerlevel10k is not installed. Run install first."
      exit 1
    fi

    echo
    echo "Reconfigure Zsh / Powerlevel10k"
    echo "--------------------------------"
    echo "Choose an option:"
    echo "1) Interactive Powerlevel10k configuration (recommended for first-time users)"
    echo "2) Apply compact productivity preset (one-line, fast, minimal)"
    echo "3) Cancel"
    echo

    read -r -p "Enter choice [1-3]: " choice

    case "$choice" in
      1)
        report+=("Powerlevel10k: interactive reconfiguration started")
        echo "Starting Powerlevel10k configuration wizard..."
        zsh -i -c 'p10k configure'
        ;;
      2)
        apply_compact_p10k_preset
        ;;
      *)
        echo "Cancelled."
        exit 0
        ;;
    esac
    ;;
  plugins-only)
    update_zshrc
    ;;
  status)
    status
    exit 0
    ;;
  *)
    echo "Usage:"
    echo "  $0 install"
    echo "  $0 reconfigure"
    echo "  $0 plugins-only"
    echo "  $0 status"
    exit 1
    ;;
esac

print_report

echo "Restart your terminal to apply changes."

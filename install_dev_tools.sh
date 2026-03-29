#!/bin/bash

# ============================================================
# install_dev_tools.sh
# Installs development tools on Debian/Ubuntu-based Linux:
# - Docker
# - Docker Compose plugin
# - Python 3.9+
# - Django via pip
#
# The script checks whether each tool is already installed
# to avoid duplicate installation.
# ============================================================

set -euo pipefail

# ---------- Output colors ----------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ---------- Logging helpers ----------
log_info() {
    echo -e "${BLUE}[INFO]${NC}  $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC}    $1"
}

log_skip() {
    echo -e "${YELLOW}[SKIP]${NC}  $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# ---------- Environment checks ----------
check_root_privileges() {
    # The script must be run with root privileges
    if [[ "$EUID" -ne 0 ]]; then
        log_error "Run this script with root privileges: sudo ./install_dev_tools.sh"
    fi
}

check_linux_environment() {
    # Ensure the script is running on Linux
    if [[ "$(uname -s)" != "Linux" ]]; then
        log_error "Unsupported operating system. This script works only on Linux."
    fi
}

check_apt_package_manager() {
    # Ensure apt-get is available
    if ! command -v apt-get >/dev/null 2>&1; then
        log_error "Unsupported Linux distribution. This script requires apt-get (Debian/Ubuntu-based systems)."
    fi
}

detect_distribution_id() {
    # Read distribution ID from /etc/os-release
    if [[ -r /etc/os-release ]]; then
        . /etc/os-release
        echo "${ID:-unknown}"
    else
        echo "unknown"
    fi
}

detect_distribution_codename() {
    # Read distribution codename from /etc/os-release or lsb_release
    if [[ -r /etc/os-release ]]; then
        . /etc/os-release
        if [[ -n "${VERSION_CODENAME:-}" ]]; then
            echo "$VERSION_CODENAME"
            return
        fi
    fi

    if command -v lsb_release >/dev/null 2>&1; then
        lsb_release -cs
        return
    fi

    echo ""
}

update_package_index() {
    # Refresh package lists
    log_info "Updating package index..."
    apt-get update -qq
    log_success "Package index updated."
}

# ---------- Docker installation ----------
install_docker() {
    if command -v docker >/dev/null 2>&1; then
        log_skip "Docker is already installed: $(docker --version)"
        return
    fi

    log_info "Installing Docker dependencies..."
    apt-get install -y -qq ca-certificates curl gnupg lsb-release

    log_info "Adding Docker GPG key..."
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/$(detect_distribution_id)/gpg \
        | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    local distro_id
    local distro_codename
    local architecture

    distro_id="$(detect_distribution_id)"
    distro_codename="$(detect_distribution_codename)"
    architecture="$(dpkg --print-architecture)"

    if [[ "$distro_id" != "ubuntu" && "$distro_id" != "debian" ]]; then
        log_error "Docker repository setup supports only Ubuntu or Debian."
    fi

    if [[ -z "$distro_codename" ]]; then
        log_error "Could not detect distribution codename."
    fi

    log_info "Adding Docker repository..."
    echo \
        "deb [arch=${architecture} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/${distro_id} ${distro_codename} stable" \
        > /etc/apt/sources.list.d/docker.list

    apt-get update -qq

    log_info "Installing Docker..."
    apt-get install -y -qq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    systemctl enable --now docker
    log_success "Docker installed successfully: $(docker --version)"
}

# ---------- Docker Compose installation ----------
install_docker_compose() {
    # Check Docker Compose v2 plugin
    if docker compose version &>/dev/null; then
        log_skip "Docker Compose plugin already available: $(docker compose version)"
        return
    fi

    # Try installing plugin (Ubuntu/Debian)
    if apt-get install -y -qq docker-compose-plugin 2>/dev/null; then
        log_success "Docker Compose plugin installed: $(docker compose version)"
        return
    fi

    # Fallback for Kali or other systems
    log_info "docker-compose-plugin not available, installing legacy docker-compose..."
    apt-get install -y -qq docker-compose
    log_success "Docker Compose installed: $(docker-compose --version)"
}

# ---------- Python installation ----------
install_python() {
    local minimum_version="3.9"

    if command -v python3 >/dev/null 2>&1; then
        local current_version
        current_version=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')

        if [[ "$(printf '%s\n' "$minimum_version" "$current_version" | sort -V | head -n1)" == "$minimum_version" ]]; then
            log_skip "Python is already installed: $(python3 --version)"
            return
        else
            log_info "Detected Python $current_version, but version $minimum_version or newer is required."
        fi
    fi

    log_info "Installing Python 3, pip, and venv..."
    apt-get install -y -qq python3 python3-pip python3-venv
    log_success "Python installed successfully: $(python3 --version)"
}

# ---------- Django installation ----------
install_django() {
    if python3 -c "import django" >/dev/null 2>&1; then
        local django_version
        django_version=$(python3 -c "import django; print(django.__version__)")
        log_skip "Django is already installed: version $django_version"
        return
    fi

    log_info "Upgrading pip..."
    python3 -m pip install --upgrade pip -q --break-system-packages || true

    log_info "Installing Django..."
    if python3 -m pip install django -q 2>/dev/null; then
        log_success "Django installed successfully: $(python3 -c 'import django; print(django.__version__)')"
    else
        log_info "Standard installation failed, retrying with --break-system-packages..."
        python3 -m pip install django -q --break-system-packages
        log_success "Django installed successfully: $(python3 -c 'import django; print(django.__version__)')"
    fi
}

# ---------- Final summary ----------
print_installation_summary() {
    echo
    echo -e "${GREEN}================================================${NC}"
    echo -e "${GREEN}      Development tools installation complete   ${NC}"
    echo -e "${GREEN}================================================${NC}"
    echo "Docker:         $(docker --version 2>/dev/null || echo 'Not installed')"
    echo "Docker Compose: $(docker compose version 2>/dev/null || docker-compose --version 2>/dev/null || echo 'Not installed')"
    echo "Python:         $(python3 --version 2>/dev/null || echo 'Not installed')"
    echo "Django:         $(python3 -c 'import django; print(django.__version__)' 2>/dev/null || echo 'Not installed')"
    echo -e "${GREEN}================================================${NC}"
}

# ---------- Main function ----------
main() {
    check_linux_environment
    check_apt_package_manager
    check_root_privileges
    update_package_index
    install_docker
    install_docker_compose
    install_python
    install_django
    print_installation_summary
}

main "$@"
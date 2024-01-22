FROM archlinux:latest

SHELL ["/bin/bash", "-Eeuo", "pipefail", "-c"]

# Install dependencies
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm openssh && \
    rm -rf /var/cache/pacman/pkg/*

# Generate host key
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

# Add user
RUN useradd -r -d / -s /usr/bin/nologin -c "VPN user" backup && \
    export PASSWORD=$(tr -dc A-Za-z0-9 </dev/random | head -c 16) && \
    echo "backup:${PASSWORD}" | chpasswd && \
    echo "Credentials are: backup:${PASSWORD}" && \
    echo "Save it now"

COPY ./config/sshd_config /etc/ssh/sshd_config

EXPOSE 22
HEALTHCHECK --interval=5s --timeout=1s --start-period=1s --retries=3 CMD [ "lsof", "-i", ":22" ]
CMD ["/usr/sbin/sshd", "-eD"]

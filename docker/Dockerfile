FROM alpine:latest

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# Install dependencies
RUN apk add --no-cache openssh shadow

# Generate host key
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

# Add entrypoint creating users from mounted credentials file
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22
HEALTHCHECK --interval=5s --timeout=1s --start-period=1s --retries=3 CMD [ "lsof", "-i", ":22" ]
CMD ["/entrypoint.sh"]

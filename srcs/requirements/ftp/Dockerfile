FROM debian:11

# Install vsftpd (FTP server) and required tools
RUN apt update && apt install -y vsftpd \
    && rm -rf /var/lib/apt/lists/*

# Copy vsftpd configuration
COPY tools/vsftpd.conf /etc/vsftpd.conf

# Ensure the vsftpd secure chroot directory exists
RUN mkdir -p /var/run/vsftpd/empty && chmod 555 /var/run/vsftpd/empty


COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

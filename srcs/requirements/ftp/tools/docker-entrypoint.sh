#!/bin/bash

# Ensure FTP user exists
if ! id "$FTP_USER" &>/dev/null; then
    echo "Creating FTP user: $FTP_USER"
    useradd -m -d /var/www/html/ftp -s /bin/bash "$FTP_USER"
fi

echo "$FTP_USER:$FTP_PASS" | chpasswd

# Create the FTP directory inside /var/www/html/ and fix permissions
mkdir -p /var/www/html/ftp
chown -R "$FTP_USER:$FTP_USER" /var/www/html/ftp


# Start vsftpd
echo "Starting vsftpd..."
exec /usr/sbin/vsftpd /etc/vsftpd.conf

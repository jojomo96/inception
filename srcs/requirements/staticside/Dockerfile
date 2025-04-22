# Use Debian 11 as the base image
FROM debian:11

# Install nginx
RUN apt-get update && apt-get install -y nginx && apt-get clean

# Copy the static HTML file to the nginx default directory
COPY index.html /var/www/html/

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

FROM debian:11

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install dependencies
RUN apt-get update && \
    apt-get install -y \
        wget \
        openjdk-17-jdk \
        ghostscript \
        tesseract-ocr && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Download Stirling PDF JAR file
RUN wget -O Stirling-PDF.jar "https://github.com/Stirling-Tools/Stirling-PDF/releases/download/v0.40.1/Stirling-PDF.jar"

# Start the application
CMD ["java", "-jar", "/app/Stirling-PDF.jar"]

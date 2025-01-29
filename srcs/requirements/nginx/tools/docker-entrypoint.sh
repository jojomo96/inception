#!/bin/bash
openssl req \
			-x509 \
			-nodes \
			-days 365 \
			-newkey rsa:2048 \
			-keyout /etc/ssl/private/nginx-selfsigned.key \
			-out /etc/ssl/certs/nginx-selfsigned.crt \
			-subj "/C=DE/ST=BW/O=42HN"

nginx -g 'daemon off;'
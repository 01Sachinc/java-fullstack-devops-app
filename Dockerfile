# Use nginx:latest as the base image
FROM nginx:latest

# Copy index.html to the Nginx HTML directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

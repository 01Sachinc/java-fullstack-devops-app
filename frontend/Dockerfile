# -------------------------------------------------------------------
# DevOps Task Manager - Frontend Dockerfile
# -------------------------------------------------------------------

FROM nginx:stable-alpine

# Copy static assets into Nginx html directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

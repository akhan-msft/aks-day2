# Use the official Nginx image as a parent image
FROM nginx:alpine

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Create a new Nginx configuration file
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Create a simple "Hello World" HTML file
RUN echo '<!DOCTYPE html> \
<html> \
<head> \
    <title>Hello World</title> \
</head> \
<body> \
    <h1>Hello, World!</h1> \
</body> \
</html>' > /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
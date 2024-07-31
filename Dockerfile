# Use the latest Tomcat image from the official Docker repository
FROM tomcat:latest

# Set the maintainer label
LABEL maintainer="naveencl@gmail.com"

# Copy the WAR file to the Tomcat webapps directory
COPY abc.war /usr/local/tomcat/webapps/

# Expose port 8080 to be accessible outside the container
EXPOSE 8080

# Start Tomcat when the container starts
CMD ["catalina.sh", "run"]


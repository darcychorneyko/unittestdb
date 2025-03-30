# Use the official Microsoft SQL Server image from the Docker Hub
FROM mcr.microsoft.com/mssql/server:2022-latest

# Set environment variables
ENV MSSQL_PID=Express
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=_MySecretSAPassw0rd@@

# copy the inititialization scripts
COPY init/* /usr/src/app/init/

# Set execute permission for entrypoint script
# RUN chmod +x /usr/src/app/init/init.sh

# Expose the SQL Server port
EXPOSE 1433

# Start SQL Server
CMD "/usr/src/app/init/init.sh"
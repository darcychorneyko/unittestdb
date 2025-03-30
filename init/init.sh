#!/bin/bash

DB_INIT_FLAG="/var/opt/mssql/.db_initialized"

# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Get SQL Server process ID (PID)
SQL_PID=$!

if [ ! -f "$DB_INIT_FLAG" ]; then

    # Wait for SQL Server to be ready
    echo "Waiting for SQL Server to start..."
    until /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -Q "SELECT 1" &> /dev/null; do
        sleep 5
    done
    echo "SQL Server is up and running!"

    # Run the initialization script
    echo "Initializing the database..."
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -i /usr/src/app/init/init.sql
    touch "$DB_INIT_FLAG"
    echo "Database initialized successfully!"
else
    echo "Database initialization skipped (already done)."
fi

# Wait for SQL Server process to keep the container running
wait "$SQL_PID"
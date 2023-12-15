#!/bin/bash

# Change to the directory containing your SQL files
cd questoes

# Specify the log file
log_file="files/output.log"

# PostgreSQL connection details
host="localhost"
database="dojo"
username="postgres"  # Replace with your actual PostgreSQL username

# Prompt for the PostgreSQL password
read -sp "Enter PostgreSQL password: " pg_password
echo

# Loop through SQL files and execute them, capturing timing information
for i in {01..09}; do
    file="${i}.sql"  # Replace with your actual file prefix
    if [ -f "$file" ]; then
        echo "Running $file..."
        psql -h $host -d $database -U $username -W "$pg_password" -f "$file" -c "EXPLAIN ANALYZE" | tee -a "$log_file"
    else
        echo "$file not found."
    fi
done


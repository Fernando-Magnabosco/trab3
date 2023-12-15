#!/bin/bash

# Run the scripts in the specified order
echo "Running generate_log_files.py..."
python3 generate_log_files.py

# echo "Running sort_queries_by_execution_time.py..."
# python3 sort_queries_by_execution_time.py

echo "Running generate_statistics.py..."
python3 generate_statistics.py
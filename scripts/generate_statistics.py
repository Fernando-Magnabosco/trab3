import os
import psycopg2
import statistics
import csv
import re

# specify your PostgreSQL database connection details

# read the sorted_times.log file and get the 3 slowest queries
with open("../files/sorted_times.log", "r") as f:
    lines = f.readlines()
    slowest_queries = [line.split(":")[0] for line in lines[-3:]]

# for each slow query, run it 5 times and calculate the mean and standard deviation
results = []
for query in slowest_queries:
    times = []
    with open(f"../sql/{query.replace('.log', '.sql')}", "r") as f:
        sql_query = "EXPLAIN (ANALYSE, COSTS, TIMING, BUFFERS, WAL)" + f.read()
        for _ in range(5):
            os.system("sudo service postgresql stop")
            os.system('sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"')
            os.system("sudo service postgresql start")
            conn = psycopg2.connect(
                dbname="dojo",
                user="postgres",
                password="postgres",
                host="localhost",
                port="5432",
            )
            cur = conn.cursor()
            cur.execute(sql_query)
            result = (
                cur.fetchall()
            )  # fetch all rows to ensure the query is fully executed
            match = re.search(r"Execution Time: (\d+\.\d+) ms", result[-1][0])
            if match:
                execution_time = float(match.group(1))
                times.append(execution_time)
            cur.close()
        mean = statistics.mean(times)
        stdev = statistics.stdev(times)
        results.append((query, mean, stdev))

# write the results to a csv file
with open("../files/query_times_even_more_after_optimization.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["query", "mean", "stdev"])
    for result in results:
        writer.writerow(result)

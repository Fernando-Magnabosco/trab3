import os
import psycopg2

# specify the directory you want to start from
rootDir = "../sql"

for dirName, subdirList, fileList in os.walk(rootDir):
    for fname in fileList:
        if fname.endswith(".sql"):
            with open(os.path.join(dirName, fname), "r") as f:
                sql_query = "EXPLAIN (ANALYSE, COSTS, TIMING, BUFFERS, WAL)" + f.read()
                try:
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
                    rows = cur.fetchall()
                    log_file_name = f"../logs/even_more_after/{fname.split('.')[0]}.log"
                    with open(log_file_name, "w") as log_file:
                        log_file.write("\n".join([str(row) for row in rows]) + "\n")
                except Exception as e:
                    print(f"Error executing file {fname}: {e}")

conn.close()

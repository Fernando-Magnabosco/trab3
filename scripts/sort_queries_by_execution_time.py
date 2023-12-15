import os
import re

# specify the directory you want to start from
rootDir = '../logs/'

execution_times = []

for dirName, subdirList, fileList in os.walk(rootDir):
    for fname in fileList:
        if fname.endswith('.log'):
            with open(os.path.join(dirName, fname), 'r') as f:
                content = f.read()
                match = re.search(r'Execution Time: (\d+\.\d+) ms', content)
                if match:
                    execution_time = float(match.group(1))
                    execution_times.append((fname, execution_time))

# sort by execution time
execution_times.sort(key=lambda x: x[1])

# write to a file
with open('../files/sorted_times.log', 'w') as f:
    for fname, time in execution_times:
        f.write(f"{fname}: {time} ms\n")
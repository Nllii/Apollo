import os
import time

count= 0
while True:
    time.sleep(1)
    count += 1
    print("\033[1;31;40m")
    print(count)

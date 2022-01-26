"""Simple python function stores file to detect cold start."""
import os
import time
import json

def handle(req):
    """handle a request to the function
    Args:
        req (str): request body
    """
    start_time = time.process_time()

    data = json.loads(req)

    cold_start: bool = not os.path.exists("coldStart.txt")
    if cold_start:
        open("coldStart.txt", 'a').close() 

    data["timeIn"] = start_time
    data["coldStart"] = cold_start
    data["timeOut"] = time.process_time()
    return json.dumps(data)

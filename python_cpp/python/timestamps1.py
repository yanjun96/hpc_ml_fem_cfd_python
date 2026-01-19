def timestamp_to_seconds(tst):
    """
    >>> timestamp_to_seconds("1:01")
    61
    >>> timestamp_to_seconds("1:00:00")
    3600
    """
    # YOUR CODE HERE
    ################
    
    total = 0
    ts=tst.split(":")
    
    if   len(ts) == 1:
        total = int(ts[0])
    elif len(ts) == 2:
        total = int(ts[0])*60+int(ts[1])
    elif len(ts) == 3:
        total = int(ts[0])*3600+int(ts[1])*60+int(ts[2])
      
    return total 


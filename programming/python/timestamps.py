from timestamps1 import timestamp_to_seconds
from timestamps2 import seconds_to_timestamp

def sum_timestamps(l):
    """
    >>> sum_timestamps(['5:32', '4:48'])
    '10:20'
    >>> sum_timestamps(['03:10', '01:00'])
    '4:10'
    >>> sum_timestamps(['2:10', '1:59'])
    '4:09'
    >>> sum_timestamps(['15:32', '45:48'])
    '1:01:20'
    >>> sum_timestamps(['6:15:32', '2:45:48'])
    '9:01:20'
    >>> sum_timestamps(['6:35:32', '2:45:48', '40:10'])
    '10:01:30'
    """
    total = 0
    for ts in l:    
        total += timestamp_to_seconds(ts)
        
    total_as_timestamp = seconds_to_timestamp(total)
    return total_as_timestamp
    

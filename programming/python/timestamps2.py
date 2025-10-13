
def seconds_to_timestamp(seconds):
    """
    >>> seconds_to_timestamp(61)
    '1:01'
    >>> seconds_to_timestamp(3600)
    '1:00:00'
    """
    # YOUR CODE HERE
    ################
         
    hour = int(seconds/3600)
    minutes = int((seconds - hour*3600)/60)
    secondss = int(seconds - (hour*3600) - (minutes*60))
            
      
    if hour == 0:
        minutes = str(int(minutes)).zfill(1)
        secondss = str(int(secondss)).zfill(2)
        time = ':'.join([minutes,secondss])  
        return time 
    
    else:
        hour = str(int(hour))
        minutes = str(int(minutes)).zfill(2)
        secondss = str(int(secondss)).zfill(2)
        time = ':'.join([hour,minutes,secondss])  
        return time 
    
    

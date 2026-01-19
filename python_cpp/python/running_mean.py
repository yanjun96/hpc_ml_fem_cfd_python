def running_mean(sequence,decimal_places =0):
    """Calculate the running mean of the sequence passed in,
       returns a sequence of same length with the averages.
       You can assume all items in sequence are numeric."""
    # YOUR CODE HERE
    ################

    sum_so_far = 0
    running_means = []
       
    for i, value in enumerate(sequence,1):
        sum_so_far += value
        running_mean = round(sum_so_far / i, decimal_places)
        
        running_means.append(running_mean)
        
    return running_means

    

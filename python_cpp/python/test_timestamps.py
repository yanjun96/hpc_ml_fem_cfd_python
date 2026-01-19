import timestamps

# YOUR CODE HERE
################
def test_1():
    assert timestamps.timestamp_to_seconds("1:01") == 61
    assert timestamps.timestamp_to_seconds("1:00:00") == 3600
    
def test_seconds_to_timesttamps():
    assert timestamps.seconds_to_timestamp(61) == ("1:01")
    assert timestamps.seconds_to_timestamp(3600) == ("1:00:00")
    
def test_sum_timestamps():
    assert timestamps.sum_timestamps(['5:32', '4:48']) == '10:20'
    assert timestamps.sum_timestamps(['03:10', '01:00']) == '4:10'
    assert timestamps.sum_timestamps(['2:10', '1:59']) == '4:09'
    assert timestamps.sum_timestamps(['15:32', '45:48']) == '1:01:20'
    assert timestamps.sum_timestamps(['6:15:32', '2:45:48']) == '9:01:20'
    assert timestamps.sum_timestamps(['6:35:32', '2:45:48', '40:10']) == '10:01:30'
    # Add more test cases as needed
    
    

import pytest

from timestamps import sum_timestamps


# YOUR CODE HERE
################

@pytest.mark.parametrize("input_argument, expected_return", [
    (['5:32', '4:48'],str('10:20')),
    (['2:10', '1:59'],str('4:09')),
  
    
  ])

def test_running_mean(input_argument, expected_return):
    ret = sum_timestamps(input_argument)
    assert ret == expected_return





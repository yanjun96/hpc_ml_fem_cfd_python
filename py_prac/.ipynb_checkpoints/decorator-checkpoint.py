def plus1(f):
    def wrapper(*args, **kwargs):
        return f(*args, **kwargs)+1
    return wrapper


@plus1
def power(base,x):
    return base**x

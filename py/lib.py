""" Scratch Workspace """

from functools import wraps

def accepts(*types):
    def check_accepts(f):
        def new_f(*args, **kwds):
            assert len(types) == len(args), \
                "Argument count mismatch in %s" % (f.__name__)

            for (a, t) in zip(args, types):
                assert isinstance(a, t), \
                       "arg %r does not match %s" % (a,t)
            return f(*args, **kwds)
        new_f.__name__ = f.__name__
        return new_f
    return check_accepts


def returns(rtype):
    def check_returns(f):
        def new_f(*args, **kwds):
            result = f(*args, **kwds)
            assert isinstance(result, rtype), \
                   "return value %r does not match %s" % (result,rtype)
            return result
        new_f.__name__ = f.__name__
        return new_f
    return check_returns


@accepts(int)
@returns(int)
def square(x):
    return x * x

def main():
    print("hello world")
    print(square(4))

if __name__ == '__main__':
    main()

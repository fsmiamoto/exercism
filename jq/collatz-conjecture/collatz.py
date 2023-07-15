def steps(n):
    def steps_rec(n,steps):
        if n == 1:
            return steps
        if n % 2 == 0:
            return steps_rec(n/2,steps+1)
        else:
            return steps_rec(3*n+1,steps+1)
    return steps_rec(n,0)

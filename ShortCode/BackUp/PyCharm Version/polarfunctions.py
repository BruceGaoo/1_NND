import math


def generateU0(K):
    m = pow(2, K)
    U0 = []
    for i in range(m):
        u0 = list(bin(i))
        u = [0]*K
        u[K-len(u0)+2:] = u0[2:]
        for j in range(K):
            u[j] = int(u[j])
        U0.append(u)
    return U0


def generateU(U0,N,free_sets):
    U = []
    K = len(free_sets)
    for i in range(len(U0)):
        u = [0]*N
        for j in range(K):
            u[free_sets[j]-1] = U0[i][j]
        U.append(u)
    return U


def generateX0(U):
    X0 = []
    for u in U:
        x = encoder(u)
        X0.append(x)
    return X0


def encoder(u):
    N = len(u)
    n = int(math.log2(N))
    if n == 1:
        x = [(u[0]+u[1])%2]+[u[1]]
    else:
        x1 = encoder(mod2plus(u[:int(N/2)], u[int(N/2):]))
        x2 = encoder(u[int(N/2):])
        x = x1+x2
    return x


def mod2plus(a,b):
    c = [0]*len(a)
    for i in range(len(a)):
        c[i] = (a[i]+b[i]) % 2
    return c

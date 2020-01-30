#import math
import numpy as np
#import statistics
import random
import matplotlib.pyplot as plt

#t = [i for i in range(100)]
s = 2
dx = 0
j=0
l = [0 for j in range(101)]
#print(l)
#t = [2,4,6,8,10,12,14,16,18,20]
#m = l[0]

for i in range(0,100): #enumerate(l):
	y = random.randrange(1,10)	
	if y<5:
		w = -1
		dX = s*w
		l[i+1] = l[i]+dX
	else:
		w = 1
		dX = s*w
		l[i+1] = l[i]+dX
#	m2+= math.pow(l[i+1],2)
#	m += l[i+1]
	print(dX)
	print(l)
#print(m)
#print(m2)
m = np.mean(l)
#m2 = m2/len(l)
v = np.var(l)
#v = statistics.variance(l)
print("Mesi timi",m)
#print("Mesi timi tetragwno",m2)
print("Variance",v)

plt.plot(l)
plt.show()


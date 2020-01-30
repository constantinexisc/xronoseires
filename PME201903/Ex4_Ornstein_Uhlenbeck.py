import matplotlib.pyplot as plt
import numpy as np
from pandas.plotting import autocorrelation_plot
plt.rcParams['figure.figsize'] = [10, 5]

#Probably the implemantation is WRONG!
#Initialize parameters and generate 1000 random points from N(0,1) g works from 0 up to 1.2
s=2
g=0.5
positions = [0]
random_p = np.random.normal(0,1,1000)

#positions
for r in random_p:
    mv = -1 if r<0 else 1
    value = positions[-1]*(1-g) + s*mv
    positions.append(value)

fig1 = plt.figure(1)
fig1.suptitle('Positions')
plt.plot(positions)

fig2 = plt.figure(2)
fig2.suptitle('Autocorroletion plot')
autocorrelation_plot(positions)


#calc differences
diff1 = []
#calc differences with absolute values
diff2 = []

for i in range(1,len(positions)):
    value = positions[i] - positions[i-1]
    diff1.append(value)
for i in range(1,len(positions)):
    value = np.abs(positions[i] - positions[i-1])
    diff2.append(value)

fig3 = plt.figure(3)
fig3.suptitle('Differences')
plt.plot(diff1,'ro')
fig4 = plt.figure(4)
fig4.suptitle('Abs Differences')
plt.plot(diff2,'bo')
#calculate s
#s = E[diff2]
np.mean(diff2)

fig5 = plt.figure(5)
fig5.suptitle('Autocorroletion of Abs Differences')
autocorrelation_plot(diff2)

plt.show()
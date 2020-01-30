import matplotlib.pyplot as plt
import numpy as np
from pandas.plotting import autocorrelation_plot
plt.rcParams['figure.figsize'] = [10, 5]

#initialize the list
s=1
random_walk = [0]

#Generate 10000 numbers from a Normal Distribution N(0,1)
random_normal = np.random.normal(0,1,10000)

#Create the walk
for r in random_normal:
    mv = 1 if r>0 else -1
    value = random_walk[-1] + s*mv
    random_walk.append(value)
#plot the walk
fig1 = plt.figure(1)
fig1.suptitle("Random Walk Plot")
plt.plot(random_walk)

#plot the autocorrelation
fig2 = plt.figure(2)
fig2.suptitle("Autocorrelation of the random walk")
autocorrelation_plot(random_walk)

#Calculate the differences
diff = []
for i in range(1,len(random_walk)):
    value = random_walk[i] - random_walk[i-1]
    diff.append(value)

#plot the diffs
fig3 = plt.figure(3)
fig3.suptitle("Time Steps")
plt.plot(diff)

#plot the autocorelation of diff
fig4 = plt.figure(4)
fig4.suptitle("Autocorrelation of steps")
autocorrelation_plot(diff)
plt.show()

#mean(m) of the diffs should be close to the mean of the N(m,s^2)
np.mean(diff)

#Variance(s^2) of diffs should be close to the variance of N(m,s^2)
np.var(diff)

#General statistics: X a random variable with mean = E(X) and var = Var(X) then a*X is a random variable with mean E(a*X)=a*E(X)
#and variance Var(a*X) = a^2 * Var(X)
#So the noise of the random walk (s) should be s = a from the above variance

plt.show()

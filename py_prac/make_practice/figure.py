import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0,50,2000)
y = np.sin(x)

plt.plot(x,y,label="sine wave")
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Generated figure')
plt.legend()

plt.savefig('figures/plot.pdf')
print('Figre generated')

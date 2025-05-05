import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0,1,1000)
y = np.cos(x)

plt.plot(x,y,label="sine wave")
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Generated figure')
plt.legend()

plt.savefig('figures/figure.pdf')
print('Figre generated')

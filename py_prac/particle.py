
class Particle(object):
   """A particle is a constituent unit of the universe."""
   roar = "I am a particle!"


obs = []
obs.append(Particle())
obs[0].r = {'x': 100.0, 'y': 38.0, 'z': -42.0}
obs.append(Particle())
obs[1].r = {'x': 0.01, 'y': 99.0, 'z': 32.0}

print(obs[0].r)
print(obs[1].r)

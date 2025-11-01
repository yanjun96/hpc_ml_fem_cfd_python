"""
Simple 3D Python game using the Ursina engine

Requirements:
    pip install ursina

Run:
    python simple_3d_game.py

What it is:
    A single-file, minimal 3D collect-the-cubes game. Move with WASD, look with mouse,
    jump with space, collect glowing cubes for points. Pickups respawn and difficulty
    slowly increases.

Enjoy — tweak, expand, or ask me to add features (enemies, levels, sound, save states).
"""
from ursina import *
from ursina.prefabs.first_person_controller import FirstPersonController
import random

app = Ursina()

# Window settings
window.title = 'Collect the Cubes - Minimal 3D Game'
window.borderless = False
window.fullscreen = False
window.exit_button.visible = True
window.fps_counter.enabled = True

# Ground
ground = Entity(model='plane', scale=(100,1,100), texture='white_cube', texture_scale=(50,50), collider='box')

# Sky
Sky()

# Lighting
DirectionalLight(y=2, z=3, shadows=True)
AmbientLight(color=color.rgb(100,100,100))

# Player
player = FirstPersonController(y=1.5, speed=6)
player.cursor.visible = True
player.gravity = 1

# UI
score = 0
score_text = Text(text=f'Score: {score}', position=window.top_left, origin=(0,0), scale=2)
message = Text(text='Collect the glowing cubes. Press R to respawn all pickups.', position=window.top_right, origin=(1,0), scale=1.25)

# Pickup class
class PickUp(Entity):
    def __init__(self, position=(0,1,0)):
        super().__init__(model='cube', color=color.azure, scale=0.8, position=position, collider='box')
        self.original_y = self.y
        self.collected = False
        self.rotation_speed = random.uniform(20,80)
        # add an emission effect using a child light
        self.point_light = PointLight(parent=self, y=0.5, color=color.cyan, shadows=False)

    def update(self):
        # simple float and rotate animation
        self.y = self.original_y + math.sin(time.time()*2 + hash(self)) * 0.12
        self.rotation_y += self.rotation_speed * time.dt

    def collect(self):
        global score
        if not self.collected:
            self.collected = True
            score += 1
            score_text.text = f'Score: {score}'
            # play a tiny scale animation and then disable
            invoke(self.disable, delay=0.12)
            sequence = Sequence(self.scale_x(1.0, duration=0.05), self.scale_x(0.0, duration=0.08))
            sequence.start()

# Helpers
pickups = []

def spawn_pickup(position=None):
    if position is None:
        x = random.uniform(-40, 40)
        z = random.uniform(-40, 40)
        y = random.uniform(1, 4)
        position = (x, y, z)
    p = PickUp(position=position)
    pickups.append(p)
    return p

# Spawn initial pickups
for i in range(8):
    spawn_pickup()

# Simple HUD for instructions
instructions = Text(text='WASD - Move | Mouse - Look | Space - Jump | R - Respawn | Esc - Quit',
                    position=window.bottom_left, origin=(0,0), scale=1)

# Difficulty / respawn timer
respawn_timer = 0
respawn_interval = 10.0  # seconds
max_pickups = 20

# Collision detection: use distance check for simplicity
def update():
    global respawn_timer, respawn_interval, max_pickups
    # check pickups
    for p in pickups:
        if not p.enabled:
            continue
        dist = distance(player.position, p.position)
        if dist < 1.6:
            p.collect()
    # gradually increase difficulty: spawn more pickups occasionally
    respawn_timer += time.dt
    if respawn_timer > respawn_interval and len([p for p in pickups if p.enabled]) < max_pickups:
        spawn_pickup()
        respawn_timer = 0
        # tighten the interval a bit
        respawn_interval = max(2.5, respawn_interval * 0.95)

# Input handling
def input(key):
    global pickups, score
    if key == 'r':
        # respawn all pickups and reset score
        for p in pickups:
            destroy(p)
        pickups = []
        score = 0
        score_text.text = f'Score: {score}'
        for i in range(8):
            spawn_pickup()
    if key == 'escape':
        application.quit()

# A simple function to make a scale animation callable as in the PickUp.collect above
def scale_x(self, target, duration=0.1):
    start = self.scale_x
    def lerp(t):
        self.scale_x = lerp(start, target, t)
    return FuncAnimation(duration, lerp)

# Small animation helper class
class FuncAnimation:
    def __init__(self, duration, fn):
        self.duration = duration
        self.fn = fn
        self.start_time = time.time()
        self.running = True
        invoke(self.finish, delay=duration)
        held_animations.append(self)

    def finish(self):
        self.fn(1.0)
        self.running = False

held_animations = []

# Update animations
def late_update():
    # remove finished animations
    for a in held_animations[:]:
        if not a.running:
            held_animations.remove(a)

# Monkeypatch: attach scale_x to Entity for tiny visual effect
Entity.scale_x = property(lambda self: self.scale.x, lambda self, v: setattr(self, 'scale', Vec3(v, self.scale.y, self.scale.z)))
Entity.scale_x = lambda self, target=1.0, duration=0.1: scale_x(self, target, duration)

# Run
app.run()


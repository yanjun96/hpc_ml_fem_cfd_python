"""
Simple 3D Dodger game using the Ursina engine.

Controls:
 - A / Left Arrow: move left
 - D / Right Arrow: move right
 - Space: jump
 - Esc or close window: quit

Dependencies:
 pip install ursina

Run:
 python3 3d_dodger.py

This is intentionally small and easy to read — you can customize speeds, spawn rates,
add levels, power-ups, or change assets.
"""
from ursina import *
from ursina.prefabs.first_person_controller import FirstPersonController
import random

app = Ursina()

# Window settings
window.title = '3D Dodger — Python (Ursina)'
window.borderless = False
window.fullscreen = False
window.exit_button.visible = False
window.fps_counter.enabled = True

# Constants / tuning
LANE_COUNT = 3
LANE_X = [-4, 0, 4]
PLAYER_Y = 0.5
OBSTACLE_SPEED = 8
OBSTACLE_SPAWN_INTERVAL = 1.0  # seconds
JUMP_SPEED = 8
GRAVITY = 20

# Ground
ground = Entity(model='plane', scale=(30,1,30), color=color.light_gray, collider='box')

# Simple sky
Sky()

# Player
player = Entity(model='cube', color=color.azure, scale=(1.5, 1.5, 1.5), position=(0, PLAYER_Y, -10), collider='box')
player.lane = 1  # start center lane
player.vy = 0

# Camera
camera.parent = player
camera.position = (0, 6, 18)
camera.rotation_x = 20

# Score
score = 0
score_text = Text(text=f'Score: {score}', position=window.top_left + (0.08, -0.03), scale=2)

# Obstacle management
obstacles = []
last_spawn_time = time.time()

# Instruction text
instr = Text(text='A / D: Move  |  Space: Jump', position=window.bottom_left + (0.08, 0.03), scale=1.5)

# Game state
game_over = False


def spawn_obstacle():
    lane = random.randint(0, LANE_COUNT - 1)
    x = LANE_X[lane]
    z = 40
    size = random.choice([(1.8, 1.8, 1.8), (2.8, 2.8, 2.8), (1.2, 2.4, 1.2)])
    e = Entity(model='cube', color=color.random_color(), scale=size, position=(x, size[1]/2, z), collider='box')
    e.lane = lane
    obstacles.append(e)


def reset_game():
    global score, game_over, obstacles
    score = 0
    score_text.text = f'Score: {score}'
    game_over = False
    for o in obstacles:
        destroy(o)
    obstacles = []
    player.position = (0, PLAYER_Y, -10)
    player.lane = 1
    player.vy = 0


# Simple UI for game over
game_over_text = Text(text='', origin=(0,0), scale=3, enabled=False)


def input(key):
    global game_over
    if game_over:
        if key == 'r':
            reset_game()
            game_over_text.enabled = False
        return

    if key == 'a' or key == 'left arrow':
        if player.lane > 0:
            player.lane -= 1
            target_x = LANE_X[player.lane]
            invoke(setattr, player, 'x', target_x, delay=0)  # instant move — change if you want interpolation

    if key == 'd' or key == 'right arrow':
        if player.lane < LANE_COUNT - 1:
            player.lane += 1
            target_x = LANE_X[player.lane]
            invoke(setattr, player, 'x', target_x, delay=0)

    if key == 'space':
        # simple jump if on ground
        if abs(player.y - PLAYER_Y) < 0.01:
            player.vy = JUMP_SPEED

    if key == 'escape':
        application.quit()



def update():
    global last_spawn_time, score, game_over

    if game_over:
        return

    # Spawn obstacles over time
    now = time.time()
    if now - last_spawn_time > OBSTACLE_SPAWN_INTERVAL:
        spawn_obstacle()
        last_spawn_time = now

    # Update player gravity/jump
    player.vy -= GRAVITY * time.dt
    player.y += player.vy * time.dt
    if player.y < PLAYER_Y:
        player.y = PLAYER_Y
        player.vy = 0

    # Move obstacles toward the player
    for o in list(obstacles):
        o.z -= OBSTACLE_SPEED * time.dt
        # If obstacle passed player
        if o.z < -20:
            obstacles.remove(o)
            destroy(o)
            score += 1
            score_text.text = f'Score: {score}'

        # Collision check
        if o.intersects(player).hit:
            game_over = True
            game_over_text.text = f'GAME OVER\nScore: {score}\nPress R to restart'
            game_over_text.enabled = True
            break


# Add a simple moving light for effect
directional_light = DirectionalLight(direction=(1,-1,-1), color=color.rgb(255, 244, 214))

# Start with a few obstacles
for _ in range(3):
    spawn_obstacle()

app.run()

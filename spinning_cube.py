"""
Spinning 3D cube rendered in a window using pygame.

Controls:
  ESC / close window - quit
  Arrow keys         - change rotation speed
  SPACE              - pause/resume
"""

import math
import sys

import pygame

# Window settings
WIDTH, HEIGHT = 600, 600
FPS = 60
BG_COLOR = (20, 20, 30)

# Cube vertices (unit cube centered at origin)
VERTICES = [
    (-1, -1, -1),
    ( 1, -1, -1),
    ( 1,  1, -1),
    (-1,  1, -1),
    (-1, -1,  1),
    ( 1, -1,  1),
    ( 1,  1,  1),
    (-1,  1,  1),
]

# Edges connecting vertex indices
EDGES = [
    (0, 1), (1, 2), (2, 3), (3, 0),  # back face
    (4, 5), (5, 6), (6, 7), (7, 4),  # front face
    (0, 4), (1, 5), (2, 6), (3, 7),  # connecting edges
]

# Faces as vertex index quads (for filled rendering)
FACES = [
    (0, 1, 2, 3),  # back
    (4, 5, 6, 7),  # front
    (0, 1, 5, 4),  # bottom
    (2, 3, 7, 6),  # top
    (0, 3, 7, 4),  # left
    (1, 2, 6, 5),  # right
]

# Face colors (RGBA-ish, we'll adjust alpha by depth)
FACE_COLORS = [
    (255, 100, 100),
    (100, 255, 100),
    (100, 100, 255),
    (255, 255, 100),
    (255, 100, 255),
    (100, 255, 255),
]


def rotate_x(point, angle):
    x, y, z = point
    cos_a, sin_a = math.cos(angle), math.sin(angle)
    return (x, y * cos_a - z * sin_a, y * sin_a + z * cos_a)


def rotate_y(point, angle):
    x, y, z = point
    cos_a, sin_a = math.cos(angle), math.sin(angle)
    return (x * cos_a + z * sin_a, y, -x * sin_a + z * cos_a)


def rotate_z(point, angle):
    x, y, z = point
    cos_a, sin_a = math.cos(angle), math.sin(angle)
    return (x * cos_a - y * sin_a, x * sin_a + y * cos_a, z)


def project(point, fov, distance):
    """Perspective projection from 3D to 2D screen coordinates."""
    x, y, z = point
    z_offset = z + distance
    if z_offset == 0:
        z_offset = 0.001
    factor = fov / z_offset
    sx = x * factor + WIDTH / 2
    sy = -y * factor + HEIGHT / 2
    return (sx, sy)


def main():
    pygame.init()
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    pygame.display.set_caption("Spinning Cube")
    clock = pygame.time.Clock()

    angle_x = 0.0
    angle_y = 0.0
    angle_z = 0.0
    speed_x = 0.02
    speed_y = 0.03
    speed_z = 0.01
    paused = False
    fov = 400
    distance = 5

    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    running = False
                elif event.key == pygame.K_SPACE:
                    paused = not paused
                elif event.key == pygame.K_UP:
                    speed_x += 0.01
                    speed_y += 0.01
                elif event.key == pygame.K_DOWN:
                    speed_x = max(0, speed_x - 0.01)
                    speed_y = max(0, speed_y - 0.01)

        if not paused:
            angle_x += speed_x
            angle_y += speed_y
            angle_z += speed_z

        # Transform vertices
        transformed = []
        for v in VERTICES:
            p = rotate_x(v, angle_x)
            p = rotate_y(p, angle_y)
            p = rotate_z(p, angle_z)
            transformed.append(p)

        # Project to 2D
        projected = [project(v, fov, distance) for v in transformed]

        # Sort faces by average z-depth (painter's algorithm)
        face_order = []
        for i, face in enumerate(FACES):
            avg_z = sum(transformed[vi][2] for vi in face) / len(face)
            face_order.append((avg_z, i))
        face_order.sort(key=lambda x: x[0])

        # Draw
        screen.fill(BG_COLOR)

        # Draw filled faces
        for avg_z, i in face_order:
            face = FACES[i]
            points = [projected[vi] for vi in face]
            # Darken faces further from camera
            depth_factor = (avg_z + 2) / 4  # normalize roughly to 0-1
            depth_factor = max(0.3, min(1.0, depth_factor))
            color = tuple(int(c * depth_factor) for c in FACE_COLORS[i])
            pygame.draw.polygon(screen, color, points)
            pygame.draw.polygon(screen, (200, 200, 200), points, 2)

        pygame.display.flip()
        clock.tick(FPS)

    pygame.quit()
    sys.exit()


if __name__ == "__main__":
    main()

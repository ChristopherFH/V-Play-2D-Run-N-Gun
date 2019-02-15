# V-Play-2D-Run-N-Gun

## Project Structure

### Assets
Assets are splitted in serveral folders:
- audio: contains sounds
- font: contains custom fonts
- img: contains images and spritesheets like
    - background
    - clouds
    - hud
    - tiles

### Source Code
The source code is split into serveral parts (some parts are in the wrong folders but due to refactoring issues we were not able to move them properly into different folders):
-   scenes: contains the three different scenes of the game (menu, highscore, game) and the HUD elements they need
-   entities: contains all elements which are spawned dynamically in the game (ground elements should be there too but refactoring broke the android build)
-   common: contains all items which are managing some part of the game (clouds, ground, data storing, etc.)

## Responsibilities

### Christopher Köllner
- Menu
- Highscore (Persistent Storage)
- HUD

### Matthias Ringwald
- Ground, cloud, enemy generation (level generation)
- Player controls
- Camera behaviour

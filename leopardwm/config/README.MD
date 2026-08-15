# LeopardWM Keybindings

> My keybinding setup for [LeopardWM](https://github.com/jcardama/LeopardWM).

## Navigation

### Focus

| Key | Action |
|---|---|
| `Alt + H` | Focus left |
| `Alt + L` | Focus right |
| `Alt + K` | Focus up |
| `Alt + J` | Focus down |
| `Alt + Home` | Focus first column |
| `Alt + End` | Focus last column |

### Move Columns

| Key | Action |
|---|---|
| `Alt + Shift + H` | Move column left |
| `Alt + Shift + L` | Move column right |
| `Alt + Shift + Home` | Move column to start |
| `Alt + Shift + End` | Move column to end |

## Windows

### Move Between Columns

| Key | Action |
|---|---|
| `Alt + Left` | Move window left |
| `Alt + Right` | Move window right |
| `Ctrl + ,` | Expel window to a new column on the left |
| `Ctrl + .` | Expel window to a new column on the right |
| `Ctrl + Alt + ,` | Consume window from the left |
| `Ctrl + Alt + .` | Consume window from the right |

### Move Within Column

| Key | Action |
|---|---|
| `Alt + Shift + K` | Move window up |
| `Alt + Shift + J` | Move window down |

### Window Controls

| Key | Action |
|---|---|
| `Alt + W` | Close window |
| `Alt + F` | Toggle floating |
| `Alt + Shift + F` | Toggle fullscreen |
| `Alt + T` | Toggle tabbed |
| `Alt + S` | Toggle scratchpad |
| `Alt + Shift + S` | Stash window in scratchpad |
| `Alt + Y` | Toggle sticky |

## Layout

### Column Width

| Key | Action |
|---|---|
| `Alt + -` | Cycle width down |
| `Alt + Shift + -` | Cycle width up |
| `Alt + 0` | Equalize column widths |

Width presets:

```text
33.3% → 50% → 66.7%
```

### Window Height

| Key | Action |
|---|---|
| `Alt + Shift + Win + -` | Cycle height down |
| `Alt + Shift + Win + =` | Cycle height up |
| `Alt + Shift + 0` | Equalize window heights |

Height presets:

```text
33.3% → 50% → 66.7%
```

### Column Layout

| Key | Action |
|---|---|
| `Alt + C` | Center column |
| `Alt + M` | Maximize column |

## Monitors

### Focus Monitor

| Key | Action |
|---|---|
| `Ctrl + H` | Focus monitor left |
| `Ctrl + L` | Focus monitor right |
| `Alt + Up` | Focus monitor up |
| `Alt + Down` | Focus monitor down |

### Move Window to Monitor

| Key | Action |
|---|---|
| `Ctrl + Shift + H` | Move window to monitor left |
| `Ctrl + Shift + L` | Move window to monitor right |
| `Alt + Shift + Up` | Move window to monitor up |
| `Alt + Shift + Down` | Move window to monitor down |

## Workspaces

### Navigation

| Key | Action |
|---|---|
| `Alt + Space` | Toggle workspace overview |
| `Alt + Shift + Left` | Previous workspace |
| `Alt + Shift + Right` | Next workspace |

### Switch Workspace

| Key | Action |
|---|---|
| `Alt + 1` | Switch to workspace 1 |
| `Alt + 2` | Switch to workspace 2 |
| `Alt + 3` | Switch to workspace 3 |
| `Alt + 4` | Switch to workspace 4 |
| `Alt + 5` | Switch to workspace 5 |
| `Alt + 6` | Switch to workspace 6 |
| `Alt + 7` | Switch to workspace 7 |
| `Alt + 8` | Switch to workspace 8 |
| `Alt + 9` | Switch to workspace 9 |

### Move Window to Workspace

| Key | Action |
|---|---|
| `Alt + Shift + 1` | Move to workspace 1 |
| `Alt + Shift + 2` | Move to workspace 2 |
| `Alt + Shift + 3` | Move to workspace 3 |
| `Alt + Shift + 4` | Move to workspace 4 |
| `Alt + Shift + 5` | Move to workspace 5 |
| `Alt + Shift + 6` | Move to workspace 6 |
| `Alt + Shift + 7` | Move to workspace 7 |
| `Alt + Shift + 8` | Move to workspace 8 |
| `Alt + Shift + 9` | Move to workspace 9 |

## Session

| Key | Action |
|---|---|
| `Alt + P` | Toggle pause |
| `Alt + R` | Refresh |
| `Alt + Shift + R` | Reload configuration |
| `Win + Ctrl + Escape` | Panic revert |

## Touchpad Gestures

Touchpad gestures are enabled.

| Gesture | Action |
|---|---|
| Swipe left | Focus left |
| Swipe right | Focus right |
| Swipe up | Focus up |
| Swipe down | Focus down |

## Quick Reference

```text
              K
              ↑
              │
        H ←───┼───→ L
              │
              ↓
              J
```

### Most Used

```text
Alt + H/L          Focus left/right
Alt + K/J          Focus up/down

Alt + Shift + H/L  Move column left/right
Alt + Left/Right   Move window between columns
Alt + Shift + K/J  Move window up/down

Alt + -            Smaller column
Alt + Shift + -    Larger column
Alt + 0            Equalize columns

Alt + C            Center column
Alt + M            Maximize column

Alt + W            Close
Alt + F            Float
Alt + Shift + F    Fullscreen
Alt + T            Tabbed
Alt + S            Scratchpad
Alt + Y            Sticky

Alt + 1-9          Switch workspace
Alt + Shift + 1-9  Move window to workspace

Ctrl + H/L         Focus monitor left/right
Alt + Up/Down      Focus monitor up/down

Alt + R            Refresh
Alt + Shift + R    Reload config
Win + Ctrl + Esc   Panic revert
```

## Keybinding Philosophy

The layout is intentionally Vim-inspired:

- `H` / `L` → left / right
- `K` / `J` → up / down
- `Shift` → generally means **move**
- `Alt + 1-9` → switch workspace
- `Alt + Shift + 1-9` → move window to workspace
- `Home` / `End` → jump to beginning/end
- `0` → equalize

Basically:

```text
Focus = Alt + direction
Move  = Alt + Shift + direction
```

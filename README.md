# 🛠️ Windows Dotfiles Setup

## Alacritty

**Config location:**

```text
C:\Users\<your-username>\AppData\Roaming\Alacritty
```

---

## Neovim

**Config location:**

```text
C:\Users\<your-username>\AppData\Local\nvim
```

---

## Yazi

### Install `chafa`

`chafa` is required for image previews in Yazi.

```powershell
winget install hpjansson.chafa
```

**Config location:**

```text
C:\Users\<your-username>\AppData\Roaming\yazi\config
```

---

## Komorebi

### Install

```powershell
winget install LGUG2Z.komorebi
winget install LGUG2Z.whkd
```

### Generate the default configuration

```powershell
komorebic quickstart
```

This generates the default configuration files.

### Start Komorebi

```powershell
komorebic start --whkd
```

### Stop Komorebi

```powershell
komorebic stop --whkd
```

### Configuration Files

The following files are created in your home directory (`~`):

- `komorebi.json`
- `komorebi.bar.json`
- `applications.json`

Your keyboard shortcuts are stored in:

```text
~\.config\whkdrc
```

Edit `whkdrc` to customize your keybindings.

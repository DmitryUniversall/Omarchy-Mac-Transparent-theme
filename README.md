# Mac Transparent for Omarchy 4

[Русская версия](README.ru.md)

A port of [notzeman/Omarchy-Mac-Transparent-theme](https://github.com/notzeman/Omarchy-Mac-Transparent-theme)
to Omarchy 4 (tested on 4.0.4, Hyprland 0.56 with the Lua config, Quickshell-based Omarchy shell).

Translucent terminals over a blurred desktop, soft white glass window borders,
shadows, the original "water" window animations, and frosted glass under the
bar, notifications, menus, OSD and lock screen. Also includes a matching
Firefox theme.

![terminal](screenshots/s1.png)
![desktop](screenshots/s2.png)
![desktop](screenshots/s3.png)

Screenshots are from the original Omarchy 3 version; the Omarchy 4 bar is the
built-in Omarchy shell, so it looks different.

## Install

```bash
git clone https://github.com/DmitryUniversall/Omarchy-Mac-Transparent-theme ~/.local/share/mac-transparent-theme
ln -s ~/.local/share/mac-transparent-theme ~/.config/omarchy/themes/mac-transparent
omarchy theme set "Mac Transparent"
hyprctl configerrors   # should print nothing
```

Don't use `omarchy theme install <url>`. Omarchy treats a theme cloned into
`~/.config/omarchy/themes` as third-party and drops its `hyprland.lua` and
terminal configs, which is exactly where the blur and transparency live. A
symlink to your own clone counts as your own theme.

Update:

```bash
git -C ~/.local/share/mac-transparent-theme pull
OMARCHY_THEME_SKIP_BACKGROUND=1 omarchy theme set "Mac Transparent"
```

`OMARCHY_THEME_SKIP_BACKGROUND=1` keeps your current wallpaper; without it
re-applying the theme advances to the next one.

## What moved where

| Omarchy 3 (original)       | Omarchy 4 (this fork)                              |
|----------------------------|----------------------------------------------------|
| `hyprland.conf`            | `hyprland.lua`                                     |
| `alacritty.toml` (palette) | `colors.toml` + alacritty/foot/kitty/ghostty configs |
| `waybar.css`               | `shell.bar.toml`                                   |
| `mako.ini`                 | `shell.notifications.toml`                         |
| `walker.css`               | `shell.menu.toml`, `shell.launcher.toml`           |
| `swayosd.css`              | `shell.popups.toml`                                |
| `hyprlock.conf`            | `shell.lock.toml`                                  |
| `btop.theme`, `icons.theme`, `backgrounds/` | kept                              |

Each `shell.<section>.toml` replaces only that section of the `shell.toml`
Omarchy generates, so the remaining sections keep tracking Omarchy updates.

Not ported:
- `waybar/config.jsonc` and the cava visualizer: Omarchy 4 has no waybar; the
  bar layout lives in `~/.config/omarchy/shell.json` and isn't part of a theme.
- `gtk.css`: Omarchy 4 doesn't read it.
- `neovim.lua`: Omarchy generates one from `colors.toml`, and its Neovim config
  already makes the background transparent.
- `chromium.theme`: generated dark from the background color.

The palette is the one from the original `alacritty.toml` and screenshots, not
the later muted one from its `ghostty.conf`.

## Tuning

| What                         | File                                    | Key                         | Default     |
|------------------------------|-----------------------------------------|-----------------------------|-------------|
| Terminal background          | `alacritty.toml` / `foot.ini` / `kitty.conf` / `ghostty.conf` | `opacity` / `alpha` / `background_opacity` / `background-opacity` | 0.55 |
| Bar                          | `shell.bar.toml`                        | `background-alpha`          | 0.3         |
| Menu, launcher, notifications| `shell.menu.toml`, `shell.launcher.toml`, `shell.notifications.toml` | `background-alpha` | 0.3 |
| OSD and bar flyouts          | `shell.popups.toml`                     | `background-alpha`          | 0.5         |
| Lock screen                  | `shell.lock.toml`                       | `background-alpha`          | 0.4         |
| Every other window           | `hyprland.lua`                          | `active_opacity` / `inactive_opacity` | 1.0 / 0.95 |
| Blur strength                | `hyprland.lua`                          | `blur.size` / `blur.passes` | 4 / 3       |

0 is fully clear, 1 is solid. Terminals only make their background
translucent, text stays sharp; foot picks the change up in new windows.
`SUPER + BACKSPACE` toggles the focused window opaque.

`~/.config/hypr/looknfeel.lua` loads after the theme, so gaps, border size,
rounding and the workspace animation set there win over the theme's.

## Firefox

`firefox/` styles Firefox 157 (the "Nova" UI) to match: translucent tab strip
and toolbar with the desktop blurred behind them, tabs with a thin white edge,
menus in the theme colors, a dark new tab page. Web pages stay opaque.

```bash
P=~/.config/mozilla/firefox/<profile>   # see about:profiles
cp -r ~/.local/share/mac-transparent-theme/firefox/chrome "$P/chrome"
cp ~/.local/share/mac-transparent-theme/firefox/user.js "$P/user.js"
```

Restart Firefox completely. Adjust the glass with `--mt-bg` and
`--mt-bg-raised` at the top of `chrome/userChrome.css`. To remove it, delete
`$P/chrome` and `$P/user.js` and restart. Firefox doesn't follow Omarchy theme
changes; it keeps these colors until you remove `chrome/`.

## Credits

Original theme, palette and wallpapers: [notzeman](https://github.com/notzeman/Omarchy-Mac-Transparent-theme).

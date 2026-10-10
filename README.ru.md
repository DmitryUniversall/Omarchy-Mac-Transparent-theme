# Mac Transparent для Omarchy 4

[English version](README.md)

Порт [notzeman/Omarchy-Mac-Transparent-theme](https://github.com/notzeman/Omarchy-Mac-Transparent-theme)
на Omarchy 4 (проверено на 4.0.4: Hyprland 0.56 с Lua-конфигом, оболочка Omarchy на Quickshell).

Прозрачные терминалы с размытием, мягкие белые полупрозрачные рамки, тени,
«водяные» анимации окон из оригинала, матовое стекло под баром, уведомлениями,
меню, OSD и экраном блокировки. В комплекте тема для Firefox.

Скриншоты в `screenshots/` сняты с оригинальной версии для Omarchy 3. В
Omarchy 4 бар встроенный, поэтому выглядит иначе.

## Установка

```bash
git clone https://github.com/DmitryUniversall/Omarchy-Mac-Transparent-theme ~/.local/share/mac-transparent-theme
ln -s ~/.local/share/mac-transparent-theme ~/.config/omarchy/themes/mac-transparent
omarchy theme set "Mac Transparent"
hyprctl configerrors   # должно быть пусто
```

Не ставьте через `omarchy theme install <url>`. Тему, склонированную прямо в
`~/.config/omarchy/themes`, Omarchy считает сторонней и выбрасывает
`hyprland.lua` и конфиги терминалов, а вся прозрачность и размытие живут
именно в них. Симлинк на свой клон считается вашей собственной темой.

Обновление:

```bash
git -C ~/.local/share/mac-transparent-theme pull
OMARCHY_THEME_SKIP_BACKGROUND=1 omarchy theme set "Mac Transparent"
```

`OMARCHY_THEME_SKIP_BACKGROUND=1` оставляет текущие обои. Без него повторное
применение темы перелистнёт фон на следующий.

## Что куда переехало

| Было (Omarchy 3)          | Стало (Omarchy 4)                                  |
|---------------------------|----------------------------------------------------|
| `hyprland.conf`           | `hyprland.lua`                                     |
| `alacritty.toml` (палитра)| `colors.toml` + конфиги alacritty/foot/kitty/ghostty |
| `waybar.css`              | `shell.bar.toml`                                   |
| `mako.ini`                | `shell.notifications.toml`                         |
| `walker.css`              | `shell.menu.toml`, `shell.launcher.toml`           |
| `swayosd.css`             | `shell.popups.toml`                                |
| `hyprlock.conf`           | `shell.lock.toml`                                  |
| `btop.theme`, `icons.theme`, `backgrounds/` | без изменений по смыслу          |

Каждый `shell.<секция>.toml` заменяет только свою секцию в `shell.toml`,
который Omarchy генерирует сам. Остальные секции продолжат обновляться вместе
с Omarchy.

Не перенесено:
- `waybar/config.jsonc` и визуализатор cava: в Omarchy 4 нет waybar, раскладка
  бара хранится в `~/.config/omarchy/shell.json` и к теме не относится.
- `gtk.css`: Omarchy 4 его не читает.
- `neovim.lua`: Omarchy генерирует его из `colors.toml`, а прозрачный фон в
  Neovim включает его стандартный конфиг.
- `chromium.theme`: генерируется тёмным из цвета фона.

Палитра взята из оригинального `alacritty.toml` и скриншотов, а не более
поздняя приглушённая из его `ghostty.conf`.

## Настройка

| Что                            | Файл                                    | Параметр                    | Сейчас      |
|--------------------------------|-----------------------------------------|-----------------------------|-------------|
| Фон терминала                  | `alacritty.toml` / `foot.ini` / `kitty.conf` / `ghostty.conf` | `opacity` / `alpha` / `background_opacity` / `background-opacity` | 0.55 |
| Бар                            | `shell.bar.toml`                        | `background-alpha`          | 0.3         |
| Меню, лаунчер, уведомления     | `shell.menu.toml`, `shell.launcher.toml`, `shell.notifications.toml` | `background-alpha` | 0.3 |
| OSD и выпадашки бара           | `shell.popups.toml`                     | `background-alpha`          | 0.5         |
| Экран блокировки               | `shell.lock.toml`                       | `background-alpha`          | 0.4         |
| Все остальные окна             | `hyprland.lua`                          | `active_opacity` / `inactive_opacity` | 1.0 / 0.95 |
| Сила размытия                  | `hyprland.lua`                          | `blur.size` / `blur.passes` | 4 / 3       |

0 — полностью прозрачно, 1 — непрозрачно. У терминалов прозрачный только фон,
текст остаётся чётким; foot подхватит изменение в новых окнах.
`SUPER + BACKSPACE` делает текущее окно непрозрачным и обратно.

`~/.config/hypr/looknfeel.lua` загружается после темы, поэтому заданные там
отступы, толщина рамки, скругление и анимация рабочих столов перекрывают
значения темы.

## Firefox

`firefox/` оформляет Firefox 157 (дизайн Nova) под тему: полупрозрачная панель
вкладок и адресной строки с размытым рабочим столом под ней, вкладки с тонкой
белой кромкой, меню в цветах темы, тёмная страница новой вкладки. Сами сайты
остаются непрозрачными.

```bash
P=~/.config/mozilla/firefox/<профиль>   # смотрите about:profiles
cp -r ~/.local/share/mac-transparent-theme/firefox/chrome "$P/chrome"
cp ~/.local/share/mac-transparent-theme/firefox/user.js "$P/user.js"
```

Полностью перезапустите Firefox. Прозрачность регулируется переменными
`--mt-bg` и `--mt-bg-raised` в начале `chrome/userChrome.css`. Откат: удалить
`$P/chrome` и `$P/user.js`, перезапустить Firefox. Firefox не следит за
сменой темы Omarchy и сохраняет эти цвета, пока не удалить `chrome/`.

## Авторы

Оригинальная тема, палитра и обои: [notzeman](https://github.com/notzeman/Omarchy-Mac-Transparent-theme).

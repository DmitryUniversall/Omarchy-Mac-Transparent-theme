# Mac Transparent для Omarchy 4

[English version](README.md)

Порт [notzeman/Omarchy-Mac-Transparent-theme](https://github.com/notzeman/Omarchy-Mac-Transparent-theme)
на Omarchy 4 (проверено на 4.0.4: Hyprland 0.56 с Lua-конфигом, оболочка Omarchy на Quickshell).

Прозрачные терминалы с размытием, мягкие белые полупрозрачные рамки, тени,
«водяные» анимации окон из оригинала, матовое стекло под баром, уведомлениями,
меню, OSD и экраном блокировки. В комплекте темы для «Файлов» (Nautilus)
и Firefox.

Скриншоты в `screenshots/` сняты с оригинальной версии для Omarchy 3. В
Omarchy 4 бар встроенный, поэтому выглядит иначе.

## Установка

```bash
git clone --depth 1 https://github.com/DmitryUniversall/Omarchy-Mac-Transparent-theme ~/.local/share/mac-transparent-theme
ln -s ~/.local/share/mac-transparent-theme ~/.config/omarchy/themes/mac-transparent
omarchy hook install theme-set ~/.local/share/mac-transparent-theme/hooks/theme-set-gtk4
omarchy hook install theme-set ~/.local/share/mac-transparent-theme/hooks/theme-set-accent-icons
omarchy theme set "Mac Transparent"
hyprctl configerrors   # должно быть пусто
```

Не ставьте через `omarchy theme install <url>`. Тему, склонированную прямо в
`~/.config/omarchy/themes`, Omarchy считает сторонней и выбрасывает
`hyprland.lua` и конфиги терминалов, а вся прозрачность и размытие живут
именно в них. Симлинк на свой клон считается вашей собственной темой.

`--depth 1` не скачивает около 80 МБ обоев, которые автор оригинала
когда-то добавил, а потом удалил: в полном клоне они остаются в истории git.

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
| `gtk.css`                 | `gtk4.css` («Файлы») + `hooks/theme-set-gtk4`      |
| `icons.theme` (Yaru-sage) | `Omarchy-Accent` + `hooks/theme-set-accent-icons`  |
| `btop.theme`, `backgrounds/` | без изменений по смыслу                         |

Каждый `shell.<секция>.toml` заменяет только свою секцию в `shell.toml`,
который Omarchy генерирует сам. Остальные секции продолжат обновляться вместе
с Omarchy.

Не перенесено:
- `waybar/config.jsonc` и визуализатор cava: в Omarchy 4 нет waybar, раскладка
  бара хранится в `~/.config/omarchy/shell.json` и к теме не относится.
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
| «Файлы» (Nautilus)             | `gtk4.css`                              | альфа в `background-color`  | 0.55        |
| Все остальные окна             | `hyprland.lua`                          | `active_opacity` / `inactive_opacity` | 1.0 / 0.95 |
| Сила размытия                  | `hyprland.lua`                          | `blur.size` / `blur.passes` | 4 / 3       |

0 — полностью прозрачно, 1 — непрозрачно. У терминалов прозрачный только фон,
текст остаётся чётким; foot подхватит изменение в новых окнах.
`SUPER + BACKSPACE` делает текущее окно непрозрачным и обратно.

`~/.config/hypr/looknfeel.lua` загружается после темы, поэтому заданные там
отступы, толщина рамки, скругление и анимация рабочих столов перекрывают
значения темы.

## Иконки папок

В `icons.theme` указана `Omarchy-Accent` — тема иконок, которую хук
`theme-set-accent-icons` собирает на основе Yaru-blue-dark, перекрашивая все
папки в `accent` из `colors.toml` (`#7ca5ff`). Если поменять акцент и
переприменить тему, папки перекрасятся следом. Сборка занимает меньше секунды
и повторяется только при смене акцента; результат лежит в
`~/.local/share/icons/Omarchy-Accent`. Так же может подключиться любая тема.

## «Файлы» (Nautilus)

`gtk4.css` делает окно «Файлов» таким же стеклянным: полупрозрачное окно,
прозрачные заголовок и список файлов, едва заметная боковая панель, более
плотные меню и диалоги, синий акцент темы. Стили привязаны только к главному
окну Nautilus, остальные GTK 4 / libadwaita-приложения выглядят как обычно.

GTK читает один пользовательский файл стилей, `~/.config/gtk-4.0/gtk.css`.
Хук `theme-set-gtk4` (см. «Установка») копирует туда `gtk4.css`, пока активна
эта тема, и удаляет его при переключении на тему без него. Собственный
`gtk.css` пользователя он не трогает. GTK читает файл один раз при запуске, а
«Файлы» продолжают работать в фоне, поэтому после смены темы закройте все окна
«Файлов» и выполните `nautilus -q`. Если ни одно окно не открыто, хук делает
это сам.

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

## Производительность

Hyprland перерисовывает только то, что изменилось, а с `new_optimizations`
размытые обои считаются один раз и переиспользуются под всеми тайловыми
окнами, так что в простое прозрачность ничего не стоит. Размытие
пересчитывается, когда меняется то, что под полупрозрачной поверхностью:
движутся окна и анимации, плавающее окно висит над активным, появляются меню
и уведомления. На ноутбуке это немного лишней работы GPU и батареи при
активном перемещении окон. Облегчить: уменьшить `blur.passes` до 2 (самый
большой выигрыш) или `shadow.range` в `hyprland.lua`; `SUPER + BACKSPACE`
делает одно окно непрозрачным.

## Авторы

Оригинальная тема, палитра и обои: [notzeman](https://github.com/notzeman/Omarchy-Mac-Transparent-theme).

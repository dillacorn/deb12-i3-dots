# Turn Windows into a floating window manager

### Start Here
# Focus Window on hover

### this adds normal Linux WM behavior

### install [x-mouse controls](https://joelpurra.com/projects/X-Mouse_Controls/) | [github link](https://github.com/joelpurra/xmouse-controls)

* extract .zip and place in directory

`C:\Program Files\x-mouse_controls`

* run the program and change settings per picture below

![image](https://i.imgur.com/YCO3aO0.png)

### Note:
x-mouse-controls breaks taskbar right-click functionality.. Learn to live with it by just navigating those menues with your keyboard

### add `X-Mouse Controls.exe` shortcut to startup directory

`WIN+r` type `shell:startup` to access startup directory

# ALTSnap

## Adds ALT dragging and snapping/resizing to Windows similar to default Linux window managers behavior.

### install [ALTSnap](https://github.com/RamonUnch/AltSnap)

* Launch program

* open ALTSnap configuration

* check `Start AltSnap when logging on`

# PowerToys

### Keyboard remapping similar to a window manager

## install [PowerToys](https://github.com/microsoft/PowerToys)

* navigate to `Keyboard Manager`

* Remap a shotcut

![image](https://i.imgur.com/CWKra0b.png)

## Screenshot/Flameshot:
### Install [Flameshot](https://github.com/flameshot-org/flameshot)
* Take screenshots with flameshot!
### `ALT+Shift+s` to activate flameshot

# AutoHotkey desktop switcher

## turn this script off when online gaming -> anti-cheats don't like AutoHotkey

alternativly just use WIN+TAB to navigate taskview desktops

### download and install [AutoHotkey](https://www.autohotkey.com/)

### download [windows-desktop-switcher](https://github.com/pmb6tz/windows-desktop-switcher)

* place contents in directory

`C:\Program Files\windows-desktop-switcher-master`

edit `user_config.ahk` with your prefered note editor -> I use notepad++ on windows

### Note:
please read user_config.ahk file so you understand what lines you're changing

### Line # 8 in my config
```
; === SYMBOLS ===
; !   <- Alt
; +   <- Shift
; ^   <- Ctrl
; #   <- Win
; For more, visit https://autohotkey.com/docs/Hotkeys.htm
```
### Line # 71 in my config
```
!1::switchDesktopByNumber(1)
!2::switchDesktopByNumber(2)
!3::switchDesktopByNumber(3)
!4::switchDesktopByNumber(4)
!5::switchDesktopByNumber(5)
!6::switchDesktopByNumber(6)
!7::switchDesktopByNumber(7)
!8::switchDesktopByNumber(8)
!9::switchDesktopByNumber(9)
```
### Line # 100 in my config
```
!+1::MoveCurrentWindowToDesktop(1)
!+2::MoveCurrentWindowToDesktop(2)
!+3::MoveCurrentWindowToDesktop(3)
!+4::MoveCurrentWindowToDesktop(4)
!+5::MoveCurrentWindowToDesktop(5)
!+6::MoveCurrentWindowToDesktop(6)
!+7::MoveCurrentWindowToDesktop(7)
!+8::MoveCurrentWindowToDesktop(8)
!+9::MoveCurrentWindowToDesktop(9)
```

## WIN+TAB to create 9 desktops for the AutoHotkey script to utilize

### or use script command to create the desktops

### CTRL+ALT+c to create virtual desktops.

I create 9 virtual desktops

```
; ^!c::createVirtualDesktop()
; ^!d::deleteVirtualDesktop()
```

### switches desktops
ALT+1,2,3,4,5,6,7,8 or 9

### move current focused window to an existing desktop
ALT+Shift+1,2,3,4,5,6,7,8 or 9

## add `desktop_switcher.ahk` shortcut to startup directory

`WIN+r` type `shell:startup` to access startup directory

# noMac ![noMac](/noMAC.png?raw=true "noMAC icon")
## About
Have you ever got any archive from other sources, bloated with folders containing those ._* system MACOS files? Or folders with image galeries, containing those thumbs.db files, which can be as much as some MBs?

Clean those reduntant, OS specific system files from your windows OS with noMAC.

Initialy designed for removing MACOS system files, but as I personaly don't index and don't use image previewing, I added the thumbs.db file too. After all, all I need is the actual content, not metadata nor thumbnails.

## Usage
Just drop files or folders in the noMAC.ahk file or its shortcut and it will clean them for you. Next, you can re-archive and be sure no reduntant files are saved.

Personaly I have replaced Windows Explorer with [Directory Opus](https://www.gpsoft.com.au/) and made a button with a function

```path\to\autoHotkey\file\noMAC.ahk {allfilepath}```

Then I select files or/and folders and just press the button.

## What is removed
Currently the script removes:
```
.DS_Store file
thumbs.db file
._* file
__MACOSX folder and its content
.Trashes* folder and its content
```
If by any chance you have any of the above required to exist, DO NOT use this script.
Or move them temporarily to another safe location, apply the script, and move them back to the original location.

## Requirements
If you can run Autohotkey_L v1.0.45 or better on your Windows system then you can use this script.

In order to have drag&drop functionality, you need to have in registry the following:

```
[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\AutoHotkeyScript\ShellEx\DropHandler]
@="{86C86720-42A0-1069-A2E8-08002B30309D}"
```

## Warning
In case your system does use the thumbs.db file, it will be regenarated. But in MACOS, the dot files contain system info. Removing them from inside windows virtual system, may cause malfunction to the host.

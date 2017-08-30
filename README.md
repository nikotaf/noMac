# noMac ![noMac][nomacicon]
[nomacicon]: /noMAC.png?raw=true "noMAC icon"
1. [About](#about)
2. [Basic usage](#basic-usage)
3. [Advanced usage](#advanced-usage)
    * [Options](#options)
    * [Space separated file-list](#space-separated-file-list)
4. [What is removed](#what-is-removed)
5. [Tests](#tests)
6. [Requirements](#requirements)
7. [Warning](#warning)

<a name="about"></a>
## About
Have you ever got any archive from other sources, bloated with folders containing those `._*` MACOS system files?<br>Or folders with image galleries, containing those thumbs.db files, which can be as much as some MB's?

Clean those redundant, OS specific system files from your windows OS with **noMac**.

Initially designed for removing MACOS system files, but as I personally don't index and don't use image previewing, I added the `thumbs.db` file too. After all, all we need is the actual content, not meta-data nor thumbnails.

<a name="basic-usage"></a>
## Basic usage
Just drop files or folders in the noMac.ahk file or its shortcut and it will clean them for you. Next, you can re-archive and can be sure, no redundant files are saved.

Personally I have replaced Windows Explorer with [Directory Opus](https://www.gpsoft.com.au/) and made a button with a function
```
path\to\autoHotkey\file\noMac.ahk {allfilepath}
```

Then I select files or/and folders and just press the button.

<a name="advanced-usage"></a>
## Advanced usage
noMac.ahk **[options] [space separated file-list]**
<a name="options"></a>
### options
**[options]** must **always** precede the **[space separated file-list]**, as the command line arguments are processed in order.
* **-nodel** or **-move**:	Instead of deleting files and folders, it moves them to **`base dir` \ `noMac_moved_files_[001-100]`** keeping folder structure, given that all fed items reside in the same **`base dir`**. New **`noMac_moved_files_[001-100]`** folder will be created to hold the moved files. It's up to the user to remove that folder after further inspection of the content. Keep in mind that, retaining these folders in place, where the user usually works, it may accumulate a list of folders: **`noMac_moved_files_001`**, **`noMac_moved_files_002`**, **...**, **`noMac_moved_files_100`**, and the script may run in an endless loop to find a folder number that is available. Make sure to **clean** those folders often, if you use this script a lot and in the same place.

<a name="space-separated-file-list"></a>
### space separated file-list
Any number of files/folders separated by space. If paths and/or file-names contain space(s), those must be included in double quotes `"`.
```
noMac.ahk F:\Temp\__MACOSX "F:\Temp\Folder of interest"
```
In this example, **`base dir`** is **`F:\Temp`** and the file list:
```
F:
└───Temp
    ├───Folder of interest
    │   ├───.DS_Store
    │   ├───manual.pdf
    │   ├───picture.jpg
    │   └───readme.txt
    │       
    └───__MACOSX
        └───Folder of interest
            ├───.DS_Store
            ├───._manual.pdf
            ├───._picture.jpg
            └───._readme.txt
```

<a name="what-is-removed"></a>
## What is removed
Currently the script removes / deletes:

Files|Folders
:---:|:---:
`.DS_Store`|`.Trash`
`thumbs.db`|`__MACOSX`
`._*`|`.Trashes`

If by any chance you have any of the above required to exist, DO NOT use this script.<br>
Or move them temporarily to another safe location, apply the script, and move them back to the original location.

<a name="tests"></a>
## Tests
Inside `tests` folder, `noMac-test-files.zip` file contains a structure of zero-length files / folders, with many files of interest.<br>Make sure to unzip it where the `noMac.ahk` is, keeping folder structure.<br>To test it, copy each `.bat` file to the same folder (where `noMac.ahk` is).

<a name="requirements"></a>
## Requirements
If you can run Autohotkey_L v1.0.45 or better on your Windows system then you can use this script.<br>
In order to have drag&drop functionality, you need to have in registry the following:

```
[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\AutoHotkeyScript\ShellEx\DropHandler]
@="{86C86720-42A0-1069-A2E8-08002B30309D}"
```

<a name="warning"></a>
## Warning
In case your system does use the `thumbs.db` file, it will be regenerated.<br>But in MACOS, the dot files contain system info. Removing them from inside windows virtual system, may cause malfunction to the host.

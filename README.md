# PSNavigation

![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/PSNavigation)
![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/PSNavigation)
![PowerShell Gallery](https://img.shields.io/powershellgallery/p/PSNavigation)

![GitHub](https://img.shields.io/github/license/thbiv/PSNavigation)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/thbiv/PSNavigation)

---

#### Table of Contents

-   [Synopsis](#Synopsis)
-   [Commands](#Commands)
-   [Installation](#Installation)
-   [Usage](#Usage)
-   [Data File](#Data-File)
-   [Licensing](#Licensing)
-   [Release Notes](#Release-Notes)

---
## Synopsis

A powershell module for making it easier to navigate to your favorite or most used directories.
This module allows the user to save folder/directory paths (locations), along with a simple ID, to the module, later allowing to jump to that location by using that ID. The module also allows the user to open those locations in Windows Explorer.

---

## Commands

[Add-NavLocation](docs\Add-NavLocation.md)

Adds a directory path and reference ID to the PSNavigation data file.

[Get-NavLocation](docs\Get-NavLocation.md)

Lists the saved locations that are stored in the data file.

[Remove-NavLocation](docs\Remove-NavLocation.md)

Deletes one or more saved locations from the data file.

[Invoke-GoLocation](docs\Invoke-GoLocation.md)

Changes the current powershell console location.

[Invoke-OpenLocation](docs\Invoke-OpenLocation.md)

Opens a directory with Windows explorer.

---

## Installation

```Powershell
Install-Module -Name PSNavigation
```

---

## Usage

Once you have saved a location to the data file, you can use the ```Invoke-GoLocation``` command to jump to that directory.
Let's say you added a location with an ID of ```me``` for the directory of ```C:\Users\me```. To go to that directory, use the alias of ```Invoke-GoLocation```.

```Powershell
PS C:\> go me
```

Say you want to open this location in Windows Explorer, you would use this.

```Powershell
PS C:\> open me
```
Oh wait, what if you are already at the location you want to open in Windows Explorer. If you leave out the ID parameter, the command will automatically take the current location of the powershell console to open in Windows Explorer.

```Powershell
PS C:\Users\me> open
```

The current console location is not required to be saved in the data file to open in Windows Explorer.

---

## Data File

Locations are stored in a data file for each user that uses the module. The file is an XML file that contains the data. The location of the XML data file for each user is ```$HOME\AppData\Local\THBIV\Powershell\Navigation\data.xml```. This file is created the first time the ```Add-NavLocation``` command is used.

The data file not only keep track of the ID and it's location, but also the date and time the location was added as well as the number of times it was used. When a location is removed using ```Remove-NavLocation```, that data is not really removed from the data file. The loction is just moved to another section of the file for safe keeping. There is nothing implemented that uses the removedlocations section of the file.

---

## Licensing

PSNavigation is licensed under the [MIT License](LICENSE)

---

## Release Notes

Please refer to [Release Notes](Release-Notes.md)
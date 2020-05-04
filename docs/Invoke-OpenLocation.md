---
external help file: PSNavigation-help.xml
Module Name: PSNavigation
online version:
schema: 2.0.0
---

# Invoke-OpenLocation

## SYNOPSIS
Opens a Windows Explorer window to the path associated to the Id given.

## SYNTAX

```
Invoke-OpenLocation [[-Id] <String>] [-Path <String>] [<CommonParameters>]
```

## DESCRIPTION
Opens a Windows Explorer window to the path associated to the Id given.

## EXAMPLES

### EXAMPLE 1
```
Invoke-OpenLocation scripts
```

This example will open a Windows Explorer window to the path assiciated
with the scripts id.

### EXAMPLE 2
```
Open scripts
```

This example is the same as example 1 but using the Open alias for
Invoke-OpenLocation

### EXAMPLE 3
```
Open
```

This example will open the current location of the console.
In this case
C:\ will open in a window.

### EXAMPLE 4
```
Open -Path 'C:\Users'
```

This example will open an explorer window to C:\Users without having to
add the location to the database.

## PARAMETERS

### -Id
Name of the Open location to invoke.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Lets you type in a path manually if you do not need to add the location
to the database.

```yaml
Type: String
Parameter Sets: (All)
Aliases: p

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Written by: Thomas Barratt

## RELATED LINKS

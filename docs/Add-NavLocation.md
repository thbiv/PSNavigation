---
external help file: PSNavigation-help.xml
Module Name: PSNavigation
online version:
schema: 2.0.0
---

# Add-NavLocation

## SYNOPSIS
Adds a Powershell bookmark to the Nav database.

## SYNTAX

```
Add-NavLocation [-Id] <String> [[-Location] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a Powershell bookmark to the Nav database with the name of the location
and the path to the location.

## EXAMPLES

### EXAMPLE 1
```
Add-NavLocation -Id c -Location C:\
```

This example will add a NavLocation to the database named C that points to C:\

### EXAMPLE 2
```
Add-NavLocation c C:\
```

This example will add a NavLocation to the database named C that points to C:\

### EXAMPLE 3
```
Add-NavLocation -Id c
```

This example will add a NavLocation to the database named c. 
Since the location
parameter was not given, the cmdlet will insert the current location of the console
as the path.
This will have the same affect as examples 1 and 2.

## PARAMETERS

### -Id
The name of the location you want to store.
This name will be used when invoking
the path to the Powershell console.
Length can be from 1 to 15 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
The path of the location to store. 
Can be a local path or a UNC path.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

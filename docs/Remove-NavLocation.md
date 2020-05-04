---
external help file: PSNavigation-help.xml
Module Name: PSNavigation
online version:
schema: 2.0.0
---

# Remove-NavLocation

## SYNOPSIS
Removes a Powershell bookmark from the Go database.

## SYNTAX

### Id
```
Remove-NavLocation [-Id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### All
```
Remove-NavLocation [-All] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a Powershell bookmark from the Go database.

## EXAMPLES

### EXAMPLE 1
```
Remove-GoLocation -Id c
```

This example will remove the location named c from the database.

### EXAMPLE 2
```
Remove-GoLocation c
```

This example will remove the location named c from the database.

### EXAMPLE 3
```
Remove-GoLocation -All
```

This example will remove all locations from the database

## PARAMETERS

### -Id
The name of the location to be removed from the database.
Cannot be used with the All parameter

```yaml
Type: String
Parameter Sets: Id
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
Removes all Powershell bookmarks from the Go Database
Cannot be used with the Id parameter.

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: True
Position: Named
Default value: False
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

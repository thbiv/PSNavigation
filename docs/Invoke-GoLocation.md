---
external help file: PSNavigation-help.xml
Module Name: PSNavigation
online version:
schema: 2.0.0
---

# Invoke-GoLocation

## SYNOPSIS
Sets the location of the console to the path associated to the id given.

## SYNTAX

```
Invoke-GoLocation [-Id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the location of the console to the path associated to the id given.

## EXAMPLES

### EXAMPLE 1
```
Invoke-GoLocation scripts
```

This example will change the location of the console to the path assiciated
with the scripts id.
In this example, if the scripts id points to a path
of C:\Scripts, the result displayed is:

PS C:\Scripts\>

### EXAMPLE 2
```
Go scripts
```

This example if the same as example 1 but using the Go alias for
Invoke-GoLocation

## PARAMETERS

### -Id
Name of the Nav location to invoke.

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

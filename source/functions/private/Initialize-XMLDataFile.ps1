Function Initialize-XMLDataFile {
	Param(
		[Parameter(Mandatory=$True)][string]$Path
	)
	$DateTimeStamp = (Get-Date -Format "MM/dd/yyy-THH:mm:ss")
	$XMLWriter = New-Object System.XML.XmlTextWriter($Path,$Null)
	$XMLWriter.Formatting = 'Indented'
	$XMLWriter.Indentation = 1
	$XMLWriter.IndentChar = "`t"
	$XMLWriter.WriteStartDocument()
	$XMLWriter.WriteProcessingInstruction("xml-stylesheet", "type='text/xsl' href='style.xsl;")
	$XMLWriter.WriteStartElement('navigation')
		$XMLWriter.WriteAttributeString('datecreated',$($DateTimeStamp))
		$XMLWriter.WriteStartElement('locations')
		$XMLWriter.WriteEndElement() # End of locations element
		$XMLWriter.WriteStartElement('removedlocations')
		$XMLWriter.WriteEndElement() # End of 'removedlocations' element
	$XMLWriter.WriteEndElement() # End of navigation element
	$XMLWriter.WriteEndDocument()
	$XMLWriter.Flush()
	$XMLWriter.Close()
}
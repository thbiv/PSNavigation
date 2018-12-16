Function ExportXMLData {
	Param(
		[Parameter(Mandatory=$True)][PSObject]$InputObject,
		[Parameter(Mandatory=$True)][string]$Path
	)
	$DataFileCreatedDate = $InputObject.DataFileCreatedDate
	$Locations = $InputObject.Locations
	$RemovedLocations = $InputObject.RemovedLocations

	$XMLWriter = New-Object System.XML.XmlTextWriter($Path,$Null)
	$XMLWriter.Formatting = 'Indented'
	$XMLWriter.Indentation = 1
	$XMLWriter.IndentChar = "`t"
	$XMLWriter.WriteStartDocument()
	$XMLWriter.WriteProcessingInstruction("xml-stylesheet", "type='text/xsl' href='style.xsl;")
	$XMLWriter.WriteStartElement('navigation')
		$XMLWriter.WriteAttributeString('datecreated',$DataFileCreatedDate)
		$XMLWriter.WriteStartElement('locations')
		ForEach ($Location in $Locations) {
			$XMLWriter.WriteStartElement('location')
				$XMLWriter.WriteAttributeString('id',$($Location.Id))
				$XMLWriter.WriteAttributeString('location',$($Location.Location))
				$XMLWriter.WriteAttributeString('datecreated',$($Location.DateCreated))
				$XMLWriter.WriteAttributeString('invoked',$($Location.Invoked))
			$XMLWriter.WriteEndElement() # End of 'location' element
		}
		$XMLWriter.WriteEndElement() # End of 'locations' element
		$XMLWriter.WriteStartElement('removedlocations')
		ForEach ($RemovedLocation in $RemovedLocations) {
			$XMLWriter.WriteStartElement('location')
				$XMLWriter.WriteAttributeString('id',$($RemovedLocation.Id))
				$XMLWriter.WriteAttributeString('location',$($RemovedLocation.Location))
				$XMLWriter.WriteAttributeString('datecreated',$($RemovedLocation.DateCreated))
				$XMLWriter.WriteAttributeString('invoked',$($RemovedLocation.Invoked))
				$XMLWriter.WriteAttributeString('datedeleted',$($RemovedLocation.DateDeleted))
			$XMLWriter.WriteEndElement() # End of 'location' element
		}
		$XMLWriter.WriteEndElement() # End of 'removedlocations' element
	$XMLWriter.WriteEndElement() # End of 'navigation' element
	$XMLWriter.WriteEndDocument()
	$XMLWriter.Flush()
	$XMLWriter.Close()
}
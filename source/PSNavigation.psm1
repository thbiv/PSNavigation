#region Import Classes
If (Test-Path "$PSScriptRoot\functions\Classes") {
  $ClassesList = Get-ChildItem -Path "$PSScriptRoot\functions\classes"

  ForEach ($File in $ClassesList) {
    . $File.FullName
    Write-Verbose -Message ('Importing class file: {0}' -f $File.FullName)
  }
}
#endregion

#region Import Private Functions
If (Test-Path "$PSScriptRoot\functions\private") {
  $FunctionList = Get-ChildItem -Path "$PSScriptRoot\functions\private";

  ForEach ($File in $FunctionList) {
      . $File.FullName;
      Write-Verbose -Message ('Importing private function file: {0}' -f $File.FullName);
  }
}
#endregion

#region Import Public Functions
If (Test-Path "$PSScriptRoot\functions\public") {
  $FunctionList = Get-ChildItem -Path "$PSScriptRoot\Functions\Public";

  ForEach ($File in $FunctionList) {
      . $File.FullName;
      Write-Verbose -Message ('Importing public function file: {0}' -f $File.FullName);
  }
}
#endregion
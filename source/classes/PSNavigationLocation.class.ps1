Class PSNavigationLocation {
    [string]$Id
    [string]$Location
    [string]$DateCreated
    [int]$Invoked

    PSNavigationLocation ([string]$Id, [string]$Location, [string]$DateCreated, [int]$Invoked) {
        $this.Id = $Id
        $this.Location = $Location
        $this.DateCreated = $DateCreated
        $this.Invoked = $Invoked
    }

    [string]ToString() {
        return ("[{0}]{1}({2},{3})" -f $this.Id, $this.Location, $this.DateCreated, $this.Invoked)
    }
}
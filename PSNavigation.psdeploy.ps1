Deploy PSNavigation {
    By PSGalleryModule DeployModule {
        FromSource "$PSScriptRoot\_output\PSNavigation"
        To PSLocalGallery
    }
    #By FileSystem DeployOnlineHelp {
    #    FromSource "$PSScriptRoot\docs"
    #    To ""
    #}
}
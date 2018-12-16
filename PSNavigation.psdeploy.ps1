Deploy PSNavigation {
    By PSGalleryModule {
        FromSource "$PSScriptRoot\_output\PSNavigation"
        To SFGallery
    }
}
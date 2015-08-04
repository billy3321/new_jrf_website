if (typeof(CKEDITOR) != undefined) {
    CKEDITOR.editorConfig = function (config) {
        config.extraAllowedContent = 'i'
    }
    CKEDITOR.dtd.$removeEmpty['i'] = false
}

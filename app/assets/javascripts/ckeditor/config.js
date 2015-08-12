if (typeof(CKEDITOR) != undefined) {
    CKEDITOR.editorConfig = function (config) {
        config.extraAllowedContent = 'i dl dt dd';
    }
    CKEDITOR.dtd.$removeEmpty['i'] = false
}

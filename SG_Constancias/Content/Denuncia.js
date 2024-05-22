
    function OnCountryChanged(selectedValue) {
        cmbCity.PerformCallback(selectedValue);
         }
    function OnCountryChanged2(selectedValue) {
        cmbCity2.PerformCallback(selectedValue);
         }
    function ShowRelacionado() {
        Relacionado.Show();
         }
    function ShowEnviar() {
        Enviar.Show();
        //tbcorreo2.Focus();
    }
    ////function onFileUploadComplete(s, e) {
    ////         if (e.callbackData != "") {
    ////    fileNameLabel.SetText(e.callbackData);
    ////deleteFileButton.SetVisible(true);
    ////AddFileButton.SetVisible(true);
    ////         }
    ////     }
    function onClick(s, e) {
        callback.PerformCallback(fileNameLabel.GetText());
         }
    function onCallbackComplete(s, e) {
             if (e.result == "OK") {
        fileNameLabel.SetText(null);
    deleteFileButton.SetVisible(false);
    AddFileButton.SetVisible(false);
             }
         }
    function UpdateUploadButton() {
             var isAnyFileSelected = false;
    for (var i = 0; i < uploadControl.GetFileInputCount(); i++) {
                 if (uploadControl.GetText(i) != "") {isAnyFileSelected = true; break; }
             }
    btnUploadViaPostback.SetEnabled(isAnyFileSelected);
    //        /* btnUploadViaCallback.SetEnabled(isAnyFileSelected);*/
    //}
function Mostrar() {
}

       
}
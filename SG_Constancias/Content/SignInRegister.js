(function() {
    function onPasswordButtonEditButtonClick(s, e) {
        var inputType = s.GetInputElement().type;
        var turnOnPasswordMode = inputType !== "password";

        s.GetInputElement().type = turnOnPasswordMode ? "password" : "text";

        var eyeButton = s.GetMainElement().getElementsByClassName("eye-button")[0];
        if (turnOnPasswordMode)
            ASPxClientUtils.RemoveClassNameFromElement(eyeButton, "show-password");
        else
            ASPxClientUtils.AddClassNameToElement(eyeButton, "show-password");
    }

    function isPasswordSimple(password) {
        var passwordMinLength = 8;
        return password.length > 0 && password.length < passwordMinLength;
    }

    function getErrorText(editor) {
        var password = passwordButtonEdit.GetText(),
            confirmPassword = confirmPasswordButtonEdit.GetText();
        if (editor === passwordButtonEdit && isPasswordSimple(password)) {
            return "Use 8 caráteres o más para tu contraseña";
        } else if (editor === confirmPasswordButtonEdit && password !== confirmPassword) {
            return "La contraseña que ingresaste no coincide";
        }
        return "";
    }

    function onPasswordValidation(s, e) {
        var errorText = getErrorText(s);
        if(errorText) {
            e.isValid = false;
            e.errorText = errorText;
        }
    }

    window.onPasswordButtonEditButtonClick = onPasswordButtonEditButtonClick;
    window.onPasswordValidation = onPasswordValidation;
})();
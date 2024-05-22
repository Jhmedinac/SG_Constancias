<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PreRegistroSDJL.aspx.cs" Inherits="SG_Constancias.AutoenrolamientoDJL" %>

<%@ Register Assembly="DevExpress.XtraReports.v21.2.Web.WebForms, Version=21.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <!-- basic -->
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
       <meta name="viewport" content="width=device-width, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0" />
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <meta name="viewport" content="initial-scale=1, maximum-scale=1"/>
      <!-- site metas -->
      <title>PreResgistroSDJL</title>
      <meta name="keywords" content=""/>
      <meta name="description" content=""/>
      <meta name="author" content=""/>
      <!-- bootstrap css -->
      <link rel="icon" href="favicon.ico" type="image/x-icon"/>
      <link href="Content/css/bootstrap.min.css" rel="stylesheet" />
       <link href="Content/Form.css" rel="stylesheet" />
       <link href="Content/Denuncia.css" rel="stylesheet" />
       <link href="Content/css/responsive.css" rel="stylesheet" />
       <link href="Content/css/owl.carousel.min.css" rel="stylesheet" />
       <link href="Content/Fontawesome/css/all.css" rel="stylesheet" />
       <link href="Content/Fontawesome/css/fontawesome.css" rel="stylesheet" />
       <link href="Content/css/bootstrap.css" rel="stylesheet" />
       <link href="Content/css/bootstrap.min.css" rel="stylesheet" />
       <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
       <script src="Content/Denuncia.js"></script>
       <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%--       <script src="Content/js/bootstrap.js"></script>
       <script src="Content/js/bootstrap.min.js"></script>--%>
       <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js">--%>

         <style>
        .required-asterisk::after {
            content: ' *';
            color: red;
        }
        </style>

       <script type="text/javascript">


           //function Terminos(s, e) {

           //    if (s.GetChecked()) {
           //        if ((tbNombre.SetText() == '' || tbNombre.SetText() == null)
           //            || (tbApellido.SetText() == '' || tbApellido.SetText() == null)
           //            || (tbCorreo.SetText() == '' || tbCorreo.SetText() == null)
           //            || (tbDependencia.SetText() == '' || tbDependencia.SetText() == null)
           //            || (tbCelular.SetText() == '' || tbCelular.SetText() == null)
           //            || (CmbCountry.GetText() == '' || CmbCountry.GetText() == null)
           //            || (CmbTipoDeclaracion.GetText() == '' || CmbTipoDeclaracion.GetText() == null))
           //        {
           //            alert("¡Alerta! Debe de llenar los datos requeridos del formulario para enviar la solicitud del Pre-registro");
           //            //ckPolitica.SetChecked(false);
           //            console.log(tbNombre.SetText(), tbApellido.SetText(), tbCorreo.SetText(), tbDependencia.SetText(), tbCelular.SetText(), CmbCountry.GetText(), CmbTipoDeclaracion.GetText())
           //        }
           //        else if (s.GetChecked()) {
           //            ShowEnviar();
           //            ASPxButton2.SetEnabled(true);
           //        }
           //        console.log(s.GetChecked())

           //    }

           //     else
           //    {
           //        ASPxButton2.SetEnabled(false);

           //    }
           //}
           //function ClosePopupRelacionado(s, e) {
           //    var cf = confirm("¿Esta seguro de cerrar el comprobante.? Asegurese de haberlo descargado para ");
           //    if (cf) {
           //        isProcessOnServer = true;

           //    }

           //    else {
           //        e.processOnServer = false;

           //    }
           //}
           function btnEnviarCodigo_Click(s, e) {
               // Enviar el token al correo
               var email = tbCorreo.GetText();
               if (validarFormatoCorreo(email)) {
                   // Llamar al servidor para enviar el token
                   ASPxCallback_EnviarToken.PerformCallback(email);
                   popupToken.Show();
               } else {
                   alert('Por favor ingrese un correo electrónico válido.');
               }
           }

           function btnVerificarToken_Click(s, e) {
               // Verificar el token ingresado
               var inputToken = tbToken.GetText();
               ASPxCallback_VerificarToken.PerformCallback(inputToken);
           }
           function TokenVerificationComplete(result) {
               if (result === "success") {
                   popupToken.Hide();
                   ckPolitica.SetVisible(true); // Hacer visible el checkbox después de la verificación exitosa
                   ckPolitica.SetChecked(false);
                   btnEnviarCodigo.SetVisible(false); // Ocultar el botón después de la verificación exitosa
                   tbToken.SetText('');
               } else if (result === "incorrect") {
                   alert('Código de verificación incorrecto. Por favor, inténtelo de nuevo.');
                   tbToken.SetText('');
                   // No cerramos el popupToken si el código es incorrecto
               } else if (result === "expired") {
                   alert('El código de verificación ha expirado. Por favor, solicite un nuevo código.');
                   popupToken.Hide(); // Cerrar el popupToken si el código ha expirado
                   tbToken.SetText('');
               } else {
                   alert('Error en la verificación del código. Por favor, inténtelo de nuevo.');
                   popupToken.Hide(); // Cerrar el popupToken en caso de error general
                   tbToken.SetText('');
               }
           }

           function Terminos(s, e) {
               if (!s.GetChecked()) {
                   ASPxButton2.SetEnabled(false);
                   btnEnviarCodigo.SetVisible(false);
                   return;
               }

               // Verificar los campos del formulario
               var campos = [
                   tbNombre.GetText(),
                   tbApellido.GetText(),
                   tbCorreo.GetText(),
                   tbConfirmCorreo.GetText(),
                   tbDependencia.GetText(),
                   CmbCountry.GetText(),
                   CmbTipoDeclaracion.GetText(),
                   tbIdentidad.GetText(),
               ];

               var camposVacios = campos.some(function (valor) {
                   return valor === '' || valor === null;
               });

               if (camposVacios) {
                   Swal.fire({
                       title: "¡Alerta!",
                       text: "Debe llenar los datos requeridos del formulario para enviar la solicitud del Pre-Registro",
                       icon: "warning",
                       confirmButtonColor: "#1F497D",
                   });
                   s.SetChecked(false);
               } else {
                   btnEnviarCodigo.SetVisible(true);
               }
           }

           //function Guardar_Datos_Complete(s, e) {
           //    var respuestaJSON = e.result;
           //    var respuesta = JSON.parse(respuestaJSON);
           //    var Retorno = respuesta.Retorno;
           //    var Mens = respuesta.Mensaje;

           //    if (Retorno == 1) {
           //        Enviar.Hide();
           //        Lbl_msg.SetText(Mens);
           //        Relacionado.Show();
           //        ckPolitica.SetVisible(false); // Ocultar el checkbox después de mostrar el comprobante
           //        ckPolitica.SetChecked(false);
           //        btnEnviarCodigo.SetVisible(true); // Hacer visible el botón después de mostrar el comprobante
           //        SetCampos();
           //    } else {
           //        ckPolitica.SetChecked(false);
           //        Enviar.Hide();
           //        Swal.fire({
           //            text: Mens,
           //            icon: "error",
           //            confirmButtonColor: "#1F497D",
           //        });
           //    }
           //}

           //function Guardar_Datos_Complete(s, e) {
           //    var respuestaJSON = e.result;
           //    var respuesta = JSON.parse(respuestaJSON);
           //    var Retorno = respuesta.Retorno;
           //    var Mens = respuesta.Mensaje;

           //    if (Retorno == 1) {
           //        Enviar.Hide();
           //        Lbl_msg.SetText(Mens);
           //        Relacionado.Show();
           //        ckPolitica.SetVisible(false); // Ocultar el checkbox después de mostrar el comprobante
           //        ckPolitica.SetChecked(false);
           //        btnEnviarCodigo.SetVisible(true); // Hacer visible el botón después de mostrar el comprobante
           //        SetCampos();
           //    } else {
           //        ckPolitica.SetChecked(false);
           //        Enviar.Hide();
           //        Swal.fire({
           //            title: "¡Alerta!",
           //            text: Mens,
           //            icon: "error",
           //            confirmButtonColor: "#1F497D",
           //        });
           //    }
           //}

           function Guardar_Datos_Complete(s, e) {
               var respuestaJSON = e.result;
               var respuesta = JSON.parse(respuestaJSON);
               var Retorno = respuesta.Retorno;
               var Mens = respuesta.Mensaje;

               console.log('Respuesta:', respuesta); // Debug: Imprimir la respuesta en consola

               if (Retorno == 1) {
                   Enviar.Hide();
                   Lbl_msg.SetText(Mens);
                   Relacionado.Show();
                   ckPolitica.SetVisible(false); // Ocultar el checkbox después de mostrar el comprobante
                   ckPolitica.SetChecked(false);
                   btnEnviarCodigo.SetVisible(true); // Hacer visible el botón después de mostrar el comprobante
                   SetCampos();
               } else {
                   ckPolitica.SetChecked(false);
                   Enviar.Hide();
                   if (Mens.includes("El correo electrónico ya existe")) {
                       console.log('Correo electrónico ya existe.'); // Debug: Imprimir mensaje en consola
                       btnEnviarCodigo.SetVisible(true);
                       ckPolitica.SetVisible(false);
                   }
                   Swal.fire({
                       title: "¡Alerta!",
                       text: Mens,
                       icon: "error",
                       confirmButtonColor: "#1F497D",
                   }).then(() => {
                       // Acción después de cerrar la alerta
                       if (Mens.includes("El correo electrónico ya existe")) {
                           btnEnviarCodigo.SetVisible(true);
                           ckPolitica.SetVisible(false);
                       }
                   });
               }
           }

           // Añade un event listener para asegurarte de que los elementos se manipulen después de que el DOM esté completamente cargado
           window.onload = function () {
               if (btnEnviarCodigo) {
                   console.log('btnEnviarCodigo is loaded');
               } else {
                   console.error('btnEnviarCodigo is not found');
               }

               if (ckPolitica) {
                   console.log('ckPolitica is loaded');
               } else {
                   console.error('ckPolitica is not found');
               }
           };

           function ClosePopupRelacionado(s, e) {
                //Mostrar cuadro de diálogo de confirmación
               var confirmar = confirm("¿Está seguro de cerrar el comprobante? Asegúrese de haberlo descargado primero.");

                //Si el usuario hace clic en "OK", se permite que el evento de cierre continúe en el servidor
               if (confirmar) {
                    //Puedes establecer alguna bandera aquí o simplemente permitir que el evento continúe
                   e.processOnServer = true;
                   Relacionado.Hide();
               }
                //Si el usuario hace clic en "Cancelar", se cancela el evento de cierre
               else {
                    //Detener el procesamiento del evento de cierre
                   e.processOnServer = false;
                   Relacionado.Show();
               }
           }




           function SetCampos() {
                   tbNombre.SetText(''),
                   tbApellido.SetText(''),
                   tbCorreo.SetText(''),
                   tbConfirmCorreo.SetText(''),
                   tbDependencia.SetText(''),
                   tbCelular.SetText(''),
                   CmbCountry.SetText(''),
                   CmbTipoDeclaracion.SetText(''),
                   tbIdentidad.SetText(''),
                   ckPolitica.SetChecked(false);
               
           }

           
           function validarFormatoCorreo(correo) {
               // Expresión regular para validar el formato del correo electrónico
               //var regex = /\w + ([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
               var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
               //var regex = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
               return regex.test(correo);
           }



           function validarFormatoIDN(valor) {
               // Expresión regular para validar el formato del valor
               var regex = /^\d{13}$/;
               return regex.test(valor);
           }



           function Terminos(s, e) {
               // Desactivar el botón si el checkbox no está marcado
               if (!s.GetChecked()) {
                   ASPxButton2.SetEnabled(false);
                   return; // Detener la ejecución adicional de la función
               }

               // Lista de campos a validar
               var campos = [
                   tbNombre.GetText(),
                   tbApellido.GetText(),
                   tbCorreo.GetText(),
                   tbDependencia.GetText(),
                   CmbCountry.GetText(),
                   CmbTipoDeclaracion.GetText(),
                   tbIdentidad.GetText(),
               ];

               // Revisa si alguno de los campos está vacío o es null
               var camposVacios = campos.some(function (valor) {
                   return valor === '' || valor === null;
               });

               if (camposVacios) {
                   Swal.fire({
                       title: "¡Alerta!",
                       text: "Debe de llenar los datos requeridos del formulario para enviar la solicitud del Pre-Registro",
                       icon: "warning",
                       //showCancelButton: true,
                       confirmButtonColor: "#1F497D",
                       /*cancelButtonColor: "#d33",*/

                   });
                   ckPolitica.SetChecked(false);
                   //alert("¡Alerta! Debe de llenar los datos requeridos del formulario para enviar la solicitud del Pre-registro");
                   console.log(campos); // Esto imprimirá los valores de los campos, podrías quitarlo si no es necesario
               }
               else
               {

                   if (tbIdentidad.GetText() === '') {
                       tbIdentidad.SetFocus();
                       ckPolitica.SetChecked(false);
                       return;
                   }
                  
                   var valor = tbIdentidad.GetText(); // Suponiendo que tbIdentidad.GetText() obtiene el valor del campo de entrada de texto

                   ////// Validar el formato del valor
                   if (!validarFormatoIDN(valor)) {
                       tbIdentidad.SetFocus();
                       ckPolitica.SetChecked(false);
                       return;
                   }


                   var correo = tbCorreo.GetText();
                   if (!validarFormatoCorreo(correo)) {
                       tbCorreo.SetFocus();// Enfocar el campo de correo electrónico
                       ckPolitica.SetChecked(false);
                       return;
                   }


                       ShowEnviar(); // Función para mostrar la opción de enviar o algo relacionado
                       ASPxButton2.SetEnabled(true);
                       console.log(campos);
               }
               
           }
           
           function BtnGuardar_Click(s, e) {

                   ASPxCallback_Guardar_Datos.PerformCallback();
               
           }


           function popup_Shown_comprobante(s, e) {
               callbackPane_comprobante.PerformCallback();
           }

           //function Guardar_Datos_Complete(s, e) {
           //    var respuestaJSON = e.result;
           //    var respuesta = JSON.parse(respuestaJSON);

           //    // Acceder a los valores Retorno y Mensaje
           //    var Retorno = respuesta.Retorno;
           //    var Mens = respuesta.Mensaje;

           //   /* console.log(Retorno);*/
           //    //console.log(Mens);
           //    if (Retorno == 1) {
           //        Enviar.Hide();
           //        Lbl_msg.SetText(Mens);
           //       /* console.log(Retorno);*/
           //        Relacionado.Show();
           //        SetCampos();
           //    }
           //    else {
           //        ckPolitica.SetChecked(false);
           //        Enviar.Hide();
           //        Swal.fire({
           //            text: Mens,
           //            icon: "error",
           //            confirmButtonColor: "#1F497D",
                     
           //        });
           //    }
           //}

        //para guardar los docuementos
        function Click_Add_Dtos(s, e) {
            ASPxCallback_Guardar_Dctos.PerformCallback();
            ASPxGridView1.PerformCallback();

           }

         
        function Guardar_Dctos_Complete(s, e) {
            ASPxGridView1.PerformCallback();
            /*   alert(e.result);*/

            fileNameLabel.SetText(null);
            deleteFileButton.SetVisible(false);
            AddFileButton.SetVisible(false);

            return;
        }

            function onClick(s, e) {
                callback.PerformCallback(fileNameLabel.GetText());
            }
            function onCallbackComplete(s, e) {
                if (e.result == "OK") {
                    fileNameLabel.SetText(null);
                    //deleteFileButton.SetVisible(false);
                    //AddFileButton.SetVisible(false);
                }
            }

            function onFileUploadComplete(s, e) {
                if (e.callbackData) {
                    // Parsea la información almacenada en el sessionStorage
                    var fileList = e.callbackData.split("|");

                    // Construye la tabla HTML
                    var tableHTML = '<table border="1" class="table table-striped" style="width:100%"><tr style="background-color: #156ab3; color: white;"><th>Nombre de archivo</th></tr>';

                    for (var i = 0; i < fileList.length; i++) {
                        // Utiliza un atributo de datos para almacenar el fileId en el ícono de eliminar
                        tableHTML += '<tr><td>' + fileList[i] + '</td></tr>';
                    }

                    tableHTML += '</table>';

                    // Inserta la tabla en un contenedor HTML, por ejemplo, un div con el id "fileListContainer"
                    document.getElementById("fileListContainer").innerHTML = tableHTML;

                    // Almacena la información en el sessionStorage para que persista durante la sesión actual
                    sessionStorage.setItem("fileList", e.callbackData);
                }
            }

            // Recupera la información almacenada al cargar la página
            window.onload = function () {
                var storedFileList = sessionStorage.getItem("fileList");

                if (storedFileList) {
                    // Realiza el mismo proceso de construcción de la tabla al cargar la página
                    onFileUploadComplete(null, { callbackData: storedFileList });

                    // Elimina la información del sessionStorage después de cargar la página
                    sessionStorage.removeItem("fileList");
                }
            }


            function solonumeros(e) {

                var key;

                if (window.event) // IE
                {
                    key = e.keyCode;
                }
                else if (e.which) // Netscape/Firefox/Opera
                {
                    key = e.which;
                }

                if (key < 48 || key > 57) {
                    return false;
                }

                return true;
            }

       </script>
   </head>
   <!-- body -->
   <body class="main-layout">
       <div id="list"></div>
        <header class="header-area">
            <div class="container">
               <div class="row d_flex">
                  <div class=" col-md-3">
                     <div class="logo">
                        <a href="https://www.tsc.gob.hn/index.php/denuncia-ciudadana/"> <img src="Content/Images/TSCLogo.png"  alt="#"/>T<span>SC</span></a>
                     </div>
                  </div>
                  <div class="col-md-9 col-sm-12">
                    <div class="navbar-area">
                      <nav class="site-navbar">
                        <ul>
                            <li><a href="https://www.tsc.gob.hn/index.php/sistema-para-la-declaracion-jurada-en-linea/" target="_blank"><i class="fa fa-home"></i> Inicio</a></li>
                             <%--<li><a href="Content/Manuales/Manual de Usuario Ciudadano.pdf" target="_blank"><i class="fa fa-book"></i> Manual de Usuario</a></li>--%>
                        </ul>
                        <button class="nav-toggler">
                          <span></span>
                        </button>
                      </nav>
                    </div>
                  </div>
                </div>
            </div>
         </header>
   
       <form id="form1" runat="server" >
    
           <div class="services">

        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <div class="titlepage text_align_left">
                <h2 style="text-align:center">FORMULARIO DE SOLICITUD DE CONSTANCIAS EN LINEA</h2>
                  <h3 style="text-align:center">SECRETARIA GENERAL TSC   </div>
          </div>
     <%--       <dx:ASPxCallback ID="callbackcontent1" runat="server" OnCallback="Callbackcontent1_Callback">
        </dx:ASPxCallback>--%>
            <asp:scriptmanager id="ScriptManager1" runat="server" />
            <asp:SqlDataSource runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT * FROM [Company]" ID="SqlDataSource_Deptos"></asp:SqlDataSource>
        <asp:PlaceHolder ID="phDenunciado" runat="server">
        <dx:ASPxFormLayout runat="server" ID="formDenuncia" CssClass="formLayout">
              <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700" />
            <Items>
                   <dx:LayoutItem ShowCaption="False" HorizontalAlign="Left">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <table>
                                        <tr>
                                           <td >
                                              Bienvenido al Pre-Registro del Sistema de Declaración Jurada de Ingresos, Activos y Pasivos en Linea, favor llenar los siguientes campos para la solicitud de usuario.
                                             <br />
                                             <br />
                                              Los campos marcados con * son obligatorios.
                                           </td>
                                        </tr>
                                    </table>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                  </dx:LayoutItem>
                <dx:LayoutGroup Caption="1. DATOS DEL EMPLEADO *" ColCount="1" GroupBoxDecoration="HeadingLine" UseDefaultPaddings="false" Paddings-PaddingTop="10">
                   <GroupBoxStyle>
                        <Caption Font-Bold="true" Font-Size="15" />
                    </GroupBoxStyle>
                     <Items>
                        <dx:LayoutItem Caption="Nombres del Empleado" ColSpan="1" >
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbNombre" runat="server" NullText="Nombres del Empleado" ToolTip="Ingrese sus Nombres" ClientInstanceName="tbNombre" CaptionSettings-RequiredMarkDisplayMode="Hidden">
                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                            <RequiredField ErrorText="Los Nombres son requerido." IsRequired="true" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                          <dx:LayoutItem ColSpan="1" Caption="Apellidos del Empleado">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbApellido" runat="server" NullText="Apellidos del Empleado" ToolTip="Ingrese sus Apellidos" ClientInstanceName="tbApellido">
                                        
                                         <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                             <RequiredField ErrorText="Los Apellidos son requerido." IsRequired="true" />
                                        
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                                             <dx:LayoutItem ColSpan="1" Caption="Documento Nacional de Identificación">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbDNI" runat="server" NullText="Documento Nacional de Identificación" ClientInstanceName="tbIdentidad" 
                                        MaskSettings-Mask="0000000000000" MaskSettings-ErrorText="El Documento Nacional de Identificación es Requerido."
                                        ToolTip="Ingresar su Identificación">
                                            <MaskSettings Mask="0000000000000" ErrorText="El Documento Nacional de Identificación incorrecto" />
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" />
                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" EnableCustomValidation="True" 
                                                        ErrorDisplayMode="Text" CausesValidation="True">
                                              <RequiredField ErrorText="Documento Nacional de Identificación es requerida" IsRequired="true"/>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                           <dx:LayoutItem Caption="Correo Electrónico Personal" ColSpan="1">
    <LayoutItemNestedControlCollection>
        <dx:LayoutItemNestedControlContainer runat="server">
            <dx:ASPxTextBox ID="tbCorreo" runat="server" NullText="Correo Electrónico Personal" ClientInstanceName="tbCorreo" ToolTip="Ingresar su correo electrónico.">
                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" EnableCustomValidation="True" ErrorDisplayMode="Text" CausesValidation="True">
                    <RegularExpression ErrorText="El Correo Electrónico no es válido" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    <RequiredField ErrorText="El Correo Electrónico es requerida" IsRequired="true" />
                </ValidationSettings>
                <ClientSideEvents />
            </dx:ASPxTextBox>
        </dx:LayoutItemNestedControlContainer>
    </LayoutItemNestedControlCollection>
</dx:LayoutItem>

<dx:LayoutItem Caption="Confirmar Correo Electrónico Personal" ColSpan="1">
    <LayoutItemNestedControlCollection>
        <dx:LayoutItemNestedControlContainer runat="server">
            <dx:ASPxTextBox ID="tbConfirmCorreo" runat="server" NullText="Confirmar Correo Electrónico Personal" ClientInstanceName="tbConfirmCorreo" ToolTip="Confirmar su correo electrónico.">
                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" EnableCustomValidation="True" ErrorDisplayMode="Text" CausesValidation="True">
                    <RegularExpression ErrorText="El Correo Electrónico no es válido" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    <RequiredField ErrorText="Se requiere confirmación Correo Electrónico Personal" IsRequired="true" />
                </ValidationSettings>
                <ClientSideEvents Validation="function(s, e) {
                    var originalCorreo = tbCorreo.GetText();
                    var confirmCorreo = s.GetText();
                    e.isValid = (originalCorreo == confirmCorreo);
                    e.errorText = 'Correo Electrónico Personal deben coincidir.';
                }" />
            </dx:ASPxTextBox>
        </dx:LayoutItemNestedControlContainer>
    </LayoutItemNestedControlCollection>
</dx:LayoutItem>
<%--                         <dx:ASPxTextBox ID="tbPassword" ClientInstanceName="Password" Caption="Nueva contraseña" NullText="Nueva contraseña" Password="true" runat="server" CssClass="Texbox"
      Width="350px" Theme="iOS">
    <CaptionSettings Position="Top" />
      <ValidationSettings ValidationGroup="ChangeUserPasswordValidationGroup" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
          <RequiredField ErrorText="Se requiere la contraseña nueva." IsRequired="true" />
      </ValidationSettings>
</dx:ASPxTextBox>
<dx:ASPxTextBox ID="tbConfirmPassword" Password="true" Caption="Confirmar la nueva contraseña" NullText="Confirmar la nueva contraseña" runat="server" Width="350px" Theme="iOS" CssClass="Texbox">
    <CaptionSettings Position="Top" />
      <ValidationSettings ValidationGroup="ChangeUserPasswordValidationGroup" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
          <RequiredField ErrorText="Se requiere confirmación de la contraseña nueva." IsRequired="true" />
      </ValidationSettings>
      <ClientSideEvents Validation="function(s, e) {
        var originalPasswd = Password.GetText();
        var currentPasswd = s.GetText();
        e.isValid = (originalPasswd  == currentPasswd );
        e.errorText = 'La contraseña y la contraseña de confirmación deben coincidir.';
    }" />
</dx:ASPxTextBox>--%>
                         <dx:LayoutItem ColSpan="1" Caption="Dependencia/Gerencia">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbDependencia" runat="server" NullText="Ingrese la Dependencia/Gerencia" ToolTip="Ingrese la Dependencia/Gerencia" ClientInstanceName="tbDependencia">
                                        
                                         <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                             <RequiredField ErrorText="La Dependencia/Gerencia es requerida" IsRequired="true" />
                                        
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                          <dx:LayoutItem Caption="Celular" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbCelular" runat="server" NullText="Celular" ToolTip="Ingresar su teléfono celular" ValidationGroup="okButton" onkeypress="javascript:return solonumeros(event)" MaxLength="8" Size="8" ClientInstanceName="tbCelular">
                                      
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                            <dx:LayoutItem ColSpan="1" Caption="Institución">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox runat="server" ID="CmbCountry" ClientInstanceName="CmbCountry" DataSourceID="SqlDataSource_Deptos" TextField="CompanyName" ValueField="Id" NullText="Seleccione la Institución" ToolTip="Seleccionar la institución donde labora" >

                                        <%--<ClientSideEvents SelectedIndexChanged="function(s,e){OnCountryChanged(s.GetSelectedItem().value.toString());}"/>--%>
                                        <ClearButton DisplayMode="OnHover"></ClearButton>

                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                             <RequiredField ErrorText="La Institución es requerida." IsRequired="true" />
                                        </ValidationSettings>
                                   </dx:ASPxComboBox> 
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" Caption="Tipo de Declaración">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                   <dx:ASPxComboBox runat="server" ID="CmbTipoDeclaracion" ClientInstanceName="CmbTipoDeclaracion" NullText="Seleccione el tipo de Declaración" ToolTip="Seleccionar el Tipo de Declaración" ClearButton-ImagePosition="Left" ClearButton-DisplayMode="Auto">
                                       <Items>
                                           <dx:ListEditItem Text="Ingresar al cargo o al servicio público" Value="0" ></dx:ListEditItem>
                                           <dx:ListEditItem Text="Por llegar a la base salarial establecida" Value="1" ></dx:ListEditItem>
                                           <dx:ListEditItem Text="A requerimiento del Tribunal Superior de Cuentas (TSC)" Value="2" ></dx:ListEditItem>
                                           <dx:ListEditItem Text="Cesar en el cargo o servicio público" Value="3" ></dx:ListEditItem>
                                           <dx:ListEditItem Text="Actualización Anual" Value="4" ></dx:ListEditItem>

                                       </Items>

                                       <ClearButton DisplayMode="OnHover"></ClearButton>

                                       <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                             <RequiredField ErrorText="El Tipo de Declaración es requerido." IsRequired="true" />
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                         <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
    <LayoutItemNestedControlCollection>
        <dx:LayoutItemNestedControlContainer runat="server">
            <dx:ASPxButton ID="btnEnviarCodigo" runat="server" Text="Enviar Código" AutoPostBack="False" UseSubmitBehavior="false" CssClass="btn" ClientInstanceName="btnEnviarCodigo">
               
                <ClientSideEvents Click="btnEnviarCodigo_Click" />
            </dx:ASPxButton>
            <dx:ASPxCallback ID="ASPxCallback_EnviarToken" runat="server" ClientInstanceName="ASPxCallback_EnviarToken" OnCallback="ASPxCallback_EnviarToken_Callback"></dx:ASPxCallback>
        </dx:LayoutItemNestedControlContainer>
    </LayoutItemNestedControlCollection>
</dx:LayoutItem>
                          <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <%--<LayoutItemNestedControlCollection>--%>
                      
              <%--                      <dx:ASPxCheckBox ID="ASPxCheckBox1" runat="server" ColSpan="1" ClientInstanceName="ckanonima" RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" EnableCustomValidation="True" ValidationGroup="entryGroup" ToolTip="Seleccionar la casilla, si su denuncia será anónima y si no continuar llenando la información que se le pide"
                                                        ErrorDisplayMode="Text" CausesValidation="True" TextAlign="Right" Text="He leído y acepto los términos y condiciones para que el Tribunal Superior de Cuentas proceda a Investigar">
                                       
                        <a></a>
                                    </dx:ASPxCheckBox>--%>
                                       <dx:ASPxCheckBox ID="ckPolitica" runat="server" EncodeHtml="false" ClientInstanceName="ckPolitica" ClientVisible="False"
                 Text="Acepto los términos y politicas del Tribunal Superior de Cuentas" ValidationSettings-CausesValidation="true"> 
                                            <ClientSideEvents CheckedChanged="Terminos" />
    <%--<ClientSideEvents CheckedChanged="function(s, e) {
       
       if (s.GetChecked()) {
            ShowEnviar();
            ASPxButton2.SetEnabled(true);

        }
        else {
        ASPxButton2.SetEnabled(false);
        }
    }" />--%>
</dx:ASPxCheckBox>


                                        <%--</LayoutItemNestedControlCollection>--%>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                       <dx:LayoutItem ShowCaption="False" ColSpan="1" Width="70px" HorizontalAlign="Center" >
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <table class="dx-justification">
                                                    <tr>
                                                        <td style="text-align:center">
                                                      <%--      <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Enviar" AutoPostBack="False" UseSubmitBehavior="false" OnClick="BtnGuardar_Click"  CssClass="btn" HorizontalAlign="Right" Enabled="True" Visible="False" ClientInstanceName="ASPxButton2">
                                                    <ClientSideEvents Click="function(s, e) {  ShowRelacionado();}" />                       
                                                </dx:ASPxButton>--%>

                                                          
                                                        </td>
                                                    </tr>
                                                </table>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
            </Items>
             <Items>
        <%--    <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center"><LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                    <table>
                                        <tr>
                                            <td style ="text-align:center" >
                                                 <div style ="text-align:center" >
                                                <br />
                                                <dx:ASPxLabel ID="AllowedTypesLabel" runat="server" Font-Size="Medium" Text="Tipos de archivos permitidos: pdf,jpe,jpeg,jpg,png" />
                                                <br />
                                                <dx:ASPxLabel ID="MaxFileSizeLabel" runat="server" Font-Size="Medium" Text="Solo se permite adjuntar como limite 5 archivos con un peso de 10 MB maximo cada archivo." ForeColor="Red"/>
                                     
                                                    <br />
                                                
                                                    <dx:ASPxLabel ID="Mens" runat="server" ClientInstanceName="Mens" Font-Size="X-Small">
                                                </dx:ASPxLabel>
                                                <br />
                                                    <br />
                                                      </div>
                                                    <div style ="text-align:center" >
                                                <dx:ASPxUploadControl ID="UploadControl" runat="server" AutoStartUpload="true" Width="100%" NullText="Seleccionar los documentos a subir"  OnFileUploadComplete="UploadControl_FileUploadComplete" ShowProgressPanel="true" UploadMode="Advanced" ToolTip="Seleccionar los documentos a subir" AddUploadButtonsHorizontalPosition="Center" Theme="Moderno" ValidationSettings-MaxFileCount="5" ValidationSettings-MaxFileSize="5" ValidationSettings-ShowErrors="False">
                                                <ValidationSettings AllowedFileExtensions=".pdf,.jpe,.jpeg,.jpg,.png" MaxFileSize="41943040" MaxFileCount="5" ShowErrors="False" />
                                                <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="True" />
                                                <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                                                </dx:ASPxUploadControl>
                                                     <dx:ASPxLabel ID="ASPxLabel1" runat="server" ClientInstanceName="fileNameLabel" Font-Size="Medium">
                                                </dx:ASPxLabel>
                                                        <dx:ASPxButton ID="ASPxButton1" runat="server" RenderMode="Link" Text="Eliminar" Font-Size="Medium" ForeColor="#CC0000" ClientVisible="false" ClientInstanceName="deleteFileButton" AutoPostBack="false" >
                                                            <ClientSideEvents Click="onClick" />
                                                        </dx:ASPxButton>
                                                      <br />
                                                <dx:ASPxLabel ID="FileNameLabel" runat="server" ClientInstanceName="fileNameLabel" Font-Size="Medium">
                                                </dx:ASPxLabel>
                                                      
                                                      <dx:ASPxCallback ID="ASPxCallback_Guardar_Dctos" runat="server" OnCallback="ASPxCallback_Guardar_Dctos_Callback" ClientInstanceName="ASPxCallback_Guardar_Dctos">
                                                           
                                                        <ClientSideEvents CallbackComplete="Guardar_Dctos_Complete" />
                                                      </dx:ASPxCallback>
                                                    <dx:ASPxCallback ID="Callback" ClientInstanceName="callback" runat="server" OnCallback="Callback_Callback">
                                                    <ClientSideEvents CallbackComplete="onCallbackComplete" />
                                                </dx:ASPxCallback>
                                                     
                                                  <br />
                                                        <div id="fileListContainer"></div>
                                              </div>
                                            </td> 
                                        </tr>
                                    </table>
                                </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>--%>
                                </Items>
                      
            </dx:ASPxFormLayout>
        </asp:PlaceHolder>

            <dx:ASPxPopupControl ID="popupToken" runat="server" ClientInstanceName="popupToken" HeaderText="Verificación de Código" CloseAction="CloseButton" CloseOnEscape="true" CssClass="popup"
    Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" MinWidth="310px" MinHeight="214px" Width="400px" Height="200px"
    AllowDragging="True" EnableViewState="False" AutoUpdatePosition="true">
    <HeaderStyle CssClass="headerpopup" />
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <table class="dx-justification">
                <tr>
                    <td style="text-align:center;">
                        <dx:ASPxLabel ID="lblTokenPrompt" runat="server" Text="Ingrese el código enviado a su correo:" />
                        <br /><br />
                        <dx:ASPxTextBox ID="tbToken" runat="server" NullText="Código de Verificación" ClientInstanceName="tbToken" Width="100%" />
                        <br /><br />
                        <dx:ASPxButton ID="btnVerificarToken" runat="server" Text="Verificar Código" AutoPostBack="False" UseSubmitBehavior="false" CssClass="btn" ClientInstanceName="btnVerificarToken">
                            <ClientSideEvents Click="btnVerificarToken_Click" />
                        </dx:ASPxButton>
                        <dx:ASPxCallback ID="ASPxCallback_VerificarToken" runat="server" ClientInstanceName="ASPxCallback_VerificarToken" OnCallback="ASPxCallback_VerificarToken_Callback">
    <ClientSideEvents CallbackComplete="function(s, e) { TokenVerificationComplete(e.result); }" />
</dx:ASPxCallback>
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
       <dx:ASPxPopupControl ID="Enviar" runat="server" ClientInstanceName="Enviar" HeaderText="Políticas y Términos" CloseAction="CloseButton" CloseOnEscape="true" CssClass="popup"
           Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" MinWidth="310px" MinHeight="214px" Width="700px" Height="237px"
           AllowDragging="True" EnableViewState="False" AutoUpdatePosition="true" 
           
           PopupAnimationType="Fade" >
           <HeaderStyle CssClass="headerpopup" />
                <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                 
                            <table class="dx-justification">
    <tr>
        <td class="dx-ac" style="text-align:justify;">
            <br /> 
            “Por medio de la presente solicito la incorporación al Sistema de Declaración Jurada de Ingresos, Activos y Pasivos en Línea, como un requisito obligatorio de conformidad con la Ley Orgánica del TSC y su Reglamento, y Declarando bajo juramento que toda la información utilizada en el Sistema de Declaraciones Juradas en Línea, será completada y aprobada por quien suscribe como responsable de la misma, la que será cierta, correcta y completa.<br /> 
            <br />
            Es mi responsabilidad como servidor público obligado, mantener en estricta confidencialidad y reserva las credenciales de ingreso al Sistema en Línea, no debiendo compartirlas ni dejarlas al acceso de ninguna otra persona.<br /> 
            <br />
            Adicionalmente, por este medio autorizo de forma expresa e irrevocable al Tribunal Superior de Cuentas para confirmar el contenido de las Declaraciones Juradas realizadas mediante el Sistema en Línea, en cualquier tiempo y lugar. Autorizando al mismo tiempo para que investigue las cuentas, depósitos bancarios, bienes, participación en sociedades situados en el país o en el extranjero y en general para que comparezcan ante quien corresponda a realizar la verificación de la Información contenida en las referidas Declaraciones. <br />
            <br />
            La presente solicitud se fundamenta en los artículos 56, 57, 61, 67 y demás aplicables de la Ley Orgánica del Tribunal Superior de Cuentas; 59, 60, 61 y demás aplicables del Reglamento General de la Ley Orgánica del Tribunal Superior de Cuentas. <br />
            <br />
            <strong>Al Honorable Tribunal Superior de Cuentas respetuosamente PIDO:</strong> Admitir el presente escrito, realizar la incorporación correspondiente al Sistema de Declaraciones Juradas en Línea, tener por autorizado al Tribunal para realizar la confirmación de los datos de las Declaraciones de Ingresos, Activos y Pasivos realizadas por medio del sistema y en general, resolver conforme con lo solicitado.”
        </td>
    </tr>
</table>
                   <br />   
                <table class="dx-justification">
    <tr>
        <td class="dx-ac" style="text-align:center;">
                                    <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Enviar" AutoPostBack="False" UseSubmitBehavior="false" CausesValidation="true"  CssClass="btn" HorizontalAlign="Right" Enabled="True"  ClientVisible="True" ClientInstanceName="ASPxButton2" ClientEnabled="False">
                                                             <ClientSideEvents Click="BtnGuardar_Click" />
                                                              <%--<ClientSideEvents Click="function(s, e) {  ShowRelacionado();}" />--%>  
                                                          </dx:ASPxButton>
                                                             <dx:ASPxCallback ID="ASPxCallback_Guardar_Datos" runat="server" OnCallback="ASPxCallback_Guardar_Datos_Callback" ClientInstanceName="ASPxCallback_Guardar_Datos">
                                                           
                                                        <ClientSideEvents CallbackComplete="Guardar_Datos_Complete" />
                                                      </dx:ASPxCallback>
                         
                        </td>
    </tr>
</table>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <%--<ClientSideEvents CloseUp="function(s, e) { s.PerformCallback(); }" />--%>
    </dx:ASPxPopupControl>


              <dx:ASPxPopupControl ID="Relacionado" runat="server" ClientInstanceName="Relacionado" 
                   AllowDragging="true" HeaderText="Pre-Registro" 
             Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" CloseOnEscape="true" 
                  EnableViewState="False" AutoUpdatePosition="true" MinHeight="750px" >
                   <ClientSideEvents Shown="popup_Shown_comprobante" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                                      <br />
                                        <dx:ASPxLabel ID="Lbl_msg" runat="server" ClientInstanceName="Lbl_msg" Text="">
                                            </dx:ASPxLabel>
                                                <br />
                                                <br />
                  <dx:ASPxCallbackPanel runat="server" ID="callbackPane_comprobante" ClientInstanceName="callbackPane_comprobante"
                        OnCallback="callbackPane_comprobante_Callback" RenderMode="Table" Width="85%">
                               <PanelCollection> 
                 <dx:PanelContent runat="server">
                <dx:ASPxWebDocumentViewer ID="ASPxWebDocumentViewer1" runat="server" Height="750px" RightToLeft="True" 
                     DisableHttpHandlerValidation="False"></dx:ASPxWebDocumentViewer>
                      </dx:PanelContent>
                    </PanelCollection>
                                 </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents CloseUp="ClosePopupRelacionado" />
    </dx:ASPxPopupControl>
        </div>
        </div>
           </form>
      <!-- end innva -->
      <!-- footer -->
      <footer>
         <div class="footer">
            <div class="container">
               <div class="row">
                 <div class="col-md-12"> 
                    <ul class="conta">
                        <li> <span>Dirección</span> Centro civico Gubernamental, Bulevar Fuerzas Armadas <br /> Honduras, C.A </li>
                        <li> <span>Correo Eléctronico</span> <a href="mailto:tsc@tsc.gob.hn">tsc@tsc.gob.hn</a> </li>
                        <li> <span>Contacto</span> <a href="Javascript:void(0)">Tel(+504) 2230-3646 / 2228-3512 / 2228-7913 <br/> 2230-4152 / 2230-8242 / 2230-3732 </a> </li>
                      </ul>
                 </div>
          
                  <div class="col-md-12">
                    <div class="Informa">
                      <ul class="social_icon text_align_center">
                    
                        <li> <a href="https://www.tsc.gob.hn/"> <i class="fa fa-solid fa-globe"></i></a></li>
                       <li> <a href="http://www.facebook.com/tschonduras"> <i class="fa-brands fa-facebook"></i></a></li>
                        <li> <a href="http://www.twitter.com/tschonduras">  <i class="fa-brands fa-x-twitter"></i></a></li>
                      </ul>
                    </div>
                  </div>
               </div>
            </div>
            <div class="copyright text_align_center">
               <div class="container">
                  <div class="row">
                     <div class="col-md-12">
                         <p> &copy; Copyright 2024 IT | Tribunal Superior de Cuentas. <%--Design by <a href="https://html.design/"> <%: DateTime.Now.Year %> Free Html Template</a>--%></p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </footer>

      <script src="Content/js/jquery.min.js"></script>
      <script src="Content/js/bootstrap.bundle.min.js"></script>
      <script src="Content/js/jquery-3.0.0.min.js"></script>
      <script src="Content/js/owl.carousel.min.js"></script>
      <script src="Content/js/custom.js"></script>
  
   </body>
</html>

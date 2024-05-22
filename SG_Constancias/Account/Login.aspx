<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="Login.aspx.cs" Inherits="SG_Constancias.SignInModule" Title="Login" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" href="css/responsive.css"/>
    <link href="../Content/SignInRegister.css" rel="stylesheet" />
    <%--<link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/SignInRegister.css") %>' />--%>
     <style type="text/css">
        @media(max-width:824px) {
            .control-area {
                max-width:824px !important;
            }
        }
    </style>
     <%--<script src='https://www.google.com/recaptcha/api.js'></script> 
     <script src="https://www.google.com/recaptcha/api.js?onload=renderRecaptcha&render=explicit"></script>
     <script  src="https://code.jquery.com/jquery-3.2.1.min.js"></script> --%>
    <%--<script type="text/javascript" src='<%# ResolveUrl("~/Content/SignInRegister.js") %>'></script>--%>
    <script src="../Content/SignInRegister.js"></script>
       
    
    <script type = "text/javascript">
function disableBackButton()
{
window.history.forward();
}
setTimeout("disableBackButton()", 0);
        </script>

</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <div class="formLayout-verticalAlign">
        <div class="formLayout-container">
            <br />
            <div style="text-align:center" >
            <dx:ASPxImage ID="ASPxImage1"  runat="server" ShowLoadingImage="true"  ImageUrl="~/Content/TSC/Logo_TSC.jpg" ></dx:ASPxImage>    
         </div>
            <div style="text-align:center" >
         </div> 
            
                        <dx:ASPxFormLayout runat="server" ID="FormLayout" ClientInstanceName="formLayout" UseDefaultPaddings="false">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                            <SettingsItemCaptions Location="Top" />
                            <Styles LayoutGroup-Cell-Paddings-Padding="0" LayoutItem-Paddings-PaddingBottom="8" >
                            <LayoutItem>
                            <Paddings PaddingBottom="8px"></Paddings>
                            </LayoutItem>

         <%--   <LayoutGroup>
            <Cell>
            <Paddings Padding="0px"></Paddings>
            </Cell>
            </LayoutGroup>--%>

<LayoutGroup>
<Cell>
<Paddings Padding="0px"></Paddings>
</Cell>
</LayoutGroup>
                            </Styles>
                            <Items>
                                <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center"><LayoutItemNestedControlCollection>
                        <dx:LayoutItemNestedControlContainer runat="server">
                            <table>
                             <tr>
                               <td style="font-size:18px;">
                                <strong> Sistema de Pre-Registro DJL </strong>
                               </td>
                             </tr>
                            </table>
                        </dx:LayoutItemNestedControlContainer>
                    </LayoutItemNestedControlCollection>
                  </dx:LayoutItem>
                                <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None" Paddings-Padding="16">
                                    <Paddings Padding="16px"></Paddings>
                                    <Items>
                                        <dx:LayoutItem Caption="Usuario" >
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxTextBox ID="UserNameTextBox" runat="server" Width="100%" NullText="Ingrese su Usuario" CssClass="Texbox">
                                                        <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                            <RequiredField IsRequired="true" ErrorText="Usuario es Requerido" />
                                                        </ValidationSettings>
                                                       <%-- <ClientSideEvents Init="function(s, e){ s.Focus(); }" />--%>
                                                    </dx:ASPxTextBox>

                           
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>

                                        <dx:LayoutItem Caption="Contraseña">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxButtonEdit ID="PasswordButtonEdit" runat="server" Width="100%" Password="true" ClearButton-DisplayMode="Never" CssClass="Texbox">

<ClearButton DisplayMode="Never"></ClearButton>

                                                        <ButtonStyle Border-BorderWidth="0" Width="6" CssClass="eye-button" HoverStyle-BackColor="Transparent" PressedStyle-BackColor="Transparent">
                                                        <PressedStyle BackColor="Transparent"></PressedStyle>

                                                        <HoverStyle BackColor="Transparent"></HoverStyle>

                                                        <Border BorderWidth="0px"></Border>
                                                        </ButtonStyle>
                                                        <ButtonTemplate>
                                                            <div></div>
                                                        </ButtonTemplate>
                                                        <Buttons>
                                                            <dx:EditButton>
                                                            </dx:EditButton>
                                                        </Buttons>
                                                        <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                            <RequiredField IsRequired="true" ErrorText="Contraseña es Requerida" />
                                                        </ValidationSettings>
                                                        <ClientSideEvents ButtonClick="onPasswordButtonEditButtonClick" />
                                                    </dx:ASPxButtonEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>

                                        <%--<dx:LayoutItem ShowCaption="False" Paddings-PaddingTop="13">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="RememberMeCheckBox" runat="server" Text="Remember me" Checked="true"></dx:ASPxCheckBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>--%>

                                        <dx:LayoutItem ShowCaption="False" Name="GeneralError">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <div id="GeneralErrorDiv" runat="server" class="formLayout-generalErrorText"></div>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                             <dx:LayoutItem Colspan="1" ShowCaption="False" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                        <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                                        <h4 style="color:#FA5858; text-align:center">
                                            <asp:Literal runat="server" ID="FailureText" />
                                        </h4>
                                        </asp:PlaceHolder>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                                 </dx:LayoutItem>
                                      <dx:LayoutItem Colspan="1" ShowCaption="False" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
     <div style="width: 200px;margin:auto">
      <%--  <dx:ASPxCaptcha ID="Captcha" runat="server" TextBox-Position="Bottom">
            <ValidationSettings SetFocusOnError="true" ErrorDisplayMode="Text" />
        </dx:ASPxCaptcha>--%>
    <%--    <div class="TopPadding" style="text-align: center">
            <dx:ASPxButton ID="btnSubmit" runat="server" Text="Submit" UseSubmitBehavior="true"
                AutoPostBack="true">
            </dx:ASPxButton>
        </div>--%>
    </div>
                                    <%-- <div id="ReCaptchContainer">
                                        <label id="lblMessage" runat="server" clientidmode="static"></label>  
                                        <br />
                                                   <div class="g-recaptcha" data-sitekey="6LcIsOEfAAAAAHL4oE4SrtpSTCJ2GnQUGEz6jNjP"></div>          
                                                    <script type="text/javascript">  
                                                        var your_site_key = '<%= ConfigurationManager.AppSettings["SiteKey"]%>';
                                                        var renderRecaptcha = function () {
                                                            grecaptcha.render('ReCaptchContainer', {
                                                                'sitekey': your_site_key,
                                                                'callback': reCaptchaCallback,
                                                                theme: 'light', //light or dark    
                                                                type: 'image',// image or audio    
                                                                size: 'normal'//normal or compact    
                                                            });
                                                        };

                                                        var reCaptchaCallback = function (response) {
                                                            if (response !== '') {
                                                                jQuery('#lblMessage').css('color', 'green').html('Success');
                                                            }
                                                        };

                                                        jQuery('button[type="button"]').click(function (e) {
                                                            var message = 'Please checck the checkbox';
                                                            if (typeof (grecaptcha) != 'undefined') {
                                                                var response = grecaptcha.getResponse();
                                                                (response.length === 0) ? (message = 'Captcha verification failed') : (message = 'Success!');
                                                            }
                                                            jQuery('#lblMessage').html(message);
                                                            jQuery('#lblMessage').css('color', (message.toLowerCase() == 'success!') ? "green" : "red");
                                                        });

                                                    </script>
                                         </div>  --%>
                                <%--    <div style="width: 200px;margin:auto">
                                     <dx:ASPxCaptcha ID="Captcha" runat="server" TextBox-Position="Bottom" ValidationSettings-SetFocusOnError="True" ValidationSettings-Display="Dynamic" ChallengeImage-FontStyle="Bold">
                                        <ValidationSettings SetFocusOnError="true" ErrorDisplayMode="Text" />
                                     </dx:ASPxCaptcha>
                                   </div>--%>
                               </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>

                                <dx:LayoutGroup GroupBoxDecoration="HeadingLine" ShowCaption="False">
                                    <Paddings PaddingTop="13" PaddingBottom="13" />
                                    <GroupBoxStyle CssClass="formLayout-groupBox" />
                                    <Items>
                                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-Padding="0">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxButton ID="SignInButton" runat="server" Width="200" Text="Iniciar Sesión" CssClass="btn" OnClick="SignInButton_Click" UseSubmitBehavior="true">

                                                    </dx:ASPxButton>
                                                    <div style="text-align:center">     
                                                        <br />
                                                    <dx:ASPxHyperLink runat="server" NavigateUrl="~/Account/ForgotPassword.aspx" Text="¿Olvidó su contraseña?"  />
                                                    </div>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

            <Paddings Padding="0px"></Paddings>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                            </Items>
                        </dx:ASPxFormLayout>
               
        </div>
    </div>

</asp:Content>
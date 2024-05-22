using System;
using System.Web;
using DevExpress.Web;
using Microsoft.AspNet.Identity.Owin;
//using SG_Constancias.Model;
using Microsoft.AspNet.Identity;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Newtonsoft.Json.Linq;
using System.IO;
using System.Net;
using SG_Constancias.Models;
//using hbehr.recaptcha;
//using GoogleRecaptcha;
using System.Net.Sockets;
using System.Web.WebSockets;


namespace SG_Constancias
{
    public partial class SignInModule : System.Web.UI.Page 
    {

        //protected void Page_Load(object sender, EventArgs e)
        //{

        //    Form.Attributes.Add("autocomplete", "off");
        //    //UserNameTextBox.Focus();

        //    if (!Page.IsPostBack)
        //    {
        //        Session["SignInManager"] = null;

        //    }

        //    //String CodDen = (string)Session["Name_user"];
        //    //if (!IsPostBack)
        //    //{
        //    //    if (CodDen == "" || CodDen == null)
        //    //        Response.Redirect("~/Account/SignIn.aspx");
        //    //}

        //}

        const int MaxCharacterSetLength = 50;
        const string CaptchaCssPostfixSessionKey = "6aad54c0-25ef-11df-8a39-0800200c9a66";
   
        protected void Page_Load(object sender, EventArgs e)
        {
            Form.Attributes.Add("autocomplete", "off");
         
        }

        protected void SignInButton_Click(object sender, EventArgs e)
        {
            //FormLayout.FindItemOrGroupByName("GeneralError").Visible = false;
            //if (ASPxEdit.ValidateEditorsInContainer(this))
            //{
            //    // DXCOMMENT: You Authentication logic
            //    if (!AuthHelper.SignIn(UserNameTextBox.Text, PasswordButtonEdit.Text))
            //    {
            //        GeneralErrorDiv.InnerText = "Invalid login attempt.";
            //        FormLayout.FindItemOrGroupByName("GeneralError").Visible = true;
            //    }
            //    else
            //        Response.Redirect("~/");
            //}
            //if (!IsReCaptchValid())
            //{
            //    //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert(' ¡VALIDACIÓN CAPTCHA INCORRECTA!'); window.location = 'LoginO.aspx';", true);
            //    FailureText.Text = "¡Validación de Captcha Incorrecta!";
            //    ErrorMessage.Visible = true;
            //    //Response.Redirect("LoginO.aspx");
            //}
            //else
     
            {
                if (IsValid)
                {
                    // Validate the user password
                    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                    var signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();

                    // This doen't count login failures towards account lockout
                    // To enable password failures to trigger lockout, change to shouldLockout: true
                    var user = manager.FindByName(UserNameTextBox.Text);
                    if (user == null)
                    {
                        FailureText.Text = "Usuario o contraseña no válido. Inténtelo de nuevo.";
                        ErrorMessage.Visible = true;
                    }
                    else
                    {
                        if (user != null)
                        {
                            if (user.LockoutEnabled == false)
                            {
                                FailureText.Text = "Intento de inicio de sesión no válido. Su cuenta ha sido bloqueada. Comuníquese con el administrador del sistema para habilitar su cuenta.";
                                ErrorMessage.Visible = true;
                            }
                            else
                           if (!user.EmailConfirmed)
                            {
                                FailureText.Text = "Intento de inicio de sesión no válido. Debe tener una cuenta de correo electrónico confirmada.";
                                ErrorMessage.Visible = true;
                                // ResendConfirm.Visible = true;
                            }
                            else
                            {
                                //Para habilitar los errores de contraseña para desencadenar el bloqueo, cambie a shouldLockout := True

                                var result = signinManager.PasswordSignIn(UserNameTextBox.Text, PasswordButtonEdit.Text, isPersistent: false, shouldLockout: false);


                                switch (result)
                                {
                                    case SignInStatus.Success:
                                        string name_user = user.UserName;
                                        //string name_user = User.Identity.GetUserName();
                                        //IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);

                                        //string constr = ConfigurationManager.ConnectionStrings["DB_PARTICIPACIONConnectionString"].ConnectionString;
                                        string constr = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;

                                        //string SQL = "SELECT Nombre_Usuario, CodigoId, Email, P.Nombre_Cargo FROM AspNetUsers INNER JOIN tblCargos P ON P.ID_Cargo = Puesto WHERE UserName = '" + name_user + "'";
                                        string SQL = "SELECT Nombre_Usuario, CodigoId, Email FROM AspNetUsers WHERE UserName = '" + name_user + "'";

                                        using (SqlConnection con = new SqlConnection(constr))
                                        {
                                            using (SqlDataAdapter sda = new SqlDataAdapter(SQL, con))
                                            {
                                                using (DataSet ds = new DataSet())
                                                {
                                                    sda.Fill(ds);
                                                    //con.Close;
                                                    if (ds.Tables[0].Rows.Count > 0)
                                                    {
                                                        Session["Name_user"] = ds.Tables[0].Rows[0]["Nombre_Usuario"].ToString();
                                                        Session["User_id"] = ds.Tables[0].Rows[0]["CodigoId"].ToString();
                                                        Session["email"] = ds.Tables[0].Rows[0]["Email"].ToString();
          
                                                    }
                                                }
                                            }
                                        }


                                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                                        break;
                                    //case SignInStatus.LockedOut:
                                    //    Response.Redirect("~/Account/Lockout.aspx");
                                    //    break;
                                    //case SignInStatus.RequiresVerification:
                                    //    Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn.aspx?ReturnUrl={0}&RememberMe={1}",
                                    //                                     Request.QueryString["ReturnUrl"],
                                    //                                     false),
                                    //                    true);
                                    //    break;
                                    case SignInStatus.Failure:
                                    default:
                                        FailureText.Text = "Usuario o contraseña no válido. Inténtelo de nuevo.";
                                        ErrorMessage.Visible = true;
                                        break;

                                }
                            }
                        }
                    }
                }
            }
        }
        protected void SendEmailConfirmationToken(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = manager.FindByName(UserNameTextBox.Text);
            if (user != null)
            {
                if (!user.EmailConfirmed)
                {
                    string code = manager.GenerateEmailConfirmationToken(user.Id);
                    string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
                    manager.SendEmail(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>.");

                    FailureText.Text = "Confirmation email sent. Please view the email and confirm your account.";
                    ErrorMessage.Visible = true;
                    //ResendConfirm.Visible = false;
                }
            }
        }

            public bool IsReCaptchValid()
            {
                var result = false;
                var captchaResponse = Request.Form["g-recaptcha-response"];
                var secretKey = ConfigurationManager.AppSettings["recaptcha-secret-key"];
                var apiUrl = "https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}";
                var requestUri = string.Format(apiUrl, secretKey, captchaResponse);
                var request = (HttpWebRequest)WebRequest.Create(requestUri);

                using (WebResponse response = request.GetResponse())
                {
                    using (StreamReader stream = new StreamReader(response.GetResponseStream()))
                    {
                        JObject jResponse = JObject.Parse(stream.ReadToEnd());
                        var isSuccess = jResponse.Value<bool>("success");
                        result = (isSuccess) ? true : false;
                    }
                }
                return result;
            }


    }

}
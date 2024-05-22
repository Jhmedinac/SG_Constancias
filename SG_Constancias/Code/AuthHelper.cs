using System.Web;
using System.Data;
using System.Data.SqlClient;
using DevExpress.Web;
using SG_Constancias.App_Start;
using System.Configuration;
using System;

namespace SG_Constancias.Model {
    public class ApplicationUser {
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string AvatarUrl { get; set; }

       
    }

    public static class AuthHelper {
        public static bool SignIn(string userName, string password) {
            HttpContext.Current.Session["Name_user"] = CreateDefualtUser();  // Mock user data
            return true;
        }
        public static void SignOut() {
            HttpContext.Current.Session["Name_user"] = null;
        }
        public static bool IsAuthenticated() {
            return GetLoggedInUserInfo() != null;
        }

        public static ApplicationUser GetLoggedInUserInfo() {
            return HttpContext.Current.Session["Name_user"] as ApplicationUser;
        }
        private static ApplicationUser CreateDefualtUser() {

            return new ApplicationUser
            {
                ////UserName = HttpContext.Current.Session["Name_user"].ToString(),
                ////FirstName = "Julia",
                ////LastName = "Bell",
                ////Email = "julia.bell@example.com",
                ////AvatarUrl = "~/Content/Photo/Julia_Bell.jpg"
            };


        }
    }
}
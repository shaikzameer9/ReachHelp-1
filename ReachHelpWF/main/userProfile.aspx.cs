using ReachHelpWF.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReachHelpWF.main
{
    public partial class userProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static UserModel getUserDetails(string userId)
        {
            UserModel userDetails = new UserModel();
            return userDetails.GetUserDetails(userId);
        }

        [WebMethod]
        public static bool updateUserDetails(UserModel userDetails)
        {


            userDetails.userId = HttpContext.Current.Session["UserId"].ToString();
            bool pwdChangeStatus = false;
            bool usrDetailsUpdateStatus = userDetails.RegisterUser(userDetails);
            if (usrDetailsUpdateStatus)
            {
                if (userDetails.password == "" || userDetails.password == null)
                    return true;
                else
                    pwdChangeStatus = userDetails.ChangeUserPassword(userDetails.userId, userDetails.password);
            }

            if (pwdChangeStatus)
            {
                return userDetails.UpdateUserStatus(userDetails.userId, "Active");
            }

            return false;
        }
         

    }
}
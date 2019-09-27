using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReachHelpWF.Models;

namespace ReachHelpWF.main
{
    public partial class Dashboard : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null)
            {
                Response.Redirect("~/index.aspx");
            }

            userAccountName1.InnerText = Session["UserName"].ToString();
            userAccountName2.InnerText = Session["UserName"].ToString();

            //contributionCount.InnerText = new UserModel().GetCreditsOfUser(Session["UserId"].ToString()).ToString();

        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();            
            Response.Redirect("../index");
        }

        

    }
}
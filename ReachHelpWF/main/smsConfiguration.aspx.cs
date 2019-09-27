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
    public partial class smsConfiguration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static bool AddSMSMaster(MessagingModel smsDetails)
        {
            MessagingModel msgModel = new MessagingModel();
            return msgModel.AddSMSMaster(smsDetails);
        }

        [WebMethod]
        public static List<MessagingModel> ListSMSOperators()
        {
            MessagingModel msgModel = new MessagingModel();
            return msgModel.ListSMSOperators();
        }

    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Globalization;
using System.Threading;
using System.Configuration;
using System.Web.Http;
using ReachHelpWF.Models;

namespace ReachHelpWF
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {            
            RegisterRoutes(RouteTable.Routes);
        }
        static void RegisterRoutes(System.Web.Routing.RouteCollection routes)
        {
            routes.MapPageRoute("index", "index", "~/index.aspx");
            routes.MapPageRoute("mainindex", "main/index", "~/main/index.aspx");
            routes.MapPageRoute("allUsers", "main/allUsers", "~/main/allUsers.aspx");
            routes.MapPageRoute("InfoLinks", "main/InfoLinks", "~/main/InfoLinks.aspx");
            routes.MapPageRoute("categoriesPage", "main/categoriesPage", "~/main/categoriesPage.aspx");
            routes.MapPageRoute("myOffers", "main/myOffers", "~/main/myOffers.aspx");
            routes.MapPageRoute("myRequests", "main/myRequests", "~/main/myRequests.aspx");
            routes.MapPageRoute("offerHelp", "main/offerHelp", "~/main/offerHelp.aspx");
            routes.MapPageRoute("requestHelp", "main/requestHelp", "~/main/requestHelp.aspx");
            routes.MapPageRoute("subCategoriesPage", "main/subCategoriesPage", "~/main/subCategoriesPage.aspx");
            routes.MapPageRoute("userProfile", "main/userProfile", "~/main/userProfile.aspx");
            routes.MapPageRoute("manageLanguage", "main/manageLanguage", "~/main/manageLanguage.aspx");
            routes.MapPageRoute("reportsMonitor", "main/reportsMonitor", "~/main/reportsMonitor.aspx");
            routes.MapPageRoute("smsConfiguration", "main/smsConfiguration", "~/main/smsConfiguration.aspx");
            routes.MapPageRoute("ConfigUnits", "main/ConfigUnits", "~/main/ConfigUnits.aspx");
            routes.MapPageRoute("adminDash", "main/adminDash", "~/main/adminDash.aspx");
            routes.MapPageRoute("adminDetailed", "main/adminDetailed", "~/main/adminDetailed.aspx");
            
        }
        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}
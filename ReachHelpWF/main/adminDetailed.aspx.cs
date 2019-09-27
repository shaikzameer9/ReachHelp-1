using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using ReachHelpWF.Models;
using ReachHelpWF.Interfaces;

namespace ReachHelpWF.main
{
    public partial class adminDetailed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<ILatency> DetailedTotalLatency(string startDate, string endDate, string type)
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.DetailedTotalLatency(startDate, endDate, type);
        }

        [WebMethod]
        public static List<ILatency> DetailedAverageLatency(string startDate, string endDate, string type)
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.DetailedAverageLatency(startDate, endDate, type);
        }

        [WebMethod]
        public static List<IRatings> DetailedRatings(string startDate, string endDate, string type)
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.DetailedRatings(startDate, endDate, type);
        }

        [WebMethod]
        public static List<IDonations> DetailedAmount(string startDate, string endDate, string type)
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.DonationDetails(startDate, endDate, type);
        }

        [WebMethod]
        public static List<IUsers> DetailedUserRegistrationDetails(string startDate, string endDate, string type)
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.UserDetails(startDate, endDate, type);
        }
    }
}
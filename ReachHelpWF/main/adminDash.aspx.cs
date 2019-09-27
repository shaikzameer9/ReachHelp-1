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
    public partial class adminDash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ILatency AverageLatencyTotal = AverageLatency(false);
            ILatency AverageLatencyPM = AverageLatency(true);
            ILatency TotalLatencyTotal = TotalLatency(false);
            ILatency TotalLatencyPM = TotalLatency(true);

            IRatings RatingsTotal = Ratings(false);
            IRatings RatingsPM = Ratings(true);

            IUsers TotalUser = TotalUserCount();


            AverageLatencyCT.InnerHtml = AverageLatencyTotal.days + "d " + AverageLatencyTotal.hours + "h " + AverageLatencyTotal.minutes + "m ";
            AverageLatencyCP.InnerHtml = "<i class='green'>" + AverageLatencyPM.days + "d " + AverageLatencyPM.hours + "h " + AverageLatencyPM.minutes + "m  </i>From last month";

            TotalLatencyCT.InnerHtml = TotalLatencyTotal.days + "d " + TotalLatencyTotal.hours + "h " + TotalLatencyTotal.minutes + "m ";
            TotalLatencyCP.InnerHtml = "<i class='green'>" + TotalLatencyPM.days + "d " + TotalLatencyPM.hours + "h " + TotalLatencyPM.minutes + "m  </i>From last month";

            RatingsCT.InnerHtml = RatingsTotal.ratingCount.ToString();
            RatingsCP.InnerHtml = "<i class='green'>" + RatingsPM.ratingCount.ToString() + " </i>From last month";

            totalUsers.InnerHtml = TotalUser.userCount.ToString();


        }
        [WebMethod]
        public static ILatency AverageLatency(bool prevMonth)
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.AverageLatency(prevMonth);
        }

        [WebMethod]
        public static ILatency TotalLatency(bool prevMonth)
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.TotalLatency(prevMonth);
        }

        [WebMethod]
        public static IRatings Ratings(bool prevMonth)
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.Ratings(prevMonth);
        }

        [WebMethod]
        public static List<IVolume> ReceivedVolume(bool prevMonth)
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.ReceivedVolume(prevMonth);
        }

        [WebMethod]
        public static List<IVolume> OfferedVolume(bool prevMonth)
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.OfferedVolume(prevMonth);
        }

        [WebMethod]
        public static IUsers TotalUserCount()
        {
            IndicatorsModel indicator = new IndicatorsModel();
            return indicator.TotalUserCount();
        }

        [WebMethod]
        public static List<HeatMaps> getHeatMapData() {
            HeatMaps heatMap = new HeatMaps();
            return heatMap.GetHeatMapData();
        }
    }
}
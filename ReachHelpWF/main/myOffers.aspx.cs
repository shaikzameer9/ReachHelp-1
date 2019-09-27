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
    public partial class myOffers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<OffersModel> GetMyOffers(string userId, int startValue, int noOfRows)
        {
            userId = HttpContext.Current.Session["UserId"].ToString();
            OffersModel offersModel = new OffersModel();
            return offersModel.MyOffers(userId, startValue, noOfRows);
        }


        [WebMethod]
        public static List<RequestsModel> RequestListForOffer(string offerId, int startValue, int noOfRows)
        {
            RequestsModel reqModel = new RequestsModel();
            return reqModel.ListRequests(offerId, startValue, noOfRows);
        }

        [WebMethod]
        public static bool RespondToRequest(RequestsModel requestResponse)
        {
            RequestsModel requestModel = new RequestsModel();
            return requestModel.RespondToRequest(requestResponse);
        }

        [WebMethod]
        public static bool CancelOffer(string offerId)
        {
            OffersModel offersModel = new OffersModel();
            return offersModel.CancelOffer(offerId);
        }    


    }
}
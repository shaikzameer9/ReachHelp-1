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
    public partial class myRequests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<RequestsModel> MyRequests(string userId, int startValue, int noOfRows)
        {
            userId = HttpContext.Current.Session["UserId"].ToString();
            RequestsModel requestModel = new RequestsModel();
            return requestModel.MyRequests(userId, startValue, noOfRows);
        }

        [WebMethod]
        public static List<OffersModel> AvailableOffersList(string requestId, int startValue, int noOfRows)
        {
            OffersModel offersModel = new OffersModel();
            return offersModel.AvailableOffersList(requestId, startValue, noOfRows);
        }

        [WebMethod]
        public static bool RequestOffer(OffersModel offerResponse)
        {
            OffersModel offersModel = new OffersModel();
            return offersModel.RequestOffer(offerResponse);
        }

        [WebMethod]
        public static bool ConfirmOffer(OffersModel offerResponse)
        {
            OffersModel offersModel = new OffersModel();
            return offersModel.ConfirmOffer(offerResponse);
        }


        [WebMethod]
        public static bool CancelRequest(string requestId)
        {
            RequestsModel requestsModel = new RequestsModel();
            return requestsModel.CancelRequest(requestId);
        }

        [WebMethod]
        public static bool RequestAnOffer(OffersModel offerDetails,RequestsModel requestDetails)
        {
            RequestsModel request = new RequestsModel();   
            OffersModel offer = new OffersModel();
            offerDetails.requestId = request.GeneralRequest(requestDetails);
            return offer.RequestOffer(offerDetails);
        }

        [WebMethod]
        public static bool RateOffer(int requestId,float rating)
        {
            OffersModel offer = new OffersModel();
            return offer.ReviewOffer(requestId, rating);
        }

    }
}
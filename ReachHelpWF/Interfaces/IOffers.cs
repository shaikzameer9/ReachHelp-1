using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ReachHelpWF.Models;

namespace ReachHelpWF.Interfaces
{
    public interface IOffers
    {
        string offerId { get; set; }
        string requestId { get; set; }
        string offerCategoryId { get; set; }
        string offerCategoryName { get; set; }
        string offerSubCategoryId { get; set; }
        string offerSubCategoryName { get; set; }
        string offeredById { get; set; }
        string offeredByName { get; set; }
        string offerQuantity { get; set; }
        string offerUnit { get; set; }
        string offerDeliveryMode { get; set; }
        string offerDeliveryAddress { get; set; }
        string offerPostedDate { get; set; }
        string offerStatus { get; set; }
        string error { get; set; }        
        string credits { get; set; }
        List<string> imagePath { get; set; }
        string description { get; set; }
        string count { get; set; }
        string unitId { get; set; }
        string categoryId { get; set; }
        string subCategoryId { get; set; }        

        bool CreateOffer(OffersModel myOffer);

        List<OffersModel> MyOffers(string userId, int startValue, int noOfRows);

        List<OffersModel> ListOffers(string categoryId, string subCategoryId);

        List<OffersModel> AvailableOffersList(string requestId, int startValue, int noOfRows);

        bool RequestOffer(OffersModel offerResponse);

        bool CancelOfferRequest(OffersModel offerList);

        bool ConfirmOffer(OffersModel offerResponse);

        bool CancelOffer(string offerId);
        List<IOffers> ActiveOffers(int categoryId, int startValue, int noOfRows, string location, float userlat, float userLng);
    }
}

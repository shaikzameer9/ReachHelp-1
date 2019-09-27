using ReachHelpWF.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReachHelpWF.Interfaces;
using ReachHelpWF.Models;
using System.Configuration;

namespace ReachHelpWF
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //UserModel newUser = new UserModel();
            //newUser.userName = "Prasanna Datha";
            //newUser.entityName = "";
            //newUser.phoneNumber = "9632940020";
            //newUser.password = "test123";
            //newUser.roleId = "3";
            //newUser.designation = "";
            //newUser.address = "Prasanna Nivas, JP Compound, Vidhyanagar Extn., Chantar, Brahmavar - 576213";
            //newUser.countryId = "1";
            //newUser.stateId = "1";
            //newUser.cityId = "1";
            //newUser.pincode = "576213";
            //newUser.latitude = "";
            //newUser.longitude = "";

            //bool regStatus = AddUser(newUser);
            //Debug.Write("Registration Status : "+regStatus);     
            //MessagingModel email = new MessagingModel();
            //RequestsModel request = new Models.RequestsModel();
            //email.TriggerEmail(request.GetRequestorDetails("20039"), "Response for your request", "<!DOCTYPE html><html> <head> <meta charset=\"utf-8\"> </head> <body> <p> Dear User, </p><br><p> A response has been made for your request. Kindly Login to <a href=\"http://reachelp.in\">ReachHelp<a> to respond. </p></body></html>");

        }

        

        [WebMethod]
        //public static bool AddUser(string userName, string phoneNumber, string password, string roleId, string entityName, string designation, string address, string countryId, string stateId, string cityId, string pincode, string latitude, string longitude, string status)
        public static bool AddUser(UserModel userDetails)
        {
           // UserModel userDetails = new UserModel(userName, phoneNumber, password, roleId, entityName, designation, address, countryId, stateId, cityId, pincode, latitude, longitude);
            return userDetails.RegisterUser(userDetails);
        }

        [WebMethod]
        public static List<IOffers> getActiveOffers(int categoryId, int startValue, int noOfRows, string searchVal, float userLat, float userLng)
        {
            OffersModel offersModel = new OffersModel();
            return offersModel.ActiveOffers(categoryId, startValue, noOfRows, searchVal, userLat, userLng);
        }

        [WebMethod]
        public static string makeRequest(int offerId, OffersModel offerDetails)
        {
            string resp = "Expired";
            if (HttpContext.Current.Session["UserName"] != null)
            {
                resp = "Success";
            }
            else
            {
                HttpContext.Current.Session["OfferId"] = offerId;
                HttpContext.Current.Session["OfferCategoryId"] = offerDetails.offerCategoryId;
                HttpContext.Current.Session["OfferSubCategoryId"] = offerDetails.offerSubCategoryId;
                HttpContext.Current.Session["OfferQuantity"] = offerDetails.offerQuantity;
                HttpContext.Current.Session["OfferUnit"] = offerDetails.unitId;
            }
            return resp;
        }


        [WebMethod]
        public static List<CategoryModel> listCategoryAndSubCategory()
        {
            CategoryModel category = new CategoryModel();
            return category.ListCategoryAndSubCategory();
        }

        //ActiveOffersSubCategory(int subCategoryId, int startValue, int noOfRows)
        [WebMethod]
        public static List<IOffers> activeOffersSubCategory(int subCategoryId, int startValue, int noOfRows)
        {
            OffersModel offers = new OffersModel();
            return offers.ActiveOffersSubCategory(subCategoryId, startValue, noOfRows);
        }

        [WebMethod]
        public static string sendFeedback(string type, string description, string firstname, string lastname, string email)
        {
            MessagingModel msgModel = new MessagingModel();
            string fullname = firstname + " " + lastname;
            UserModel user = new UserModel();
            user.emailId = ConfigurationManager.AppSettings["SUPPORT_EMAIL"].ToString();
            user.userName = "Admin";

            string emailContent = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"></head><body><p> Dear Admin, </p><p><strong>Feedback Subject :</strong> <span>" + type + "</span></p><p style='text-indent:5em; text-align:justify;'>" + description + "</p><p>Regards,</p><p style='margin:0;'>" + fullname + "</p>" + email + "</body></html>";

            string retVal = msgModel.TriggerEmail(user, "ReacHelp Feedback", emailContent);

            //string retVal = msgModel.TriggerEmail("prasanna.datha@apcogsys.net", "Admin", "Welcome to ReacHelp", "<!DOCTYPE html><html><head><meta charset=\"utf-8\"></head><body><p> Dear Admin, </p><p><strong>Feedback Subject :</strong> <span>" + type + "</span></p><p style='text-indent:5em; text-align:justify;'>" + description + "</p><p>Regards,</p><p style='margin:0;'>" + fullname + "</p>" + email + "</body></html>");
            
            return retVal;
        }
       

    }
}
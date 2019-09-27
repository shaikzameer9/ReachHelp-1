using ReachHelpWF.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Newtonsoft.Json;

namespace ReachHelpWF.main
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"].ToString() != null)
            {
                if (Session["UserRole"].ToString() == "User")
                {
                    if (Session["AccountStatus"].ToString() == "Active")
                    {
                        Response.Redirect("./requestHelp");
                    }
                    else if (Session["AccountStatus"].ToString() == "New")
                    {
                        Response.Redirect("./userProfile");
                    }

                }
                else if (Session["UserRole"].ToString() == "SysAdmin")
                {
                    Response.Redirect("./allUsers");
                }
                else if (Session["UserRole"].ToString() == "Monitor")
                {
                    Response.Redirect("./reportsMonitor");
                }
            }
            else {
                Response.Redirect("../index");            
            }            
        }

        [WebMethod]
        public static List<CategoryModel> ListCategoryForUser(string languageId)
        {
            CategoryModel category = new CategoryModel();
            return category.ListCategoryForUser(languageId);
        }

        /// Done
        [WebMethod]
        public static List<CategoryModel> ListCategoryForAdmin(int startValue, int noOfRows)
        {
            CategoryModel category = new CategoryModel();
            return category.ListCategoryForAdmin(startValue, noOfRows);
        }

        /// Done
        [WebMethod]
        public static List<CategoryModel> ListSubCategoryForAdmin(int startValue, int noOfRows)
        {
            CategoryModel category = new CategoryModel();
            return category.GetSubCategoryForAdmin(startValue,noOfRows);
        }

        /// Done
        [WebMethod]
        public static List<CategoryModel> ListSubCategoryForUser(string categoryId, string languageId)
        {
            CategoryModel category = new CategoryModel();
            return category.GetSubCategoryForUser(categoryId, languageId);
        }

        /// Done
        [WebMethod]
        public static List<RolesModel> ListRoles()
        {
            RolesModel category = new RolesModel();
            return category.ListUserRoles();
        }

        /// Done
        [WebMethod]
        public static bool AddCategory(CategoryModel categoryDetails)
        {
            CategoryModel category = new CategoryModel();
            return category.AddCategory(categoryDetails);
        }

        /// Done
        [WebMethod]
        public static bool AddSubCategory(CategoryModel categoryDetails)
        {
            CategoryModel category = new CategoryModel();
            return category.AddSubCategory(categoryDetails);
        }

        [WebMethod]
        public static bool AddInfoLinks(InfoLinksModel infoLinkDetails)
        {
            infoLinkDetails.infoLinkAddedById = HttpContext.Current.Session["UserId"].ToString();
            InfoLinksModel infoLinks = new InfoLinksModel();
            return infoLinks.AddInfoLinks(infoLinkDetails);
        }

        [WebMethod]
        public static List<InfoLinksModel> ListInfoLinksForUser()
        {
            InfoLinksModel infoLinks = new InfoLinksModel();
            return infoLinks.ListInfoLinksUser();
        }

        [WebMethod]
        public static List<InfoLinksModel> ListInfoLinksForAdmin(int startValue, int noOFRows)
        {
            InfoLinksModel infoLinks = new InfoLinksModel();
            return infoLinks.ListInfoLinksAdmin(startValue, noOFRows);
        }

        [WebMethod]
        public static List<LanguageModel> ListAllLanguages()
        {
            LanguageModel languages = new LanguageModel();
            return languages.ListLanguages();
        }

        [WebMethod]
        public static bool AddLanguage(string languageName, string languageId)
        {
            LanguageModel language = new LanguageModel();
            return language.AddLanguage(languageName, languageId);
        }



        [WebMethod]
        public static List<UnitModel> GetUnits(string subCategoryId)
        {
            UnitModel unitList = new UnitModel();
            return unitList.GetUnitsForSubCategory(subCategoryId);
        }

        /// Done
        [WebMethod]
        public static List<UnitModel> GetAllUnits()
        {
            UnitModel unitList = new UnitModel();
            return unitList.GetAllUnits();
        }

        [WebMethod]
        public static List<UserModel> GetAllMonitors(int startValue, int noOfRows)
        {
            UserModel userModel = new UserModel();
            return userModel.GetAllMonitors(startValue, noOfRows);
        }

        [WebMethod]
        public static List<RegionModel> GetCountries()
        {
            RegionModel countryList = new RegionModel();
            return countryList.GetCountries();
        }

        [WebMethod]
        public static List<RegionModel> GetStates(string countryId)
        {
            RegionModel stateList = new RegionModel();
            return stateList.GetStateOfCountry(countryId);
        }
        [WebMethod]
        public static List<RegionModel> GetCities(string stateId)
        {
            RegionModel cityList = new RegionModel();
            return cityList.GetCityOfState(stateId);
        }

        [WebMethod]
        public static bool AddUser(UserModel userDetails)
        {
            return userDetails.RegisterUser(userDetails);
        }

        [WebMethod]
        public static bool UpdateUserStatus(string userId, string status)
        {
            UserModel userModel = new UserModel();
            return userModel.UpdateUserStatus(userId, status);
        }

        [WebMethod]
        public static bool MakeRequest(RequestsModel myRequest)
        {
            myRequest.requestedById = HttpContext.Current.Session["UserId"].ToString();
            RequestsModel requestModel = new RequestsModel();
            return requestModel.MakeRequest(myRequest);
        }

        [WebMethod]
        public static bool CreateOffer(OffersModel myOffer)
        {
            myOffer.offeredById = HttpContext.Current.Session["UserId"].ToString();
            OffersModel offerModel = new OffersModel();
            return offerModel.CreateOffer(myOffer);
        }

        [WebMethod]
        public static List<LanguageModel> ListLanguagesForAdmin()
        {
            LanguageModel listLanguages = new LanguageModel();
            return listLanguages.ListLanguagesForAdmin();
        }

        [WebMethod]
        public static List<LanguageModel> ListLanguageWords(string LangId)
        {
            LanguageModel listLanguages = new LanguageModel();
            return listLanguages.ListLanguageWords(LangId);
        }

        [WebMethod]
        public static bool LanguageTranslation(string englishWord, string languageId, string languageWord)
        {
            LanguageModel listLanguages = new LanguageModel();
            return listLanguages.LanguageTranslation(englishWord, languageId, languageWord);
        }

        [WebMethod]
        public static string sendMessage(ChatMessageModel messageDetails)
        {
            ChatMessageModel chat = new ChatMessageModel();
            return chat.sendMessage(messageDetails);
        }

        [WebMethod]
        public static List<ChatMessageModel> getChatMessages(int offerId, int requestorUserId, int offererUserId)
        {
            ChatMessageModel chat = new ChatMessageModel();
            return chat.getMessages(offerId, requestorUserId, offererUserId);
        }

    }
}
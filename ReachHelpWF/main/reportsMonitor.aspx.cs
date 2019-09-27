using ReachHelpWF.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Newtonsoft.Json;
using System.Data.SqlClient;

namespace ReachHelpWF.main
{
    public partial class reportsMonitor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<OffersModel> OffersReport(string fromDate, string toDate, int startValue, int noOFRows, int cityId)
        {
            ReportsModel reports = new ReportsModel();
            return reports.OffersReport(fromDate, toDate, startValue, noOFRows, cityId);
        }

        [WebMethod]
        public static List<OffersModel> OffersReportByCategory(string fromDate, string toDate, string categoryId, int startValue, int noOFRows, int cityId)
        {
            ReportsModel reports = new ReportsModel();
            return reports.OffersReportByCategory(fromDate, toDate, categoryId, startValue, noOFRows, cityId);
        }

        [WebMethod]
        public static List<OffersModel> OffersReportBySubCategory(string fromDate, string toDate, string subCategoryId, int startValue, int noOFRows, int cityId)
        {
            ReportsModel reports = new ReportsModel();
            return reports.OffersReportBySubCategory(fromDate, toDate, subCategoryId, startValue, noOFRows, cityId);
        }

        [WebMethod]
        public static List<RequestsModel> RequestReport(string fromDate, string toDate, int startValue, int noOFRows, int cityId)
        {
            ReportsModel reports = new ReportsModel();
            return reports.RequestReport(fromDate, toDate, startValue, noOFRows, cityId);
        }

        [WebMethod]
        public static List<RequestsModel> RequestReportByCategory(string fromDate, string toDate, string categoryId, int startValue, int noOFRows, int cityId)
        {
            ReportsModel reports = new ReportsModel();
            return reports.RequestReportByCategory(fromDate, toDate, categoryId, startValue, noOFRows, cityId);
        }

        [WebMethod]
        public static List<RequestsModel> RequestReportBySubCategory(string fromDate, string toDate, string subCategoryId, int startValue, int noOFRows, int cityId)
        {
            ReportsModel reports = new ReportsModel();
            return reports.RequestReportBySubCategory(fromDate, toDate, subCategoryId, startValue, noOFRows, cityId);
        }


        [WebMethod]
        public static List<Select2Item> SearchRegion(string searchVal)
        {
            RegionModel regionModel = new RegionModel();
            return regionModel.SearchRegion(searchVal);
        }        

    }
}
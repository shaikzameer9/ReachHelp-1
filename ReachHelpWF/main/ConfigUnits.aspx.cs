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
    public partial class ConfigUnits : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static List<UnitModel> GetAllUnits()
        {
            UnitModel unitModel = new UnitModel();
            return unitModel.GetAllUnits();
        }

        [WebMethod]
        public static bool AddUpdateUnit(UnitModel unitConfig)
        {
            UnitModel unitModel = new UnitModel();
            return unitModel.AddUpdateUnitForAdmin(unitConfig);
        }

    }
}
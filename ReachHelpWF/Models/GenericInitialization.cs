using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;


namespace ReachHelpWF.Models
{
    public class GenericInitialization
    {
        public string connectionString = ConfigurationManager.AppSettings["CONNECTION_STRING"].ToString();
        //public string connectionString = ConfigurationManager.ConnectionStrings["Test_Connection"].ToString();//ConfigurationManager.AppSettings["CONNECTION_STRING"];
        public SqlConnection sqlConnection;
        public SqlCommand sqlCommand;
        public SqlDataReader sqlDataReader;
        public string queryString { get; set; }
    }
}
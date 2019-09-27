using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ReachHelpWF.Models
{
    public class HeatMaps
    {
        public string name { get; set; }
        public string location { get; set; }

        public string error { get; set; }

        public List<HeatMaps> GetHeatMapData()
        {
            List<HeatMaps> heatMapData = new List<HeatMaps>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT UR.City_Name AS City, CONCAT(UR.Latitude,',',UR.Longitude) AS GeoLocation FROM My_Requests REQ JOIN User_Register UR ON UR.User_Id = REQ.Requested_By JOIN Sub_Category_Master SCM ON REQ.Sub_Category_Id = SCM.Sub_Category_Id GROUP BY UR.City_Name, SCM.Sub_Category_Name, UR.Latitude, UR.Longitude";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                heatMapData.Add(new HeatMaps
                                {
                                    name = gen.sqlDataReader["City"].ToString(),
                                    location = gen.sqlDataReader["GeoLocation"].ToString()
                                });
                            }
                        }

                    }
                }
            }
            catch (SqlException ex)
            {
                heatMapData.Add(new HeatMaps
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                heatMapData.Add(new HeatMaps
                {
                    error = "Error"
                });
            }
            return heatMapData;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace ReachHelpWF.Models
{
    public class RegionModel
    {
        public string countryId { get; set; }
        public string countryName { get; set; }
        public string stateId { get; set; }
        public string stateName { get; set; }
        public string cityId { get; set; }
        public string cityName { get; set; }
        public string error { get; set; }
        public string regionId { get; set; }
        public string regionName { get; set; }
        public string regionLatitude { get; set; }
        public string regionLongitude { get; set; }
        public string regionStatus { get; set; }
        //public string error { get; set; }

        public List<RegionModel> GetCountries()
        {
            GenericInitialization gen = new GenericInitialization();
            List<RegionModel> countryList = new List<RegionModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT * FROM  Country_Master";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    countryList.Add(new RegionModel
                                    {
                                        countryId = gen.sqlDataReader["Country_Id"].ToString(),
                                        countryName = gen.sqlDataReader["Country_Name"].ToString(),
                                    });                                                                      
                                }
                            }
                        }
                    }
                }                
            }
            catch (SqlException ex)
            {
                countryList.Add(new RegionModel
                {
                    error = "Error"
                });  
            }
            catch (Exception ex)
            {
                countryList.Add(new RegionModel
                {
                    error = "Error"
                }); 
            }
            return countryList;
        }
       
        public List<RegionModel> GetStateOfCountry(string countryId)
        {
            GenericInitialization gen = new GenericInitialization();
            List<RegionModel> stateList = new List<RegionModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                    {
                        gen.sqlConnection.Open();
                        gen.queryString = "SELECT * FROM  State_Master WHERE Country_Id=@countryId";
                        using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                        {

                            gen.sqlCommand.Parameters.AddWithValue("@countryId", countryId);
                            using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                            {
                                if (gen.sqlDataReader.HasRows)
                                {
                                    while (gen.sqlDataReader.Read())
                                    {
                                        stateList.Add(new RegionModel
                                        {
                                            stateId = gen.sqlDataReader["State_Id"].ToString(),
                                            stateName = gen.sqlDataReader["State_Name"].ToString(),
                                        });                                     
                                    }
                                }
                            }
                        }
                    }
            }
            catch (SqlException ex)
            {
                stateList.Add(new RegionModel
                {
                    error = "Error"
                }); 
            }
            catch (Exception ex)
            {
                stateList.Add(new RegionModel
                {
                    error = "Error"
                }); 
            }
            return stateList;
        }

        public List<RegionModel> GetCityOfState(string stateId)
        {
            GenericInitialization gen = new GenericInitialization();
            List<RegionModel> cityList = new List<RegionModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT * FROM City_Master WHERE State_Id=@sid";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {

                        gen.sqlCommand.Parameters.AddWithValue("@sid", stateId);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    cityList.Add(new RegionModel
                                    {
                                        cityId = gen.sqlDataReader["City_Id"].ToString(), 
                                        cityName = gen.sqlDataReader["City_Name"].ToString()   
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                cityList.Add(new RegionModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                cityList.Add(new RegionModel
                {
                    error = "Error"
                });
            }
            return cityList;
        }       

        public bool AddRegion(RegionModel regionDetails)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (regionDetails.regionId == "" || regionDetails.regionId == null)
                    {
                        gen.queryString = "INSERT INTO  [ReachHelp].[dbo].[Region_Master] VALUES(@regionName,@regionLatitude,@regionLongitude,@regionStatus)";
                    }
                    else
                    {
                        gen.queryString = "UPDATE [ReachHelp].[dbo].[Region_Master] SET Latitude=@regionLatitude,Longitude=@regionLongitude,Region_Name=@regionName,Region_Status=@regionStatus WHERE Region_Id=@regionId";
                    }
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@regionName", regionDetails.regionName);
                        gen.sqlCommand.Parameters.AddWithValue("@regionLatitude", regionDetails.regionName);
                        gen.sqlCommand.Parameters.AddWithValue("@regionLongitude", regionDetails.regionName);
                        gen.sqlCommand.Parameters.AddWithValue("@regionStatus", regionDetails.regionName);
                        if (regionDetails.regionId == "" || regionDetails.regionId == null)
                            gen.sqlCommand.Parameters.AddWithValue("@regionId", regionDetails.regionId);
                        if (gen.sqlCommand.ExecuteNonQuery() > 0)
                            return true;
                    }
                }
            }
            catch (SqlException ex)
            {
                return false;
            }
            catch (Exception ex)
            {
                return false;
            }
            return false;
        }

        public List<RegionModel> GetRegionsForAdmin()
        {
            GenericInitialization gen = new GenericInitialization();
            List<RegionModel> regionList = new List<RegionModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT * FROM [ReachHelp].[dbo].[Region_Master]";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                regionList.Add(new RegionModel
                                {
                                    regionId = gen.sqlDataReader["Region_Id"].ToString(),
                                    regionName = gen.sqlDataReader["Region_Name"].ToString(),
                                    regionLatitude = gen.sqlDataReader["Latitude"].ToString(),
                                    regionLongitude = gen.sqlDataReader["Longitude"].ToString(),
                                    regionStatus = gen.sqlDataReader["Region_Status"].ToString()
                                });
                            }
                        }

                    }
                }
            }
            catch (SqlException ex)
            {
                regionList.Add(new RegionModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                regionList.Add(new RegionModel
                {
                    error = "Error"
                });
            }
            return regionList;
        }

        public List<RegionModel> GetRegions()
        {
            GenericInitialization gen = new GenericInitialization();
            List<RegionModel> regionList = new List<RegionModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT * FROM [ReachHelp].[dbo].[Region_Master] WHERE [Region_Status]='Active'";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                regionList.Add(new RegionModel
                                {
                                    regionId = gen.sqlDataReader["Region_Id"].ToString(),
                                    regionName = gen.sqlDataReader["Region_Name"].ToString(),
                                    regionLatitude = gen.sqlDataReader["Latitude"].ToString(),
                                    regionLongitude = gen.sqlDataReader["Longitude"].ToString(),
                                    regionStatus = gen.sqlDataReader["Region_Status"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                regionList.Add(new RegionModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                regionList.Add(new RegionModel
                {
                    error = "Error"
                });
            }
            return regionList;
        }

        public List<Select2Item> SearchRegion(string searchVal)
        {
            GenericInitialization gen = new GenericInitialization();
            List<Select2Item> cityList = new List<Select2Item>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT * FROM City_Master WHERE City_Name LIKE @searchVal+'%'";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {

                        gen.sqlCommand.Parameters.AddWithValue("@searchVal", searchVal);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    cityList.Add(new Select2Item
                                    {
                                        id = gen.sqlDataReader["City_Id"].ToString(),
                                        text = gen.sqlDataReader["City_Name"].ToString()
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                cityList.Add(new Select2Item
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                cityList.Add(new Select2Item
                {
                    error = "Error"
                });
            }
            return cityList;
        }

    }

    public class Select2Item
    {
        public string id { get; set; }
        public string text { get; set; }
        public string error { get; set; }
    }

}
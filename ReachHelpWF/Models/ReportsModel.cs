using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace ReachHelpWF.Models
{
    public class ReportsModel
    {
        public string count { get; set; }
        public List<OffersModel> OffersReport(string fromDate, string toDate, int startValue, int noOFRows, int cityId)
        {
            List<OffersModel> offersReport = new List<OffersModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "DECLARE @count INT;SELECT @count=COUNT(Category_Name) FROM [ReachHelp].[dbo].[My_Offers]MO JOIN [ReachHelp].[dbo].[Category_Master]CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=MO.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MO.Offered_By LEFT JOIN [ReachHelp].[dbo].[Offer_Request_Mapping]ORM ON ORM.Offer_Id=MO.My_Offer_Id WHERE UR.City_Id = @cityId AND Posted_Date BETWEEN @fromDate AND @toDate;SELECT Category_Name,Sub_Category_Name,CASE WHEN ORM.Responded_Quantity IS NULL THEN MO.Quantity ELSE Responded_Quantity END Quantity,Unit_Name,User_Name AS Offered_By,MO.Status,Posted_Date,@count AS [Count] FROM [ReachHelp].[dbo].[My_Offers]MO JOIN [ReachHelp].[dbo].[Category_Master]CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=MO.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MO.Offered_By LEFT JOIN [ReachHelp].[dbo].[Offer_Request_Mapping]ORM ON ORM.Offer_Id=MO.My_Offer_Id WHERE UR.City_Id = @cityId AND Posted_Date BETWEEN @fromDate AND @toDate ORDER BY MO.My_Offer_Id OFFSET @startValue ROWS FETCH NEXT @noOFRows ROWS ONLY";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@fromDate", fromDate);
                        gen.sqlCommand.Parameters.AddWithValue("@toDate", toDate);
                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@cityId", cityId);
                        gen.sqlCommand.Parameters.AddWithValue("@noOFRows", noOFRows);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                offersReport.Add(new OffersModel
                                {
                                    offerCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    offerSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    offerQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                    offerUnit = gen.sqlDataReader["Unit_Name"].ToString(),
                                    offeredByName = gen.sqlDataReader["Offered_By"].ToString(),
                                    offerStatus = gen.sqlDataReader["Status"].ToString(),
                                    offerPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString()
                                });
                            }
                        }

                    }
                }
            }
            catch (SqlException ex)
            {
                offersReport.Add(new OffersModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                offersReport.Add(new OffersModel
                {
                    error = "Error"
                });
            }
            return offersReport;
        }

        public List<OffersModel> OffersReportByCategory(string fromDate, string toDate, string categoryId, int startValue, int noOFRows, int cityId)
        {
            List<OffersModel> offersReport = new List<OffersModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "DECLARE @count INT;SELECT @count = COUNT(Category_Name) FROM [ReachHelp].[dbo].[My_Offers]MO JOIN [ReachHelp].[dbo].[Category_Master]CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=MO.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MO.Offered_By LEFT JOIN [ReachHelp].[dbo].[Offer_Request_Mapping]ORM ON ORM.Offer_Id=MO.My_Offer_Id WHERE CM.Category_Id = @categoryId AND UR.City_Id = @cityId AND Posted_Date BETWEEN @fromDate AND @toDate;SELECT Category_Name,Sub_Category_Name,CASE WHEN ORM.Responded_Quantity IS NULL THEN MO.Quantity ELSE Responded_Quantity END Quantity,Unit_Name,User_Name AS Offered_By,MO.Status,Posted_Date,@count AS [Count] FROM [ReachHelp].[dbo].[My_Offers]MO JOIN [ReachHelp].[dbo].[Category_Master]CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=MO.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MO.Offered_By LEFT JOIN [ReachHelp].[dbo].[Offer_Request_Mapping]ORM ON ORM.Offer_Id=MO.My_Offer_Id WHERE CM.Category_Id = @categoryId AND UR.City_Id = @cityId AND Posted_Date BETWEEN @fromDate AND @toDate ORDER BY MO.My_Offer_Id OFFSET @startValue ROWS FETCH NEXT @noOFRows ROWS ONLY";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@fromDate", fromDate);
                        gen.sqlCommand.Parameters.AddWithValue("@toDate", toDate);
                        gen.sqlCommand.Parameters.AddWithValue("@categoryId", categoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@cityId", cityId);
                        gen.sqlCommand.Parameters.AddWithValue("@noOFRows", noOFRows);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                offersReport.Add(new OffersModel
                                {
                                    offerCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    offerSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    offerQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                    offerUnit = gen.sqlDataReader["Unit_Name"].ToString(),
                                    offeredByName = gen.sqlDataReader["Offered_By"].ToString(),
                                    offerStatus = gen.sqlDataReader["Status"].ToString(),
                                    offerPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString(),
                                });
                            }
                        }

                    }
                }
            }
            catch (SqlException ex)
            {
                offersReport.Add(new OffersModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                offersReport.Add(new OffersModel
                {
                    error = "Error"
                });
            }
            return offersReport;
        }

        public List<OffersModel> OffersReportBySubCategory(string fromDate, string toDate, string subCategoryId, int startValue, int noOFRows, int cityId)
        {
            List<OffersModel> offersReport = new List<OffersModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "DECLARE @count INT;SELECT @count=COUNT(Category_Name) FROM [ReachHelp].[dbo].[My_Offers]MO JOIN [ReachHelp].[dbo].[Category_Master]CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=MO.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MO.Offered_By LEFT JOIN [ReachHelp].[dbo].[Offer_Request_Mapping]ORM ON ORM.Offer_Id=MO.My_Offer_Id WHERE SCM.Sub_Category_Id = @subCategoryId UR.City_Id=@cityId AND Posted_Date BETWEEN @fromDate AND @toDate;SELECT Category_Name,Sub_Category_Name,CASE WHEN ORM.Responded_Quantity IS NULL THEN MO.Quantity ELSE Responded_Quantity END Quantity,Unit_Name,User_Name AS Offered_By,MO.Status,Posted_Date,@count AS [Count] FROM [ReachHelp].[dbo].[My_Offers]MO JOIN [ReachHelp].[dbo].[Category_Master]CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=MO.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MO.Offered_By LEFT JOIN [ReachHelp].[dbo].[Offer_Request_Mapping]ORM ON ORM.Offer_Id=MO.My_Offer_Id WHERE SCM.Sub_Category_Id = @subCategoryId AND UR.City_Id=@cityId AND Posted_Date BETWEEN @fromDate AND @toDate ORDER BY MO.My_Offer_Id OFFSET @startValue ROWS FETCH NEXT @noOFRows ROWS ONLY ";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@fromDate", fromDate);
                        gen.sqlCommand.Parameters.AddWithValue("@toDate", toDate);
                        gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", subCategoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@cityId", cityId);
                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@noOFRows", noOFRows);

                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                offersReport.Add(new OffersModel
                                {
                                    offerCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    offerSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    offerQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                    offerUnit = gen.sqlDataReader["Unit_Name"].ToString(),
                                    offeredByName = gen.sqlDataReader["Offered_By"].ToString(),
                                    offerStatus = gen.sqlDataReader["Status"].ToString(),
                                    offerPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString(),
                                });
                            }
                        }

                    }
                }
            }
            catch (SqlException ex)
            {
                offersReport.Add(new OffersModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                offersReport.Add(new OffersModel
                {
                    error = "Error"
                });
            }
            return offersReport;
        }

        public List<RequestsModel> RequestReport(string fromDate, string toDate, int startValue, int noOFRows, int cityId)
        {
            List<RequestsModel> requestReport = new List<RequestsModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "DECLARE @count INT;SELECT @count= COUNT(Category_Name) FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id = MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MR.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MR.Requested_By WHERE UR.City_Id=@cityId AND Posted_Date BETWEEN @fromDate AND @toDate;SELECT Category_Name,Sub_Category_Name,Quantity,Unit_Name,User_Name,Posted_Date, MR.Status,@count AS [Count] FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id = MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MR.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MR.Requested_By WHERE UR.City_Id=@cityId AND Posted_Date BETWEEN @fromDate AND @toDate ORDER BY MR.My_Request_Id OFFSET @startValue ROWS FETCH NEXT @noOFRows ROWS ONLY";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@fromDate", fromDate);
                        gen.sqlCommand.Parameters.AddWithValue("@toDate", toDate);
                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@cityId", cityId);
                        gen.sqlCommand.Parameters.AddWithValue("@noOFRows", noOFRows);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                requestReport.Add(new RequestsModel
                                {
                                    requestCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    requestSubCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    //offerSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    requestQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                    requestUnit = gen.sqlDataReader["Unit_Name"].ToString(),
                                    requestedByName = gen.sqlDataReader["User_Name"].ToString(),
                                    requestStatus = gen.sqlDataReader["Status"].ToString(),
                                    requestPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString()
                                });
                            }
                        }

                    }
                }
            }
            catch (SqlException ex)
            {
                requestReport.Add(new RequestsModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                requestReport.Add(new RequestsModel
                {
                    error = "Error"
                });
            }
            return requestReport;
        }

        public List<RequestsModel> RequestReportByCategory(string fromDate, string toDate, string categoryId, int startValue, int noOFRows, int cityId)
        {
            List<RequestsModel> requestReport = new List<RequestsModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "DECLARE @count INT;SELECT @count = COUNT(Category_Name) FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id = MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MR.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MR.Requested_By WHERE CM.Category_Id=@categoryId AND UR.City_Id = @cityId  AND Posted_Date BETWEEN @fromDate AND @toDate;SELECT Category_Name,Sub_Category_Name,Quantity,Unit_Name,User_Name,Posted_Date, MR.Status,@count AS [Count] FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id = MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MR.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MR.Requested_By WHERE CM.Category_Id=@categoryId AND UR.City_Id = @cityId AND Posted_Date BETWEEN @fromDate AND @toDate ORDER BY MR.My_Request_Id OFFSET @startValue ROWS FETCH NEXT @noOFRows ROWS ONLY ";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@fromDate", fromDate);
                        gen.sqlCommand.Parameters.AddWithValue("@toDate", toDate);
                        gen.sqlCommand.Parameters.AddWithValue("@categoryId", categoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@cityId", cityId);
                        gen.sqlCommand.Parameters.AddWithValue("@noOFRows", noOFRows);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                requestReport.Add(new RequestsModel
                                {
                                    requestCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    requestSubCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    //offerSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    requestQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                    requestUnit = gen.sqlDataReader["Unit_Name"].ToString(),
                                    requestedByName = gen.sqlDataReader["User_Name"].ToString(),
                                    requestStatus = gen.sqlDataReader["Status"].ToString(),
                                    requestPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString(),
                                });
                            }
                        }

                    }
                }
            }
            catch (SqlException ex)
            {
                requestReport.Add(new RequestsModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                requestReport.Add(new RequestsModel
                {
                    error = "Error"
                });
            }
            return requestReport;
        }

        public List<RequestsModel> RequestReportBySubCategory(string fromDate, string toDate, string subCategoryId, int startValue, int noOFRows, int cityId)
        {
            List<RequestsModel> requestReport = new List<RequestsModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "DECLARE @count INT;SELECT @count=COUNT(Category_Name) FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id = MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MR.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MR.Requested_By WHERE SCM.Sub_Category_Id=@subCategoryId  AND UR.City_Id=@cityId AND Posted_Date BETWEEN @fromDate AND @toDate;SELECT Category_Name,Sub_Category_Name,Quantity,Unit_Name,User_Name,Posted_Date,MR.Status,@count AS [Count] FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id = MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MR.Unit JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id = MR.Requested_By WHERE SCM.Sub_Category_Id=@subCategoryId AND UR.City_Id=@cityId AND Posted_Date BETWEEN @fromDate AND @toDate ORDER BY MR.My_Request_Id OFFSET @startValue ROWS FETCH NEXT @noOFRows ROWS ONLY ";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@fromDate", fromDate);
                        gen.sqlCommand.Parameters.AddWithValue("@toDate", toDate);
                        gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", subCategoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@cityid", cityId);
                        gen.sqlCommand.Parameters.AddWithValue("@noOFRows", noOFRows);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                requestReport.Add(new RequestsModel
                                {
                                    requestCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    requestSubCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    //offerSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    requestQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                    requestUnit = gen.sqlDataReader["Unit_Name"].ToString(),
                                    requestedByName = gen.sqlDataReader["User_Name"].ToString(),
                                    requestStatus = gen.sqlDataReader["Status"].ToString(),
                                    requestPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString()
                                });
                            }
                        }

                    }
                }
            }
            catch (SqlException ex)
            {
                requestReport.Add(new RequestsModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                requestReport.Add(new RequestsModel
                {
                    error = "Error"
                });
            }
            return requestReport;
        }

        

        
    }
}
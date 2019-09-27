using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Globalization;
using ReachHelpWF.Interfaces;

namespace ReachHelpWF.Models
{
    public class RequestsModel
    {
        public string requestId { get; set; }
        public string offerId { get; set; }
        public string requestCategoryId { get; set; }
        public string requestCategoryName { get; set; }
        public string requestSubCategoryId { get; set; }
        public string requestSubCategoryName { get; set; }
        public string requestedById { get; set; }
        public string requestedByName { get; set; }
        public string requestQuantity { get; set; }
        public string requestUnit { get; set; }
        public string requestExpectedDate { get; set; }
        public string requestDeliveryMode { get; set; }
        public string requestDeliveryAddress { get; set; }
        public string requestPostedDate { get; set; }
        public string requestStatus { get; set; }
        public string rating { get; set; }
        
        public string count { get; set; }

        public string error { get; set; }

        public int totalEntries { get; set; }

        public bool MakeRequest(RequestsModel myRequest)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "INSERT INTO [ReachHelp].[dbo].[My_Requests] ([Category_Id] ,[Sub_Category_Id] ,[Requested_By] ,[Quantity] ,[Unit] ,[Expected_Date] ,[Delivery_Address] ,[Status]) VALUES(@categoryId,@subCategoryId,@requestedBy,@quantity,@unit,@expectedDate,@deliveryAddress,@postedStatus)";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@categoryId", myRequest.requestCategoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", myRequest.requestSubCategoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@requestedBy", myRequest.requestedById);
                        gen.sqlCommand.Parameters.AddWithValue("@quantity", myRequest.requestQuantity);
                        gen.sqlCommand.Parameters.AddWithValue("@expectedDate", myRequest.requestExpectedDate);
                        gen.sqlCommand.Parameters.AddWithValue("@unit", myRequest.requestUnit);
                        gen.sqlCommand.Parameters.AddWithValue("@deliveryAddress", myRequest.requestDeliveryAddress);
                        gen.sqlCommand.Parameters.AddWithValue("@postedStatus", "Pending"); // Any new request is pending in the beginning

                        if (gen.sqlCommand.ExecuteNonQuery() > 0)
                        {
                            return true;
                        }
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

        public List<RequestsModel> MyRequests(string userId, int startValue, int noOfRows)
        {
            GenericInitialization gen = new GenericInitialization();
            List<RequestsModel> myRequests = new List<RequestsModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    //gen.queryString = "SELECT My_Request_Id,Category_Name,Sub_Category_Name,Quantity,Unit_Name Unit,Delivery_Address,Expected_Date,Posted_Date,MR.Status FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id LEFT JOIN  [ReachHelp].[dbo].[Unit_Master]UM ON UM.Unit_Id = MR.Unit WHERE Quantity!=0 AND MR.[Status]!='Cancelled' AND Requested_By=@userId";

                    gen.queryString = "SELECT My_Request_Id,Category_Name,Sub_Category_Name,Quantity,Unit_Name Unit,Delivery_Address,Expected_Date,Posted_Date,MR.Status,COUNT(My_Request_Id) OVER (PARTITION BY 1) AS Count,Rating AS Rating FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id LEFT JOIN  [ReachHelp].[dbo].[Unit_Master]UM ON UM.Unit_Id = MR.Unit LEFT JOIN [ReachHelp].[dbo].[Offer_Request_Mapping] ORM ON ORM.Request_Id = MR.My_Request_Id WHERE Quantity!=0 AND MR.[Status]!='Cancelled' AND Requested_By=@userId ORDER BY My_Request_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY";

                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@userId", userId);

                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@noOfRows", noOfRows);

                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    myRequests.Add(new RequestsModel
                                    {
                                        requestId = gen.sqlDataReader["My_Request_Id"].ToString(),
                                        requestCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                        requestSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                        requestQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                        requestUnit = gen.sqlDataReader["Unit"].ToString(),
                                        requestDeliveryAddress = gen.sqlDataReader["Delivery_Address"].ToString(),
                                        requestExpectedDate = gen.sqlDataReader["Expected_Date"].ToString().Split(' ')[0],
                                        requestPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                        requestStatus = gen.sqlDataReader["Status"].ToString(),
                                        count = gen.sqlDataReader["Count"].ToString(),
                                        rating = gen.sqlDataReader["Rating"].ToString()
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                myRequests.Add(new RequestsModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                myRequests.Add(new RequestsModel
                {
                    error = "Error"
                });
            }
            return myRequests;
        }

        //public List<RequestsModel> RequestForOffer(string offerId)
        //{
        //    List<RequestsModel> requestList = new List<RequestsModel>();
        //    GenericInitialization gen = new GenericInitialization();
        //    try
        //    {
        //        using (gen.sqlConnection = new SqlConnection(gen.connectionString))
        //        {
        //            gen.sqlConnection.Open();
        //            gen.queryString = "SELECT My_Request_Id,MR.Quantity AS Requested_Quantity,Unit_Name AS Requested_Unit,User_Name AS Requested_By,MR.Expected_Date,MR.Delivery_Address,MR.Posted_Date FROM [ReachHelp].[dbo].[My_Offers] MO JOIN [ReachHelp].[dbo].[My_Requests] MR ON MR.Category_Id=MO.Category_Id AND MO.Sub_Category_Id=MR.Sub_Category_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MR.Unit JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MR.Requested_By WHERE My_Offer_Id=@offerId";
        //            using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
        //            {
        //                gen.sqlCommand.Parameters.AddWithValue("@offerId", offerId);
        //                using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
        //                {
        //                    while (gen.sqlDataReader.Read())
        //                    {
        //                        requestList.Add(new RequestsModel
        //                        {
        //                            requestId = gen.sqlDataReader["My_Request_Id"].ToString(),
        //                            requestQuantity = gen.sqlDataReader["Requested_Quantity"].ToString(),
        //                            requestUnit = gen.sqlDataReader["Requested_Unit"].ToString(),
        //                            requestedByName = gen.sqlDataReader["Requested_By"].ToString(),
        //                            requestExpectedDate = gen.sqlDataReader["Expected_Date"].ToString(),
        //                            requestDeliveryAddress = gen.sqlDataReader["Delivery_Address"].ToString(),
        //                            requestPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
        //                            requestStatus = gen.sqlDataReader["Status"].ToString(),
        //                        });
        //                    }
        //                }
        //            }
        //        }
        //    }
        //    catch (SqlException ex)
        //    {

        //    }
        //    catch (Exception ex)
        //    {

        //    }
        //    return requestList;
        //}

        public List<RequestsModel> ListRequests(string offerId, int startValue, int noOfRows)
        {
            GenericInitialization gen = new GenericInitialization();
            List<RequestsModel> requestList = new List<RequestsModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    //gen.queryString = "SELECT My_Request_Id,MR.Quantity,Unit_Name AS Unit,User_Name AS Requested_By,ORM.[Status],MR.Expected_Date,MR.Delivery_Address FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM JOIN [ReachHelp].[dbo].[My_Requests] MR ON MR.My_Request_Id=ORM.Request_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=MR.Unit JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MR.Requested_By WHERE Offer_Id=@offerId AND (ORM.[Status]!='Accepted' OR ORM.[Status]!='Cancelled')";

                    gen.queryString = "SELECT My_Request_Id,MR.Quantity,Unit_Name AS Unit,User_Name AS Requested_By, User_Id AS Requested_By_Id,ORM.[Status],MR.Expected_Date,MR.Delivery_Address,COUNT(My_Request_Id) OVER (PARTITION BY 1) AS Count FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM JOIN [ReachHelp].[dbo].[My_Requests] MR ON MR.My_Request_Id=ORM.Request_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=MR.Unit JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MR.Requested_By WHERE Offer_Id=@offerId AND (ORM.[Status]!='Accepted' OR ORM.[Status]!='Cancelled')  ORDER BY My_Request_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY";

                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@offerId", offerId);

                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@noOfRows", noOfRows);


                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                requestList.Add(new RequestsModel
                                {
                                    requestId = gen.sqlDataReader["My_Request_Id"].ToString(),
                                    requestQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                    requestUnit = gen.sqlDataReader["Unit"].ToString(),
                                    requestedByName = gen.sqlDataReader["Requested_By"].ToString(),
                                    requestedById = gen.sqlDataReader["Requested_By_Id"].ToString(),
                                    requestStatus = gen.sqlDataReader["Status"].ToString(),
                                    requestExpectedDate = gen.sqlDataReader["Expected_Date"].ToString(),
                                    requestDeliveryAddress = gen.sqlDataReader["Delivery_Address"].ToString(),

                                    count = gen.sqlDataReader["Count"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                requestList.Add(new RequestsModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                requestList.Add(new RequestsModel
                {
                    error = "Error"
                });
            }

            return requestList;
        }

        public bool RespondToRequest(RequestsModel requestResponse)
        {
            GenericInitialization gen = new GenericInitialization();
            MessagingModel email = new MessagingModel();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "IF NOT EXISTS(SELECT Mapping_Id FROM [ReachHelp].[dbo].[Offer_Request_Mapping] WHERE Request_Id=@requestId AND Offer_Id=@offerId) INSERT INTO [ReachHelp].[dbo].[Offer_Request_Mapping](Offer_Id,Request_Id,[Responded_Quantity],[Responded_Unit],[Status],[Responded_Date]) VALUES(@offerId,@requestId,@respondedQuantity,@respondedUnit,@status,GETDATE()); ELSE	UPDATE [ReachHelp].[dbo].[Offer_Request_Mapping] SET [Responded_Date]=GETDATE(),[Responded_Quantity]=@respondedQuantity,[Responded_Unit]=@respondedUnit,[Status]=CASE WHEN @status='Reject' THEN 'Rejected' WHEN @status='Respond' THEN 'Respond' ELSE [Status] END WHERE Request_Id=@requestId AND Offer_Id=@offerId; UPDATE [ReachHelp].[dbo].[My_Requests] SET [Status] = CASE WHEN @status = 'Reject' THEN 'Pending' ELSE 'Respond' END  WHERE My_Request_Id=@requestId";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@requestId", requestResponse.requestId);
                        gen.sqlCommand.Parameters.AddWithValue("@offerId", requestResponse.offerId);
                        gen.sqlCommand.Parameters.AddWithValue("@respondedQuantity", requestResponse.requestQuantity);
                        gen.sqlCommand.Parameters.AddWithValue("@respondedUnit", requestResponse.requestUnit);
                        gen.sqlCommand.Parameters.AddWithValue("@status", requestResponse.requestStatus);
                        if (gen.sqlCommand.ExecuteNonQuery() > 0)
                        {
                            email.TriggerEmail(GetRequestorDetails(requestResponse.requestId), "Response for your request", "<!DOCTYPE html><html> <head> <meta charset=\"utf-8\"> </head> <body> <p> Dear User, </p><br><p> A response has been made for your request. Kindly Login to <a href=\"http://reachelp.in\">ReachHelp<a> to respond. </p></body></html>");
                            return true;
                        }
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

        public bool CancelRequest(string requestId)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "UPDATE [ReachHelp].[dbo].[My_Requests] SET [Status]='Cancelled' WHERE My_Request_Id=@requestId";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@requestId", requestId);
                        if (gen.sqlCommand.ExecuteNonQuery() > 0)
                        {
                            return true;
                        }
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

        public string GeneralRequest(RequestsModel myRequest)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "INSERT INTO [ReachHelp].[dbo].[My_Requests] ([Category_Id] ,[Sub_Category_Id] ,[Requested_By] ,[Quantity] ,[Unit] ,[Expected_Date] ,[Delivery_Address] ,[Status]) VALUES(@categoryId,@subCategoryId,@requestedBy,@quantity,@unit,@expectedDate,@deliveryAddress,@postedStatus);SELECT IDENT_CURRENT('[ReachHelp].[dbo].[My_Requests]') AS Request_Id";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@categoryId", myRequest.requestCategoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", myRequest.requestSubCategoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@requestedBy", myRequest.requestedById);
                        gen.sqlCommand.Parameters.AddWithValue("@quantity", myRequest.requestQuantity);
                        gen.sqlCommand.Parameters.AddWithValue("@expectedDate", myRequest.requestExpectedDate);
                        gen.sqlCommand.Parameters.AddWithValue("@unit", myRequest.requestUnit);
                        gen.sqlCommand.Parameters.AddWithValue("@deliveryAddress", myRequest.requestDeliveryAddress);
                        gen.sqlCommand.Parameters.AddWithValue("@postedStatus", "Pending"); // Any new request is pending in the beginning

                         using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                               return gen.sqlDataReader["Request_Id"].ToString();
                            }
                        }                    
                    }
                }
            }
            catch (SqlException ex)
            {
                return "-1";
            }
            catch (Exception ex)
            {
                return "-1";
            }
            return "-1";            
        }

        public IUsers GetRequestorDetails(string requestId)
        {
            UserModel user = new UserModel();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT TOP 1 UR.User_Name,UR.Email_Id FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[User_Register]UR on UR.User_Id=MR.Requested_By WHERE MR.My_Request_Id = @requestId";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@requestId", requestId);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    user.userName = gen.sqlDataReader["User_Name"].ToString();
                                    user.emailId = gen.sqlDataReader["Email_Id"].ToString();
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return user; //Error
            }
            catch (Exception ex)
            {
                return user;      //Error            
            }
            return user;
        }
    }

    //public class AvailableOffers
    //{
    //    public string offerId { get; set; }
    //    public string requestId { get; set; }
    //    public string categoryId { get; set; }
    //    public string categoryName { get; set; }
    //    public string subCategoryId { get; set; }
    //    public string subCategoryName { get; set; }
    //    public string requestedQuantity { get; set; }
    //    public string expectedDate { get; set; }
    //    public string unit { get; set; }
    //    public string offeredQuantity { get; set; }
    //    public string offeredBy { get; set; }
    //    public string deliveryMode { get; set; }

    //    public List<AvailableOffers> AvailableOffersList(string requestId)
    //    {
    //        List<AvailableOffers> offersList = new List<AvailableOffers>();
    //        GenericInitialization gen = new GenericInitialization();
    //        try
    //        {
    //            using (gen.sqlConnection = new SqlConnection(gen.connectionString))
    //            {
    //                gen.sqlConnection.Open();
    //                gen.queryString = "SELECT MO.My_Offer_Id,UR.User_Name Offered_By,MO.Quantity AS Offered_Quantity,Unit_Name AS Offered_Unit,Delivery_Mode,MO.Delivery_Address FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[My_Offers]MO ON MO.Category_Id=MR.Category_Id AND MO.Sub_Category_Id = MR.Sub_Category_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id JOIN [ReachHelp].[dbo].[Unit_Master] UM ON MO.Unit = UM.Unit_Id JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MO.Offered_By WHERE MO.Quantity!=0 AND MR.My_Request_Id=@requestId AND MR.[Status] = 'Pending' AND MO.[Status] = 'Pending'";
    //                using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
    //                {
    //                    gen.sqlCommand.Parameters.AddWithValue("@requestId", requestId);
    //                    using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
    //                    {
    //                        while (gen.sqlDataReader.Read())
    //                        {
    //                            offersList.Add(new AvailableOffers
    //                            {
    //                                offerId = gen.sqlDataReader["My_Offer_Id"].ToString(),
    //                                requestId = gen.sqlDataReader["My_Request_Id"].ToString(),
    //                                //categoryId = gen.sqlDataReader["Category_Id"].ToString(),
    //                                categoryName = gen.sqlDataReader["Category_Name"].ToString(),
    //                                //subCategoryId = gen.sqlDataReader["My_Offer_Id"].ToString(),
    //                                subCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
    //                                requestedQuantity = gen.sqlDataReader["Requested_Quantity"].ToString(),
    //                                expectedDate = gen.sqlDataReader["Expected_Date"].ToString(),
    //                                unit = gen.sqlDataReader["Unit_Name"].ToString(),
    //                                offeredQuantity = gen.sqlDataReader["Offered_Quantity"].ToString(),
    //                                offeredBy = gen.sqlDataReader["Offered_By"].ToString(),
    //                                deliveryMode = gen.sqlDataReader["Delivery_Mode"].ToString()
    //                            });
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //        catch (SqlException ex)
    //        {

    //        }
    //        catch (Exception ex)
    //        {

    //        }
    //        return offersList;
    //    }
    //}


    
}
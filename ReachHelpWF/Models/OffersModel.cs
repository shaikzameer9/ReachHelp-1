using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using ReachHelpWF.Interfaces;

namespace ReachHelpWF.Models
{
    public class OffersModel : IOffers, IUsers
    {
        public string offerId { get; set; }
        public string requestId { get; set; }
        public string offerCategoryId { get; set; }
        public string offerCategoryName { get; set; }
        public string offerSubCategoryId { get; set; }
        public string offerSubCategoryName { get; set; }
        public string offeredById { get; set; }
        public string offeredByName { get; set; }
        public string offerQuantity { get; set; }
        public string offerUnit { get; set; }
        public string offerDeliveryMode { get; set; }
        public string offerDeliveryAddress { get; set; }
        public string offerPostedDate { get; set; }
        public string offerStatus { get; set; }
        public string error { get; set; }
        public string phoneNumber { get; set; }
        public string emailId { get; set; }
        public string credits { get; set; }
        public List<string> imagePath { get; set; }
        public string description { get; set; }
        public string userName { get; set; }
        public string unitId { get; set; }
        public string categoryId { get; set; }
        public string subCategoryId { get; set; }
        public UInt16 number { get; set; }
        public UInt16 userCount { get; set; }
        public string count { get; set; }

        public bool CreateOffer(OffersModel myOffer)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "INSERT INTO [ReachHelp].[dbo].[My_Offers]([Category_Id],[Sub_Category_Id],[Offered_By],[Quantity],[Unit],[Delivery_Mode],[Delivery_Address],[Description],[Image_Path],[Status]) VALUES(@categoryId,@subCategoryId,@offeredBy,@quantity,@unit,@deliveryMode,@deliveryAddress,@description,@imagePath,@postedStatus)";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        //@subCategoryId,@offeredBy,@quantity,@unit,@deliveryMode,@deliveryAddress,@postedStatus
                        gen.sqlCommand.Parameters.AddWithValue("@categoryId", myOffer.offerCategoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", myOffer.offerSubCategoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@offeredBy", myOffer.offeredById);
                        gen.sqlCommand.Parameters.AddWithValue("@quantity", myOffer.offerQuantity);
                        gen.sqlCommand.Parameters.AddWithValue("@unit", myOffer.offerUnit);
                        gen.sqlCommand.Parameters.AddWithValue("@deliveryMode", myOffer.offerDeliveryMode);
                        gen.sqlCommand.Parameters.AddWithValue("@deliveryAddress", myOffer.offerDeliveryAddress);
                        gen.sqlCommand.Parameters.AddWithValue("@imagePath", string.Join(",", myOffer.imagePath.ToArray()));
                        ;
                        gen.sqlCommand.Parameters.AddWithValue("@description", myOffer.description);
                        gen.sqlCommand.Parameters.AddWithValue("@postedStatus", "Pending"); // Any new offer is pending in the beginning

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

        public List<OffersModel> MyOffers(string userId, int startValue, int noOfRows)
        {
            GenericInitialization gen = new GenericInitialization();
            List<OffersModel> myOffers = new List<OffersModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    //gen.queryString = "SELECT My_Offer_Id,Category_Name,MO.Sub_Category_Id,Sub_Category_Name,Quantity, UM.Unit_Name,Delivery_Mode,Delivery_Address,Posted_Date,MO.[Status] FROM [ReachHelp].[dbo].[My_Offers] MO JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=MO.Unit WHERE Quantity!=0 AND MO.[Status]!='Cancelled' AND Offered_By = @userId";

                    gen.queryString = "SELECT My_Offer_Id,Category_Name,MO.Sub_Category_Id,Sub_Category_Name,Quantity, UM.Unit_Name,Delivery_Mode,Delivery_Address,Posted_Date,MO.[Status],COUNT(*) OVER (PARTITION BY 1) AS Count FROM [ReachHelp].[dbo].[My_Offers] MO JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=MO.Unit WHERE Quantity!=0 AND MO.[Status]!='Cancelled' AND Offered_By = @userId ORDER BY My_Offer_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY";

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
                                    myOffers.Add(new OffersModel
                                    {
                                        offerId = gen.sqlDataReader["My_Offer_Id"].ToString(),
                                        offerCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                        offerSubCategoryId = gen.sqlDataReader["Sub_Category_Id"].ToString(),
                                        offerSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                        offerQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                        offerUnit = gen.sqlDataReader["Unit_Name"].ToString(),
                                        offerDeliveryMode = gen.sqlDataReader["Delivery_Mode"].ToString(),
                                        offerDeliveryAddress = gen.sqlDataReader["Delivery_Address"].ToString(),
                                        offerPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                        offerStatus = gen.sqlDataReader["Status"].ToString(),
                                        count = gen.sqlDataReader["Count"].ToString(),
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                myOffers.Add(new OffersModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                myOffers.Add(new OffersModel
                {
                    error = "Error"
                });
            }
            return myOffers;
        }

        public List<OffersModel> ListOffers(string categoryId, string subCategoryId)
        {
            GenericInitialization gen = new GenericInitialization();
            List<OffersModel> myOffers = new List<OffersModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT My_Offer_Id,Category_Name,Sub_Category_Name,Quantity,Unit,Delivery_Mode,Delivery_Address,Posted_Date,MO.[Status]  FROM [ReachHelp].[dbo].[My_Offers] MO JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MO.Category_Id  JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id  WHERE Quantity!=0 AND MO.[Status]!='Cancelled' AND MO.Category_Id=@categoryId AND MO.Sub_Category_Id=@subCategoryId";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@categoryId", categoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", subCategoryId);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    myOffers.Add(new OffersModel
                                    {
                                        offerId = gen.sqlDataReader["My_Offer_Id"].ToString(),
                                        offerCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                        offerSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                        offerQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                        offerUnit = gen.sqlDataReader["Unit"].ToString(),
                                        offerDeliveryMode = gen.sqlDataReader["Delivery_Mode"].ToString(),
                                        offerDeliveryAddress = gen.sqlDataReader["Delivery_Address"].ToString(),
                                        offerPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                        imagePath = gen.sqlDataReader["Image_Path"].ToString().Split(',').ToList(),
                                        description = gen.sqlDataReader["Description"].ToString(),
                                        offerStatus = gen.sqlDataReader["Status"].ToString(),
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                myOffers.Add(new OffersModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                myOffers.Add(new OffersModel
                {
                    error = "Error"
                });
            }
            return myOffers;
        }

        public List<OffersModel> AvailableOffersList(string requestId, int startValue, int noOfRows)
        {
            List<OffersModel> offersList = new List<OffersModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    //gen.queryString = "DECLARE @userId BIGINT;SELECT @userId = Requested_By FROM [ReachHelp].[dbo].[My_Requests] WHERE My_Request_Id=@requestId;IF EXISTS(SELECT Mapping_Id FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM WHERE Request_Id=@requestId AND ORM.[Status]!='Cancelled' INTERSECT SELECT Mapping_Id FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM WHERE Request_Id=@requestId AND ORM.[Status]!='Accepted') SELECT MO.My_Offer_Id,UR.User_Name Offered_By,ORM.Responded_Quantity  AS Offered_Quantity,Unit_Name AS Offered_Unit,Delivery_Mode,MO.Delivery_Address, ORM.[Status],UR.Phone_Number,UR.Email_Id FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Offer_Request_Mapping] ORM ON ORM.Request_Id=MR.My_Request_Id JOIN [ReachHelp].[dbo].[My_Offers]MO ON MO.My_Offer_Id=ORM.Offer_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON ORM.Responded_Unit = UM.Unit_Id JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MO.Offered_By WHERE MO.Quantity!=0 AND ORM.Request_Id=@requestId AND MO.Offered_By!=@userId; ELSE SELECT MO.My_Offer_Id,UR.User_Name Offered_By,MO.Quantity AS Offered_Quantity,Unit_Name AS Offered_Unit,Delivery_Mode,MO.Delivery_Address, MO.Status,UR.Phone_Number,UR.Email_Id FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[My_Offers]MO ON MO.Category_Id=MR.Category_Id AND MO.Sub_Category_Id = MR.Sub_Category_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON MO.Unit = UM.Unit_Id JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MO.Offered_By WHERE MO.Quantity!=0 AND MR.My_Request_Id=@requestId AND MR.[Status] = 'Pending' AND MO.[Status] = 'Pending' AND MO.Offered_By!=@userId;";

                    //gen.queryString = "DECLARE @userId BIGINT;DECLARE @tempTable TABLE(My_Offer_Id BIGINT,Offered_By NVARCHAR(MAX),Offered_By_Id BIGINT,Offered_Quantity INT,Offered_Unit VARCHAR(50),Delivery_Mode VARCHAR(50),Delivery_Address NVARCHAR(MAX),Status VARCHAR(10),Phone_Number VARCHAR(20),Email_Id VARCHAR(100));DECLARE @creditsTable TABLE(Credits INT,Offered_By BIGINT);SELECT @userId = Requested_By FROM [ReachHelp].[dbo].[My_Requests] WHERE My_Request_Id=@requestId;IF EXISTS(SELECT Mapping_Id FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM WHERE Request_Id=@requestId AND ORM.[Status]!='Cancelled' INTERSECT SELECT Mapping_Id FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM WHERE Request_Id=@requestId AND ORM.[Status]!='Accepted') INSERT INTO @tempTable SELECT MO.My_Offer_Id,UR.User_Name Offered_By,Offered_By AS Offered_By_Id,ORM.Responded_Quantity  AS Offered_Quantity,Unit_Name AS Offered_Unit,Delivery_Mode,MO.Delivery_Address, ORM.[Status],UR.Phone_Number,UR.Email_Id FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Offer_Request_Mapping] ORM ON ORM.Request_Id=MR.My_Request_Id JOIN [ReachHelp].[dbo].[My_Offers]MO ON MO.My_Offer_Id=ORM.Offer_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON ORM.Responded_Unit = UM.Unit_Id JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MO.Offered_By WHERE MO.Quantity!=0 AND ORM.Request_Id=@requestId AND MO.Offered_By!=@userId; ELSE 	INSERT INTO @tempTable SELECT MO.My_Offer_Id,UR.User_Name Offered_By,Offered_By AS Offered_By_Id,MO.Quantity AS Offered_Quantity,Unit_Name AS Offered_Unit,Delivery_Mode,MO.Delivery_Address, MO.Status,UR.Phone_Number,UR.Email_Id FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[My_Offers]MO ON MO.Category_Id=MR.Category_Id AND MO.Sub_Category_Id = MR.Sub_Category_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON MO.Unit = UM.Unit_Id JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MO.Offered_By WHERE MO.Quantity!=0 AND MR.My_Request_Id=@requestId AND MR.[Status] = 'Pending' AND MO.[Status] = 'Pending' AND MO.Offered_By!=@userId; INSERT INTO @creditsTable SELECT COUNT(Offered_By)AS Credits,Offered_By  FROM [ReachHelp].[dbo].[User_Register]UR JOIN [ReachHelp].[dbo].[My_Offers]MO ON MO.Offered_By = UR.User_Id JOIN [ReachHelp].[dbo].[Offer_Request_Mapping] ORM ON ORM.Offer_Id = MO.My_Offer_Id WHERE /*User_Id=2 AND*/ ORM.[Status]='Accepted' GROUP BY Offered_By;SELECT TT.*,CT.Credits FROM @tempTable TT  JOIN @creditsTable CT ON TT.Offered_By_Id = CT.Offered_By";

                    gen.queryString = "DECLARE @userId BIGINT;DECLARE @tempTable TABLE(My_Offer_Id BIGINT,Offered_By NVARCHAR(MAX),Offered_By_Id BIGINT,Offered_Quantity INT,Offered_Unit VARCHAR(50),Delivery_Mode VARCHAR(50),Delivery_Address NVARCHAR(MAX),Status VARCHAR(10),Phone_Number VARCHAR(20),Email_Id VARCHAR(100));DECLARE @creditsTable TABLE(Credits INT,Offered_By BIGINT);SELECT @userId = Requested_By FROM [ReachHelp].[dbo].[My_Requests] WHERE My_Request_Id=@requestId;IF EXISTS(SELECT Mapping_Id FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM WHERE Request_Id=@requestId AND ORM.[Status]!='Cancelled' INTERSECT SELECT Mapping_Id FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM WHERE Request_Id=@requestId AND ORM.[Status]!='Accepted') INSERT INTO @tempTable SELECT MO.My_Offer_Id,UR.User_Name Offered_By,Offered_By AS Offered_By_Id,ORM.Responded_Quantity  AS Offered_Quantity,Unit_Name AS Offered_Unit,Delivery_Mode,MO.Delivery_Address, ORM.[Status],UR.Phone_Number,UR.Email_Id FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[Offer_Request_Mapping] ORM ON ORM.Request_Id=MR.My_Request_Id JOIN [ReachHelp].[dbo].[My_Offers]MO ON MO.My_Offer_Id=ORM.Offer_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON ORM.Responded_Unit = UM.Unit_Id JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MO.Offered_By WHERE MO.Quantity!=0 AND ORM.Request_Id=@requestId AND MO.Offered_By!=@userId; ELSE 	INSERT INTO @tempTable SELECT MO.My_Offer_Id,UR.User_Name Offered_By,Offered_By AS Offered_By_Id,MO.Quantity AS Offered_Quantity,Unit_Name AS Offered_Unit,Delivery_Mode,MO.Delivery_Address, MO.Status,UR.Phone_Number,UR.Email_Id FROM [ReachHelp].[dbo].[My_Requests] MR JOIN [ReachHelp].[dbo].[My_Offers]MO ON MO.Category_Id=MR.Category_Id AND MO.Sub_Category_Id = MR.Sub_Category_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id LEFT JOIN [ReachHelp].[dbo].[Unit_Master] UM ON MO.Unit = UM.Unit_Id JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MO.Offered_By WHERE MO.Quantity!=0 AND MR.My_Request_Id=@requestId AND MR.[Status] = 'Pending' AND MO.[Status] = 'Pending' AND MO.Offered_By!=@userId; INSERT INTO @creditsTable SELECT COUNT(Offered_By)AS Credits,Offered_By  FROM [ReachHelp].[dbo].[User_Register]UR JOIN [ReachHelp].[dbo].[My_Offers]MO ON MO.Offered_By = UR.User_Id JOIN [ReachHelp].[dbo].[Offer_Request_Mapping] ORM ON ORM.Offer_Id = MO.My_Offer_Id WHERE /*User_Id=2 AND*/ ORM.[Status]='Accepted' GROUP BY Offered_By;SELECT TT.*,CT.Credits,COUNT(*) OVER (PARTITION BY 1) AS Count FROM @tempTable TT  LEFT JOIN @creditsTable CT ON TT.Offered_By_Id = CT.Offered_By ORDER BY My_Offer_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY";

                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@requestId", requestId);

                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@noOfRows", noOfRows);

                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                offersList.Add(new OffersModel
                                {
                                    offerId = gen.sqlDataReader["My_Offer_Id"].ToString(),
                                    //categoryId = gen.sqlDataReader["Category_Id"].ToString(),
                                    //categoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    //subCategoryId = gen.sqlDataReader["My_Offer_Id"].ToString(),
                                    //subCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    offerUnit = gen.sqlDataReader["Offered_Unit"].ToString(),
                                    offerQuantity = gen.sqlDataReader["Offered_Quantity"].ToString(),
                                    offeredByName = gen.sqlDataReader["Offered_By"].ToString(),
                                    offeredById = gen.sqlDataReader["Offered_By_Id"].ToString(),
                                    offerDeliveryMode = gen.sqlDataReader["Delivery_Mode"].ToString(),
                                    // offerDeliveryAddress = gen.sqlDataReader["Delivery_Address"].ToString(),
                                    offerStatus = gen.sqlDataReader["Status"].ToString(),
                                    phoneNumber = gen.sqlDataReader["Phone_Number"].ToString(),
                                    emailId = gen.sqlDataReader["Email_Id"].ToString(),
                                    credits = gen.sqlDataReader["Credits"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {

            }
            catch (Exception ex)
            {

            }
            return offersList;
        }

        public bool RequestOffer(OffersModel offerResponse)
        {
            GenericInitialization gen = new GenericInitialization();
            MessagingModel email = new MessagingModel();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "IF NOT EXISTS(SELECT Mapping_Id FROM [ReachHelp].[dbo].[Offer_Request_Mapping] WHERE [Request_Id]=@requestId AND [Offer_Id] = @offerId) BEGIN INSERT INTO [ReachHelp].[dbo].[Offer_Request_Mapping]([Request_Id],[Offer_Id],[Status],[Requested_Date]) VALUES(@requestId,@offerId,@status,GETDATE());UPDATE [ReachHelp].[dbo].[My_Requests] SET [Status]=@status WHERE My_Request_Id = @requestId END";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@offerId", offerResponse.offerId);
                        gen.sqlCommand.Parameters.AddWithValue("@requestId", offerResponse.requestId);
                        gen.sqlCommand.Parameters.AddWithValue("@status", "Requested");
                        if (gen.sqlCommand.ExecuteNonQuery() > 0)
                        {
                            email.TriggerEmail(GetOffererDetails(offerResponse.offerId), "Request for HELP", "<!DOCTYPE html><html> <head> <meta charset=\"utf-8\"> </head> <body> <p> Dear User, </p><br><p> A request has been made for your Offer. Kindly Login to <a href=\"http://reachelp.in\">ReachHelp<a> to respond. </p></body></html>");
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

        public bool CancelOfferRequest(OffersModel offerList)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "IF NOT EXISTS(SELECT Mapping_Id FROM [ReachHelp].[dbo].[Offer_Request_Mapping] WHERE [Request_Id]=@requestId AND [Offer_Id] = @offerId) INSERT INTO [ReachHelp].[dbo].[Offer_Request_Mapping]([Request_Id],[Offer_Id],[Status]) VALUES(@requestId,@offerId,@transactionStatus);ELSE	UPDATE [ReachHelp].[dbo].[Offer_Request_Mapping] SET [Status]=@status WHERE Request_Id=@requestId AND Offer_Id=@offerId;UPDATE [ReachHelp].[dbo].[My_Requests] SET [Status]=@requestStatus WHERE My_Request_Id = @requestId";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@offerId", offerList.offerId);
                        gen.sqlCommand.Parameters.AddWithValue("@requestId", offerList.requestId);
                        gen.sqlCommand.Parameters.AddWithValue("@transactionStatus", "Cancelled");
                        gen.sqlCommand.Parameters.AddWithValue("@requestStatus", "Pending");
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

        public bool ConfirmOffer(OffersModel offerResponse)
        {
            GenericInitialization gen = new GenericInitialization();
            MessagingModel email = new MessagingModel();

            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "IF NOT EXISTS(SELECT Mapping_Id FROM [ReachHelp].[dbo].[Offer_Request_Mapping] WHERE [Request_Id]=@requestId AND [Offer_Id] = @offerId) BEGIN INSERT INTO [ReachHelp].[dbo].[Offer_Request_Mapping]([Request_Id],[Offer_Id],[Status],[Confirmed_Date]) VALUES(@requestId,@offerId,@status,GETDATE());END ELSE BEGIN UPDATE [ReachHelp].[dbo].[My_Requests] SET [Status]= CASE WHEN @status='Reject' THEN 'Pending' ELSE 'Accepted' END WHERE My_Request_Id = @requestId ; UPDATE [ReachHelp].[dbo].[Offer_Request_Mapping] SET [Confirmed_Date]=GETDATE(),[Status]=CASE WHEN @status='Reject' THEN 'Pending' ELSE 'Accepted' END WHERE [Request_Id]=@requestId AND [Offer_Id] = @offerId; DECLARE @finalQuantity INT;SELECT @finalQuantity = CASE WHEN SCM.Measurable = 'Yes' AND @status='Confirm' THEN ORM.[Responded_Quantity] WHEN SCM.Measurable = 'Yes' AND @status='Reject' THEN 0 WHEN SCM.Measurable = 'No' AND @status='Confirm' THEN 0 WHEN SCM.Measurable = 'No' AND @status='Reject' THEN 0 ELSE 0 END FROM [ReachHelp].[dbo].[My_Offers] MO JOIN [ReachHelp].[dbo].[Offer_Request_Mapping] ORM ON ORM.Offer_Id = MO.My_Offer_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master]SCM ON SCM.Sub_Category_Id = MO.Sub_Category_Id WHERE My_Offer_Id=@offerId AND Request_Id=@requestId; UPDATE [ReachHelp].[dbo].[My_Offers] SET Quantity = Quantity - CASE WHEN (@finalQuantity IS NOT NULL OR @finalQuantity!=0) THEN @finalQuantity ELSE 0 END WHERE My_Offer_Id=@offerId;UPDATE [ReachHelp].[dbo].[My_Offers] SET [Status] = CASE WHEN Quantity<=0 THEN 'Accepted' ELSE [Status] END WHERE My_Offer_Id=@offerId; END";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@offerId", offerResponse.offerId);
                        gen.sqlCommand.Parameters.AddWithValue("@requestId", offerResponse.requestId);
                        gen.sqlCommand.Parameters.AddWithValue("@status", offerResponse.offerStatus);
                        if (gen.sqlCommand.ExecuteNonQuery() > 0)
                        {
                            email.TriggerEmail(GetOffererDetails(offerResponse.offerId), "Offer Confirmed", "<!DOCTYPE html><html> <head> <meta charset=\"utf-8\"> </head> <body> <p> Dear User, </p><br><p>Well Done! Your Offer has been confirmed by the requestor. Login to <a href=\"http://reachelp.in\">ReachHelp<a> for more info. </p></body></html>");
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

        public bool CancelOffer(string offerId)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "UPDATE [ReachHelp].[dbo].[My_Offers] SET [Status]='Cancelled' WHERE My_Offer_Id=@offerId";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@offerId", offerId);
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

        public List<IOffers> ActiveOffers(int categoryId, int startValue, int noOfRows, string searchVal, float userLat, float userLng)
        {
            List<IOffers> offersList = new List<IOffers>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();

                    string searchByGeoQuery = "";
                    if (userLat == 0.0 || userLng == 0.0) searchByGeoQuery = "";                    
                    else searchByGeoQuery = " AND geography::Point(@userLat, @userLong, 4326).STBuffer(@radius).STIntersects(UR.[Geography]) = 1 ";

                    gen.queryString = "DECLARE @totalCount INT;SELECT @totalCount= Count(My_Offer_Id) FROM [ReachHelp].[dbo].[My_Offers] MO WHERE MO.Category_Id = CASE WHEN @categoryId = 0 THEN MO.Category_Id ELSE @categoryId END AND MO.[Status]='Pending'; SELECT My_Offer_Id,Category_Name,Sub_Category_Name,Quantity,Unit_Name,UR.City_Name, STA.State_Name, CNT.Country_Name ,Posted_Date,[Description],[Image_Path],@totalCount AS Total_Count,Unit_Id,MO.Sub_Category_Id,MO.Category_Id FROM [ReachHelp].[dbo].[My_Offers] MO JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MO.Sub_Category_Id JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MO.Unit JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MO.Offered_By JOIN [ReachHelp].[dbo].[Country_Master] CNT ON CNT.Country_Id = UR.Country_Id JOIN [ReachHelp].[dbo].[State_Master] STA ON STA.State_Id = UR.State_Id WHERE MO.Category_Id = CASE WHEN @categoryId = 0 THEN MO.Category_Id ELSE @categoryId END AND MO.[Status]='Pending' AND (UR.City_Name LIKE CASE WHEN @searchVal = '' THEN UR.City_Name ELSE '%'+@searchVal+'%' END OR STA.State_Name LIKE CASE WHEN @searchVal = '' THEN STA.State_Name ELSE '%'+@searchVal+'%' END		OR CNT.Country_Name LIKE CASE WHEN @searchVal = '' THEN CNT.Country_Name ELSE '%'+@searchVal+'%' END OR CM.Category_Name LIKE CASE WHEN @searchVal = '' THEN CM.Category_Name ELSE '%'+@searchVal+'%' END OR SCM.Sub_Category_Name LIKE CASE WHEN @searchVal = '' THEN SCM.Sub_Category_Name ELSE '%'+@searchVal+'%' END) "+searchByGeoQuery+" ORDER BY My_Offer_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY";

                    //DECLARE @totalCount INT;SELECT @totalCount= Count(My_Offer_Id) FROM [ReachHelp].[dbo].[My_Offers] MO WHERE MO.Category_Id = CASE WHEN @categoryId = 0 THEN MO.Category_Id ELSE @categoryId END AND MO.[Status]='Pending'; SELECT My_Offer_Id,Category_Name,Sub_Category_Name,Quantity,Unit_Name,UR.City_Name, STA.State_Name, CNT.Country_Name ,Posted_Date,[Description],[Image_Path],@totalCount AS Total_Count,Unit_Id,MO.Sub_Category_Id,MO.Category_Id FROM [ReachHelp].[dbo].[My_Offers] MO JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MO.Sub_Category_Id JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MO.Unit JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MO.Offered_By JOIN [ReachHelp].[dbo].[Country_Master] CNT ON CNT.Country_Id = UR.Country_Id JOIN [ReachHelp].[dbo].[State_Master] STA ON STA.State_Id = UR.State_Id WHERE MO.Category_Id = CASE WHEN @categoryId = 0 THEN MO.Category_Id ELSE @categoryId END AND MO.[Status]='Pending' AND (UR.City_Name LIKE CASE WHEN @searchVal = '' THEN UR.City_Name ELSE '%'+@searchVal+'%' END OR STA.State_Name LIKE CASE WHEN @searchVal = '' THEN STA.State_Name ELSE '%'+@searchVal+'%' END		OR CNT.Country_Name LIKE CASE WHEN @searchVal = '' THEN CNT.Country_Name ELSE '%'+@searchVal+'%' END OR CM.Category_Name LIKE CASE WHEN @searchVal = '' THEN CM.Category_Name ELSE '%'+@searchVal+'%' END OR SCM.Sub_Category_Name LIKE CASE WHEN @searchVal = '' THEN SCM.Sub_Category_Name ELSE '%'+@searchVal+'%' END) ORDER BY My_Offer_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY


                    //DECLARE @totalCount INT;SELECT @totalCount= Count(My_Offer_Id) FROM [ReachHelp].[dbo].[My_Offers] MO WHERE MO.Category_Id = CASE WHEN @categoryId = 0 THEN MO.Category_Id ELSE @categoryId END AND MO.[Status]='Pending'; SELECT My_Offer_Id,Category_Name,Sub_Category_Name,Quantity,Unit_Name,CTY.City_Name, STA.State_Name, CNT.Country_Name ,Posted_Date,[Description],[Image_Path],@totalCount AS Total_Count,Unit_Id,MO.Sub_Category_Id,MO.Category_Id FROM [ReachHelp].[dbo].[My_Offers] MO JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MO.Sub_Category_Id JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MO.Unit JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MO.Offered_By JOIN [ReachHelp].[dbo].[Country_Master] CNT ON CNT.Country_Id = UR.Country_Id JOIN [ReachHelp].[dbo].[State_Master] STA ON STA.State_Id = UR.State_Id JOIN [ReachHelp].[dbo].[City_Master] CTY ON CTY.City_Id = UR.City_Id WHERE MO.Category_Id = CASE WHEN @categoryId = 0 THEN MO.Category_Id ELSE @categoryId END AND MO.[Status]='Pending' AND (CTY.City_Name LIKE CASE WHEN @location = '' THEN CTY.City_Name ELSE '%'+@location+'%' END OR STA.State_Name LIKE CASE WHEN @location = '' THEN STA.State_Name ELSE '%'+@location+'%' END		OR CNT.Country_Name LIKE CASE WHEN @location = '' THEN CNT.Country_Name ELSE '%'+@location+'%' END	) ORDER BY My_Offer_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY


                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {

                        gen.sqlCommand.Parameters.AddWithValue("@categoryId", categoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@noOfRows", noOfRows);

                        gen.sqlCommand.Parameters.AddWithValue("@searchVal", searchVal);

                        gen.sqlCommand.Parameters.AddWithValue("@userLat", userLat);
                        gen.sqlCommand.Parameters.AddWithValue("@userLong", userLng);
                        gen.sqlCommand.Parameters.AddWithValue("@radius", 5000); // In meters


                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                offersList.Add(new OffersModel
                                {
                                    offerId = gen.sqlDataReader["My_Offer_Id"].ToString(),
                                    offerUnit = gen.sqlDataReader["Unit_Name"].ToString(),
                                    unitId = gen.sqlDataReader["Unit_Id"].ToString(),
                                    offerCategoryId = gen.sqlDataReader["Category_Id"].ToString(),
                                    offerSubCategoryId = gen.sqlDataReader["Sub_Category_Id"].ToString(),
                                    imagePath = gen.sqlDataReader["Image_Path"].ToString().Split(',').ToList(),
                                    offerQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                    description = gen.sqlDataReader["Description"].ToString(),
                                    offerCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    offerSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    offerPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                    count = gen.sqlDataReader["Total_Count"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {

            }
            catch (Exception ex)
            {

            }
            return offersList;
        }

        public bool ReviewOffer(int requestId, float rating)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "UPDATE [ReachHelp].[dbo].[Offer_Request_Mapping] SET [Rating]=@rating WHERE Request_Id=@requestId AND [Status]='Accepted'";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@requestId", requestId);
                        gen.sqlCommand.Parameters.AddWithValue("@rating", rating);
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

        public IUsers GetOffererDetails(string offerId)
        {
            UserModel user = new UserModel();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT TOP 1 UR.User_Name,UR.Email_Id FROM [ReachHelp].[dbo].[My_Offers] MO JOIN [ReachHelp].[dbo].[User_Register]UR on UR.User_Id=MO.Offered_By WHERE MO.My_Offer_Id = @offerId";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@offerId", offerId);
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

        public List<IOffers> ActiveOffersSubCategory(int subCategoryId, int startValue, int noOfRows)
        {
            List<IOffers> offersList = new List<IOffers>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "DECLARE @totalCount INT;SELECT @totalCount= Count(My_Offer_Id) FROM [ReachHelp].[dbo].[My_Offers] MO WHERE MO.Sub_Category_Id = CASE WHEN @subCategoryId = 0 THEN MO.Sub_Category_Id ELSE @subCategoryId END AND MO.[Status]='Pending';SELECT My_Offer_Id,Category_Name,Sub_Category_Name,Quantity,Unit_Name,Posted_Date,[Description],[Image_Path],@totalCount AS Total_Count,Unit_Id,MO.Sub_Category_Id,MO.Category_Id FROM [ReachHelp].[dbo].[My_Offers] MO JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Sub_Category_Id = MO.Sub_Category_Id JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MO.Unit  WHERE MO.Sub_Category_Id = CASE WHEN @subCategoryId = 0 THEN MO.Sub_Category_Id ELSE @subCategoryId END AND MO.[Status]='Pending' ORDER BY My_Offer_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY";

                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {

                        gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", subCategoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@noOfRows", noOfRows);

                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                offersList.Add(new OffersModel
                                {
                                    offerId = gen.sqlDataReader["My_Offer_Id"].ToString(),
                                    offerUnit = gen.sqlDataReader["Unit_Name"].ToString(),
                                    unitId = gen.sqlDataReader["Unit_Id"].ToString(),
                                    offerCategoryId = gen.sqlDataReader["Category_Id"].ToString(),
                                    offerSubCategoryId = gen.sqlDataReader["Sub_Category_Id"].ToString(),
                                    imagePath = gen.sqlDataReader["Image_Path"].ToString().Split(',').ToList(),
                                    offerQuantity = gen.sqlDataReader["Quantity"].ToString(),
                                    description = gen.sqlDataReader["Description"].ToString(),
                                    offerCategoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    offerSubCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    offerPostedDate = gen.sqlDataReader["Posted_Date"].ToString(),
                                    count = gen.sqlDataReader["Total_Count"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {

            }
            catch (Exception ex)
            {

            }
            return offersList;
        }
    }


    //public class RequestedNeeds
    //{
    //    public string offerId { get; set; }
    //    public string categoryName { get; set; }
    //    public string subCategoryName { get; set; }
    //    public string offeredQuantity { get; set; }
    //    public string offeredUnit { get; set; }
    //    public string deliveryMode { get; set; }
    //    public string deliveryAddress { get; set; }
    //    public string expectedDate { get; set; }
    //    public string requestedQuantity { get; set; }
    //    public string requestedUnit { get; set; }
    //    public string requestedDate { get; set; }
    //    public string requestedBy { get; set; }

    //    public List<RequestedNeeds> RequestedNeedsList(string offeredBy)
    //    {
    //        List<RequestedNeeds> needsList = new List<RequestedNeeds>();
    //        GenericInitialization gen = new GenericInitialization();
    //        try
    //        {
    //            using (gen.sqlConnection = new SqlConnection(gen.connectionString))
    //            {
    //                gen.sqlConnection.Open();
    //                gen.queryString = "SELECT My_Offer_Id,Category_Name,Sub_Category_Name,MO.Quantity Offered_Quantity,UM.Unit_Name AS Offered_Unit,Delivery_Mode,MR.Delivery_Address,	MR.Expected_Date,MR.Quantity,UM1.Unit_Name AS Requested_Quantity,MR.Posted_Date AS Requested_Date,User_Name AS Requested_By	FROM [ReachHelp].[dbo].[My_Offers] MO 	JOIN [ReachHelp].[dbo].[My_Requests] MR ON MR.Category_Id = MO.Category_Id AND MR.Sub_Category_Id = MO.Sub_Category_Id	JOIN [ReachHelp].[dbo].[Category_Master]CM ON MO.Category_Id = CM.Category_Id	JOIN [ReachHelp].[dbo].[Sub_Category_Master]SCM ON SCM.Sub_Category_Id = MO.Sub_Category_Id	JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = MO.Unit	JOIN [ReachHelp].[dbo].[Unit_Master] UM1 ON UM1.Unit_Id = MR.Unit		JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.User_Id = MR.Requested_By WHERE MO.Offered_By = @offeredBy";
    //                using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
    //                {
    //                    gen.sqlCommand.Parameters.AddWithValue("@offeredBy", offeredBy);
    //                    using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
    //                    {
    //                        while (gen.sqlDataReader.Read())
    //                        {
    //                            needsList.Add(new RequestedNeeds
    //                            {
    //                                offerId = gen.sqlDataReader["My_Offer_Id"].ToString(),
    //                                categoryName = gen.sqlDataReader["Category_Name"].ToString(),
    //                                subCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
    //                                offeredQuantity = gen.sqlDataReader["Offered_Quantity"].ToString(),
    //                                offeredUnit = gen.sqlDataReader["Offered_Unit"].ToString(),
    //                                deliveryMode = gen.sqlDataReader["Delivery_Mode"].ToString(),
    //                                deliveryAddress = gen.sqlDataReader["Delivery_Address"].ToString(),
    //                                expectedDate = gen.sqlDataReader["Expected_Date"].ToString(),
    //                                requestedQuantity = gen.sqlDataReader["Requested_Quantity"].ToString(),
    //                                requestedUnit = gen.sqlDataReader["Requested_Unit"].ToString(),
    //                                requestedDate = gen.sqlDataReader["Requested_Date"].ToString(),
    //                                requestedBy = gen.sqlDataReader["Requested_By"].ToString()
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
    //        return needsList;
    //    }
    //}
}
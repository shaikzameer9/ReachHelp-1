using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using ReachHelpWF.Interfaces;

namespace ReachHelpWF.Models
{
    public class UserModel: IUsers
    {
        public string userId { get; set; }
        public string userName { get; set; }
        public string middleName { get; set; }
        public string lastName { get; set; }
        public string countryCode { get; set; }
        public string phoneNumber { get; set; }
        public string emailId { get; set; }
        public string password { get; set; }
        public string roleId { get; set; }
        public string roleName { get; set; }
        public string entityName { get; set; }
        public string designation { get; set; }
        //public string address { get; set; }
        public string streetAddress1 { get; set; }
        public string streetAddress2 { get; set; }

        public string countryId { get; set; }
        public string countryName { get; set; }
        public string stateId { get; set; }
        public string stateName { get; set; }
        public string cityId { get; set; }
        public string cityName { get; set; }
        public string pincode { get; set; }
        public string latitude { get; set; }
        public string longitude { get; set; }
        public string status { get; set; }
        public string registrationDate { get; set; }
        public string error { get; set; }
        public UInt16 number { get; set; }
        public UInt16 userCount { get; set; }

        public string count { get; set; }

        /// <summary>
        /// Description: Default COnstructor
        /// </summary>
        public UserModel()
        {

        }
        /// <summary>
        /// Description: User Defined Constructor
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="phoneNumber"></param>
        /// <param name="password"></param>
        /// <param name="roleId"></param>
        /// <param name="entityName"></param>
        /// <param name="designation"></param>
        /// <param name="address"></param>
        /// <param name="countryId"></param>
        /// <param name="stateId"></param>
        /// <param name="cityId"></param>
        /// <param name="pincode"></param>
        /// <param name="latitude"></param>
        /// <param name="longitude"></param>
        /// <param name="status"></param>
        public UserModel(string userName, string phoneNumber, string password, string roleId, string entityName, string designation, string streetAddress1, string streetAddress2, string countryId, string stateId, string cityId, string pincode, string latitude, string longitude)
        {
            this.userName = userName;
            this.phoneNumber = phoneNumber;
            this.password = password;
            this.roleId = roleId;
            this.entityName = entityName;
            this.designation = designation;
            this.userName = userName;
            //this.address = address;
            this.streetAddress1 = streetAddress1;
            this.streetAddress2 = streetAddress2;            
            this.countryId = countryId;
            this.stateId = stateId;
            this.cityId = cityId;
            this.pincode = pincode;
            this.latitude = latitude;
            this.longitude = longitude;
            //this.status = status;
        }
        /// <summary>
        /// Description: To add or update a user details
        /// </summary>
        /// <param name="userDetails"></param>
        /// <returns></returns>
        public bool RegisterUser(UserModel userDetails)
        {
            try
            {
                GenericInitialization gen = new GenericInitialization();
                MessagingModel otpGeneration = new MessagingModel();
                string otp = otpGeneration.GenerateOTP();
                //gen.connectionString = "Data Source=202.141.20.10; User Id=apcoglocal; Password=apcoglocal123; Initial Catalog =ReachHelp;";
                //gen.queryString = "IF EXISTS(SELECT User_Id FROM [ReachHelp].[dbo].[User_Register] WHERE Phone_Number=@phoneNumber)	BEGIN UPDATE [ReachHelp].[dbo].[User_Register] SET User_Name=@userName,Entity_Name=@entityName,Designation=@designation,Address=@address,Country_Id=@countryId,State_Id=@stateId,City_Id=@cityId,Pincode=@pinCode,Latitude=@latitude,Longitude=@longitude WHERE Phone_Number=@phoneNumber;SELECT 'Update' AS [Status];END ELSE BEGIN INSERT INTO [ReachHelp].[dbo].[User_Register](User_Name,Phone_Number,Password,Role_Id,Entity_Name,Designation,Address,Country_Id,State_Id,City_Id,Pincode,Latitude,Longitude,Status) VALUES(@userName,@phoneNumber,@password,@roleId,@entityName,@designation,@address,@countryId,@stateId,@cityId,@pinCode,@latitude,@longitude,'New');SELECT 'Insert' AS [Status]; END";
                //gen.queryString = "IF EXISTS(SELECT User_Id FROM [ReachHelp].[dbo].[User_Register] WHERE Phone_Number=@phoneNumber)	BEGIN UPDATE [ReachHelp].[dbo].[User_Register] SET User_Name=@userName,Entity_Name=@entityName,Designation=@designation,Address=@address,Country_Id=@countryId,State_Id=@stateId,City_Id=@cityId,Pincode=@pinCode,Latitude=@latitude,Longitude=@longitude WHERE Phone_Number=@phoneNumber;SELECT 'Update' AS [Status];END ELSE BEGIN INSERT INTO [ReachHelp].[dbo].[User_Register](User_Name,Phone_Number,Password,Role_Id,Entity_Name,Designation,Address,Country_Id,State_Id,City_Id,Pincode,Latitude,Longitude,Status) VALUES(@userName,@phoneNumber,@password,@roleId,@entityName,@designation,@address,@countryId,@stateId,@cityId,@pinCode,@latitude,@longitude,'New');SELECT 'New' AS [Status]; END";
                gen.queryString = "IF EXISTS(SELECT User_Id FROM [ReachHelp].[dbo].[User_Register] WHERE Phone_Number=@phoneNumber)	BEGIN UPDATE [ReachHelp].[dbo].[User_Register] SET User_Name=@userName,Entity_Name=@entityName,Designation=@designation,Street_Address_1=@streetAddress1,Street_Address_2=@streetAddress2,Country_Id=@countryId,State_Id=@stateId,City_Name=@cityName,Pincode=@pinCode,Latitude=@latitude,Longitude=@longitude, Email_Id=@emailId, Middle_Name = @middleName, Last_Name=@lastName, Country_Code=@countryCode WHERE Phone_Number=@phoneNumber;SELECT 'Update' AS [Status];END ELSE BEGIN INSERT INTO [ReachHelp].[dbo].[User_Register](User_Name,Middle_Name,Last_Name,Country_Code,Phone_Number,Password,Role_Id,Entity_Name,Designation,Street_Address_1,Street_Address_2,Country_Id,State_Id,City_Name,Pincode,Latitude,Longitude,Status,Email_Id) VALUES(@userName,@middleName, @lastName,@countryCode,@phoneNumber,@password,@roleId,@entityName,@designation,@streetAddress1,@streetAddress2,@countryId,@stateId,@cityName,@pinCode,@latitude,@longitude,'New',@emailId);SELECT 'New' AS [Status]; END";
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@userName", userDetails.userName);
                        gen.sqlCommand.Parameters.AddWithValue("@middleName", userDetails.middleName);
                        gen.sqlCommand.Parameters.AddWithValue("@lastName", userDetails.lastName);
                        gen.sqlCommand.Parameters.AddWithValue("@entityName", userDetails.entityName);  // Optional
                        gen.sqlCommand.Parameters.AddWithValue("@countryCode", userDetails.countryCode);
                        gen.sqlCommand.Parameters.AddWithValue("@phoneNumber", userDetails.phoneNumber);
                        gen.sqlCommand.Parameters.AddWithValue("@password", MD5Hash(otp));
                        gen.sqlCommand.Parameters.AddWithValue("@roleId", userDetails.roleId);  // 1 - SysAdmin, 2 - Monitor, 3 - User
                        gen.sqlCommand.Parameters.AddWithValue("@designation", userDetails.designation);    // Optional
                        //gen.sqlCommand.Parameters.AddWithValue("@address", userDetails.address);
                        gen.sqlCommand.Parameters.AddWithValue("@streetAddress1", userDetails.streetAddress1);
                        gen.sqlCommand.Parameters.AddWithValue("@streetAddress2", userDetails.streetAddress2);
                        gen.sqlCommand.Parameters.AddWithValue("@countryId", userDetails.countryId);
                        gen.sqlCommand.Parameters.AddWithValue("@stateId", userDetails.stateId);
                        //gen.sqlCommand.Parameters.AddWithValue("@cityId", userDetails.cityId);
                        gen.sqlCommand.Parameters.AddWithValue("@cityName", userDetails.cityName);
                        gen.sqlCommand.Parameters.AddWithValue("@pincode", userDetails.pincode);
                        gen.sqlCommand.Parameters.AddWithValue("@latitude", userDetails.latitude);  // Optional
                        gen.sqlCommand.Parameters.AddWithValue("@longitude", userDetails.longitude);    // Optional
                        gen.sqlCommand.Parameters.AddWithValue("@emailId", userDetails.emailId);    // Optional
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                if (gen.sqlDataReader["Status"].ToString() == "New")
                                {
                                    //Trigger Email
                                    //otpGeneration.TriggerEmail(userDetails.emailId, userDetails.userName,"Welcome to ReacHelp","<!DOCTYPE html><html> <head> <meta charset=\"utf-8\"> </head> <body> <p> Dear User, </p> <br> <p> You have been registered at ReachHelp. Your OTP is \"" + otp + "\". Kindly Login to <a href=\"http://reachelp.in\">ReachHelp<a> to login. </p> </body></html>");                                    
                                    /*if (userDetails.emailId != "")
                                    {*/
                                        otpGeneration.TriggerEmail(userDetails.emailId, userDetails.userName, "Welcome to ReacHelp", "<!DOCTYPE html><html> <head> <meta charset=\"utf-8\"> </head> <body> <p> Dear User, </p> <br> <p>You have successfully registered with ReacHelp. Your Temporary Password is <strong>“" + otp + "”</strong>. Please return to <a href=\"http://reachelp.in\">ReacHelp</a> to login and complete the enrollment process. Your user name can be either your cell phone number or your email ID. Your initial password will be the Temporary Password. Once you have logged in, please change your password to something you will remember</p> </body></html>");                                        
                                    /*}
                                    else
                                    {
                                        //Trigger SMS
                                        string fullMobileNumber = (userDetails.countryCode == null ? "" : userDetails.countryCode) + userDetails.phoneNumber;
                                        otpGeneration.TriggerSMS("You have been registered at ReachHelp. Your Temporary Password is " + otp + ". Please Login with your phone number.", fullMobileNumber); //Incomplete
                                    }*/
                                    
                                    updateGeography(userDetails.latitude, userDetails.longitude, userDetails.emailId);
                                    
                                    return true;
                                }
                                else if (gen.sqlDataReader["Status"].ToString() == "Update")
                                {
                                    updateGeography(userDetails.latitude, userDetails.longitude, userDetails.emailId);
                                    return true;
                                }
                            }
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

        public void updateGeography(string lat, string lng, string userEmail)
        {
            try
            {
                GenericInitialization gen = new GenericInitialization();
                gen.queryString = "UPDATE [ReachHelp].[dbo].[User_Register] SET [Geography] = GEOGRAPHY::Point (@Latitude, @Longitude, 4326) Where [Email_Id] = @Email";

                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@Latitude", lat);
                        gen.sqlCommand.Parameters.AddWithValue("@Longitude", lng);
                        gen.sqlCommand.Parameters.AddWithValue("@Email", userEmail);
                        int status = gen.sqlCommand.ExecuteNonQuery();
                    }
                }

            }
            catch (Exception ex) { }
            
        }


        /// <summary>
        /// Description: To update the status of a user
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="status"></param>
        /// <returns></returns>
        public bool UpdateUserStatus(string userId, string status)
        {
            try
            {
                GenericInitialization gen = new GenericInitialization();
                gen.queryString = "UPDATE [ReachHelp].[dbo].[User_Register] SET [Status]=@status WHERE User_Id=@userId";
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@userId", userId);
                        gen.sqlCommand.Parameters.AddWithValue("@status", status);
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

        public bool ChangeUserPassword(string userId, string password)
        {
            try
            {
                GenericInitialization gen = new GenericInitialization();
                gen.queryString = "UPDATE [ReachHelp].[dbo].[User_Register] SET [Password]=@password WHERE User_Id=@userId";
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@userId", userId);
                        gen.sqlCommand.Parameters.AddWithValue("@password", MD5Hash(password));
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

        public bool forgotUserPassword(string phoneno)
        {
            MessagingModel otpGeneration = new MessagingModel();
            string otp = otpGeneration.GenerateOTP();
            try
            {
                GenericInitialization gen = new GenericInitialization();
                gen.queryString = "UPDATE [ReachHelp].[dbo].[User_Register] SET [Password]=@password,[Status]='New' WHERE (Phone_Number=@phoneno OR Email_Id=@phoneno)";
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@phoneno", phoneno);
                        gen.sqlCommand.Parameters.AddWithValue("@password", MD5Hash(otp));
                        if (gen.sqlCommand.ExecuteNonQuery() > 0) {                            
                            /*if(phoneno.Contains('@')){*/
                                string destEmail = phoneno;
                                otpGeneration.TriggerEmail(destEmail, "User", "Password Reset for Forgot Password", "<!DOCTYPE html><html> <head> <meta charset=\"utf-8\"> </head> <body> <p> Dear User, </p> <br> <p> Your password has been reset. Your Temporary Password is \"<b>" + otp + "</b>\". Kindly visit <a href=\"http://reachelp.in\">ReachHelp<a> to login.</p> </body></html>");
                            /*}
                            else{
                                otpGeneration.TriggerSMS("Your Temporary Password is " + otp + ". Login with your Email/Phone No. using this Temporary Password .", phoneno);
                            }*/
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

        public string MD5Hash(string text)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));
            byte[] result = md5.Hash;
            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                strBuilder.Append(result[i].ToString("x2"));
            }

            return strBuilder.ToString();
        }

        public UserModel UserLogin(string phoneNumber, string password)
        {
            UserModel userDetails = new UserModel();
            try
            {
                GenericInitialization gen = new GenericInitialization();
                //gen.queryString = "SELECT User_Id,User_Name,Role_Name FROM [ReachHelp].[dbo].[User_Register] UR LEFT JOIN [ReachHelp].[dbo].[Role_Master] RM ON RM.Role_Id = UR.Role_Id WHERE Phone_Number=@phoneNumber AND [Password]=@password AND UR.[Status]='Active' OR UR.[Status]='New'";
                gen.queryString = "SELECT User_Id,User_Name,Role_Name, UR.Status FROM [ReachHelp].[dbo].[User_Register] UR LEFT JOIN [ReachHelp].[dbo].[Role_Master] RM ON RM.Role_Id = UR.Role_Id WHERE (Phone_Number=@phoneNumber OR Email_Id=@phoneNumber) AND [Password]=@password AND (UR.[Status]='Active' OR UR.[Status]='New')";
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@phoneNumber", phoneNumber);
                        gen.sqlCommand.Parameters.AddWithValue("@password", MD5Hash(password));
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    userDetails.userId = gen.sqlDataReader["User_Id"].ToString();
                                    userDetails.userName = gen.sqlDataReader["User_Name"].ToString();
                                    userDetails.roleName = gen.sqlDataReader["Role_Name"].ToString();
                                    userDetails.status = gen.sqlDataReader["Status"].ToString();
                                }
                            }
                            else
                            {
                                userDetails.status = "Failed";
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                userDetails.error = "Error";
            }
            catch (Exception ex)
            {
                userDetails.error = "Error";
            }
            return userDetails;
        }

        public List<UserModel> GetAllMonitors(int startValue, int noOfRows)
        {
            List<UserModel> monitorsList = new List<UserModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    //gen.queryString = "SELECT * FROM [ReachHelp].[dbo].User_Register WHERE Role_Id=3 ORDER BY [User_Name] DESC";

                    gen.queryString = "SELECT UR.User_Id, User_Name, Middle_Name, Last_Name, Country_Code, Phone_Number, Email_Id, Password, Role_Id, Entity_Name, Designation, Street_Address_1,Street_Address_2, UR.Country_Id, UR.State_Id,SM.State_Name, UR.City_Name, Pincode, Registration_Date,UR.Latitude, UR.Longitude, Status,COUNT(UR.User_Id) OVER (PARTITION BY 1) AS Count FROM [ReachHelp].[dbo].User_Register UR JOIN [dbo].[State_Master] SM ON SM.State_Id = UR.State_Id WHERE Role_Id != 1 ORDER BY UR.User_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY";

                    //gen.queryString = "SELECT UR.User_Id, User_Name, Middle_Name, Last_Name, Country_Code, Phone_Number, Email_Id, Password, Role_Id, Entity_Name, Designation, Street_Address_1,Street_Address_2, UR.Country_Id, UR.State_Id,SM.State_Name, UR.City_Name, Pincode, Registration_Date, Status,COUNT(UR.User_Id) OVER (PARTITION BY 1) AS Count FROM [ReachHelp].[dbo].User_Register UR JOIN [dbo].[State_Master] SM ON SM.State_Id = UR.State_Id JOIN [dbo].[City_Master] CM WHERE Role_Id=2  ORDER BY UR.User_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY";
                    //SELECT UR.User_Id, User_Name, Middle_Name, Last_Name, Country_Code, Phone_Number, Email_Id, Password, Role_Id, Entity_Name, Designation, Street_Address_1,Street_Address_2, UR.Country_Id, UR.State_Id,SM.State_Name, UR.City_Id,CM.City_Name, Pincode, Registration_Date, Status,COUNT(UR.User_Id) OVER (PARTITION BY 1) AS Count FROM [ReachHelp].[dbo].User_Register UR JOIN [dbo].[State_Master] SM ON SM.State_Id = UR.State_Id JOIN [dbo].[City_Master] CM ON CM.City_Id = UR.City_Id WHERE Role_Id=2  ORDER BY UR.User_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {

                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@noOfRows", noOfRows);

                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                monitorsList.Add(new UserModel
                                {
                                    userId = gen.sqlDataReader["User_Id"].ToString(),
                                    userName = gen.sqlDataReader["User_Name"].ToString(),
                                    middleName = gen.sqlDataReader["Middle_Name"].ToString(),
                                    lastName = gen.sqlDataReader["Last_Name"].ToString(),
                                    phoneNumber = gen.sqlDataReader["Phone_Number"].ToString(),
                                    countryCode = gen.sqlDataReader["Country_Code"].ToString(),
                                    roleId = gen.sqlDataReader["Role_Id"].ToString(),
                                    entityName = gen.sqlDataReader["Entity_Name"].ToString(),
                                    designation = gen.sqlDataReader["Designation"].ToString(),
                                    //address = gen.sqlDataReader["Address"].ToString(),
                                    streetAddress1 = gen.sqlDataReader["Street_Address_1"].ToString(),
                                    streetAddress2 = gen.sqlDataReader["Street_Address_2"].ToString(),
                                    countryId = gen.sqlDataReader["Country_Id"].ToString(),
                                    stateId = gen.sqlDataReader["State_Id"].ToString(),
                                    stateName = gen.sqlDataReader["State_Name"].ToString(),
                                    //cityId = gen.sqlDataReader["City_Id"].ToString(),                                    
                                    cityName = gen.sqlDataReader["City_Name"].ToString(),
                                    pincode = gen.sqlDataReader["Pincode"].ToString(),
                                    registrationDate = gen.sqlDataReader["Registration_Date"].ToString(),
                                    latitude = gen.sqlDataReader["Latitude"].ToString(),
                                    longitude = gen.sqlDataReader["Longitude"].ToString(),
                                    // status = gen.sqlDataReader["Status"].ToString()
                                    status = gen.sqlDataReader["Status"].ToString(),
                                    emailId = gen.sqlDataReader["Email_Id"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                monitorsList.Add(new UserModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                monitorsList.Add(new UserModel
                {
                    error = "Error"
                });
            }
            return monitorsList;
        }

        public UserModel GetUserDetails(string userId)
        {
            userId = HttpContext.Current.Session["UserId"].ToString();
            UserModel userDetails = new UserModel();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT UR.[User_Id],UR.[User_Name],UR.[Middle_Name],UR.[Last_Name],UR.[Country_Code],UR.[Phone_Number],UR.[Role_Id],RM.[Role_Name],UR.[Entity_Name],UR.[Designation],UR.[Street_Address_1],UR.[Street_Address_2],UR.[Country_Id],UR.[State_Id],UR.[City_Name],UR.[Pincode],UR.[Latitude],UR.[Longitude],UR.[Registration_Date],UR.[Status],Email_Id FROM [ReachHelp].[dbo].User_Register UR LEFT JOIN [dbo].[Role_Master] RM ON UR.[Role_Id] = RM.[Role_Id] WHERE User_Id = @userId";
                    //SELECT UR.[User_Id],UR.[User_Name],UR.[Middle_Name],UR.[Last_Name],UR.[Country_Code],UR.[Phone_Number],UR.[Role_Id],RM.[Role_Name],UR.[Entity_Name],UR.[Designation],UR.[Street_Address_1],UR.[Street_Address_2],UR.[Country_Id],UR.[State_Id],UR.[City_Id],UR.[Pincode],UR.[Latitude],UR.[Longitude],UR.[Registration_Date],UR.[Status],Email_Id FROM [ReachHelp].[dbo].User_Register UR LEFT JOIN [dbo].[Role_Master] RM ON UR.[Role_Id] = RM.[Role_Id] WHERE User_Id = @userId
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@userId",userId);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                userDetails.userId = gen.sqlDataReader["User_Id"].ToString();
                                userDetails.userName = gen.sqlDataReader["User_Name"].ToString();
                                userDetails.middleName = gen.sqlDataReader["Middle_Name"].ToString();
                                userDetails.lastName = gen.sqlDataReader["Last_Name"].ToString();
                                userDetails.phoneNumber = gen.sqlDataReader["Phone_Number"].ToString();
                                userDetails.countryCode = gen.sqlDataReader["Country_Code"].ToString();
                                userDetails.roleId = gen.sqlDataReader["Role_Id"].ToString();
                                userDetails.roleName = gen.sqlDataReader["Role_Name"].ToString();
                                userDetails.entityName = gen.sqlDataReader["Entity_Name"].ToString();
                                userDetails.designation = gen.sqlDataReader["Designation"].ToString();
                                //userDetails.address = gen.sqlDataReader["Address"].ToString();
                                userDetails.streetAddress1 = gen.sqlDataReader["Street_Address_1"].ToString();
                                userDetails.streetAddress2 = gen.sqlDataReader["Street_Address_2"].ToString();
                                userDetails.countryId = gen.sqlDataReader["Country_Id"].ToString();
                                userDetails.stateId = gen.sqlDataReader["State_Id"].ToString();
                                //userDetails.cityId = gen.sqlDataReader["City_Id"].ToString();
                                userDetails.cityName = gen.sqlDataReader["City_Name"].ToString();
                                userDetails.pincode = gen.sqlDataReader["Pincode"].ToString();
                                userDetails.registrationDate = gen.sqlDataReader["Registration_Date"].ToString();
                                // status = gen.sqlDataReader["Status"].ToString()
                                userDetails.status = gen.sqlDataReader["Status"].ToString();
                                userDetails.emailId = gen.sqlDataReader["Email_Id"].ToString();
                                userDetails.latitude = gen.sqlDataReader["Latitude"].ToString();
                                userDetails.longitude = gen.sqlDataReader["Longitude"].ToString();
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                userDetails.error = "Error";
            }
            catch (Exception ex)
            {
                userDetails.error = "Error";
            }
            return userDetails;
        }

        public int GetCreditsOfUser(string userId)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT COUNT(Mapping_Id) AS Credits FROM [ReachHelp].[dbo].[User_Register]UR JOIN [ReachHelp].[dbo].[My_Offers]MO ON MO.Offered_By = UR.User_Id JOIN [ReachHelp].[dbo].[Offer_Request_Mapping] ORM ON ORM.Offer_Id = MO.My_Offer_Id WHERE User_Id=@userId AND ORM.[Status]='Accepted'";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@userId", userId);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                return Convert.ToInt32(gen.sqlDataReader["Credits"].ToString());
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
 
            }
            return 0;
        }

    }
}
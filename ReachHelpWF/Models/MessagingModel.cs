using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Data.SqlClient;
using mailinblue;
using ReachHelpWF.Interfaces;
using System.Configuration;
namespace ReachHelpWF.Models
{
    public class MessagingModel
    {
        public string baseUrl { get; set; }
        public string userName { get; set; }
        public string password { get; set; }
        public string senderId { get; set; }
        public string provider { get; set; }
        public string error { get; set; }
        public string status { get; set; } 

        public string GenerateOTP()
        {
            Random random = new Random();
            return random.Next(200000, 999999).ToString();
        }

        public MessagingModel GetSMSDetails()
        {
            MessagingModel smsDetails = new MessagingModel();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT TOP 1 * FROM [ReachHelp].[dbo].[SMS_Master] WHERE [Status]='Active'";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                smsDetails.baseUrl = gen.sqlDataReader["Base_Url"].ToString();
                                smsDetails.userName = gen.sqlDataReader["User_Name"].ToString();
                                smsDetails.password = gen.sqlDataReader["Password"].ToString();
                                smsDetails.senderId = gen.sqlDataReader["Sender_Id"].ToString();
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                smsDetails.error = "Error";
            }
            catch (Exception ex)
            {
                smsDetails.error = "Error";
            }
            return smsDetails;
        }
        public bool TriggerSMS(string messageContent, string mobileNumber)
        {
            try
            {
                if (mobileNumber.Length >= 10 && mobileNumber.Length <= 12)
                {
                    WebClient client = new WebClient();
                    MessagingModel getSmsDetails = GetSMSDetails();
                    string baseUrl = getSmsDetails.baseUrl + "?user=" + getSmsDetails.userName + "&password=" + getSmsDetails.password + "&sender=" + getSmsDetails.senderId + "&SMSText=";

                    //string baseurl = "https://api.kapsystem.com/api/v3/sendsms/plain?user=rampskumar&password=vlfRDt44&sender=SOWNET&SMSText=";
                    if (mobileNumber.ToString().Length == 12)
                    {
                        baseUrl += messageContent + "&type=longsms&GSM=" + mobileNumber;
                    }
                    else if (mobileNumber.ToString().Length == 10)
                    {
                        baseUrl += messageContent + "&type=longsms&GSM=91" + mobileNumber;
                    }
                    Stream data = client.OpenRead(baseUrl);
                    StreamReader reader = new StreamReader(data);
                    string ResponseID = reader.ReadToEnd();
                    data.Close();
                    reader.Close();
                    return true;
                }
                return false; 
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool AddSMSMaster(MessagingModel smsDetails)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "IF NOT EXISTS(SELECT Sender_Id FROM [ReachHelp].[dbo].[SMS_Master] WHERE Sender_Id=@senderId)	BEGIN UPDATE [ReachHelp].[dbo].[SMS_Master] SET [Status]=CASE WHEN @status='Active' THEN 'Inactive' ELSE [Status] END;INSERT INTO [ReachHelp].[dbo].[SMS_Master](SMS_Provider,User_Name,Password,Sender_Id,Base_Url,Status) VALUES(@provider,@userName,@password,@senderId,@baseUrl,@status);	END ELSE UPDATE [ReachHelp].[dbo].[SMS_Master] SET [Status]=@status WHERE Sender_Id=@senderId;";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@provider", smsDetails.provider);
                        gen.sqlCommand.Parameters.AddWithValue("@baseUrl", smsDetails.baseUrl);
                        gen.sqlCommand.Parameters.AddWithValue("@userName", smsDetails.userName);
                        gen.sqlCommand.Parameters.AddWithValue("@senderId", smsDetails.senderId);
                        gen.sqlCommand.Parameters.AddWithValue("@password", smsDetails.password);
                        gen.sqlCommand.Parameters.AddWithValue("@status", smsDetails.status);
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

        public List<MessagingModel> ListSMSOperators()
        {
            GenericInitialization gen = new GenericInitialization();
            List<MessagingModel> smsDetails = new List<MessagingModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT * FROM [ReachHelp].[dbo].[SMS_Master]";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                smsDetails.Add(new MessagingModel
                                {
                                    senderId = gen.sqlDataReader["Sender_Id"].ToString(),
                                    password = gen.sqlDataReader["Password"].ToString(),
                                    userName = gen.sqlDataReader["User_Name"].ToString(),
                                    baseUrl = gen.sqlDataReader["Base_Url"].ToString(),
                                    provider = gen.sqlDataReader["SMS_Provider"].ToString(),
                                    status = gen.sqlDataReader["Status"].ToString(),
                                });
                            }
                        }                        
                    }
                }
            }
            catch (SqlException ex)
            {
                smsDetails.Add(new MessagingModel { error = "Error" });
            }
            catch (Exception ex)
            {
                smsDetails.Add(new MessagingModel { error = "Error" });
            }
            return smsDetails;
        }

        public string TriggerEmail(IUsers users, string emailSubject, string EmailContent)
        {

            try
            {
                //API sendinBlue = new mailinblue.API("d4jYbr0PcAFKJBg5");                ;
                API sendinBlue = new mailinblue.API(ConfigurationManager.AppSettings["SENDINBLUE_API"].ToString());
                Dictionary<string, Object> data = new Dictionary<string, Object>();
                Dictionary<string, string> to = new Dictionary<string, string>();


                to.Add(users.emailId, users.userName);
                List<string> from_name = new List<string>();
                //from_name.Add("support@reachelp.in");
                //from_name.Add("Reachelp Support");
                from_name.Add(ConfigurationManager.AppSettings["FROM_ADD"].ToString());
                from_name.Add(ConfigurationManager.AppSettings["FROM_NAME"].ToString());

                data.Add("to", to);
                data.Add("from", from_name);
                data.Add("subject", emailSubject);
                data.Add("html", EmailContent);


                Object sendEmail = sendinBlue.send_email(data);
                return sendEmail.ToString();
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }

        public string TriggerEmail(string toEmail, string toUsername, string emailSubject, string EmailContent)
        {

            try
            {
                API sendinBlue = new mailinblue.API("d4jYbr0PcAFKJBg5");
                Dictionary<string, Object> data = new Dictionary<string, Object>();
                Dictionary<string, string> to = new Dictionary<string, string>();


                to.Add(toEmail, toUsername);
                List<string> from_name = new List<string>();
                from_name.Add("support@reachelp.in");
                from_name.Add("ReacHelp Support");

                data.Add("to", to);
                data.Add("from", from_name);
                data.Add("subject", emailSubject);
                data.Add("html", EmailContent);


                Object sendEmail = sendinBlue.send_email(data);
                return sendEmail.ToString();
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }

        public string TriggerEmailWithAttachment(string toEmail, string toUsername, string emailSubject, string EmailContent, string fileBase64, string filename)
        {
            try
            {
                API sendinBlue = new mailinblue.API("d4jYbr0PcAFKJBg5");
                Dictionary<string, Object> data = new Dictionary<string, Object>();
                Dictionary<string, string> to = new Dictionary<string, string>();

                to.Add(toEmail, toUsername);
                List<string> from_name = new List<string>();
                from_name.Add("support@reachelp.in");
                from_name.Add("Reachelp Support");
                Dictionary<string, string> attachment = new Dictionary<string, string>();
                attachment.Add(filename, fileBase64);

                data.Add("to", to);
                data.Add("from", from_name);
                data.Add("subject", emailSubject);
                data.Add("html", EmailContent);
                data.Add("attachment", attachment);

                Object sendEmail = sendinBlue.send_email(data);
                return sendEmail.ToString();
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }

       
    }
}
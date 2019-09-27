using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ReachHelpWF.Models
{
    public class ChatMessageModel
    {
        public int id { get; set; }
        public int offerId { get; set; }
        public int requestorUserId { get; set; }
        public int offererUserId { get; set; }
        public string message { get; set; }
        public string dateTime { get; set; }
        public string sentBy { get; set; }
        public string status { get; set; }
        public string error { get; set; }

        public string sendMessage(ChatMessageModel chatMessage)
        {
            GenericInitialization gen = new GenericInitialization();
            string response = "failed";
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "INSERT INTO [ReachHelp].[dbo].[ChatMessages] (Offer_Id, Requestor_User_Id, Offerer_User_Id, Message,Sent_By,Date_Time, Status) VALUES(@offerId, @requestorUserId, @offererUserId, @message,@sentBy,GETDATE(), @status)";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@offerId", chatMessage.offerId);
                        gen.sqlCommand.Parameters.AddWithValue("@requestorUserId", chatMessage.requestorUserId);
                        gen.sqlCommand.Parameters.AddWithValue("@offererUserId", chatMessage.offererUserId);
                        gen.sqlCommand.Parameters.AddWithValue("@sentBy", chatMessage.sentBy);
                        gen.sqlCommand.Parameters.AddWithValue("@message", chatMessage.message);                        
                        gen.sqlCommand.Parameters.AddWithValue("@status", "unread");

                        if (gen.sqlCommand.ExecuteNonQuery()>0)
                        {
                            response = "success";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                response = "failed";
            }

            return response;
        }

        public List<ChatMessageModel> getMessages(int offerId, int requestorUserId, int offererUserId)
        {
            GenericInitialization gen = new GenericInitialization();
            List<ChatMessageModel> chatMessages = new List<ChatMessageModel>();

            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT * FROM [ReachHelp].[dbo].[ChatMessages] WHERE Offer_Id = @offerId AND Requestor_User_Id = @requestedBy AND Offerer_User_Id = @offeredBy";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@offerId",offerId);
                        gen.sqlCommand.Parameters.AddWithValue("@requestedBy",requestorUserId);
                        gen.sqlCommand.Parameters.AddWithValue("@offeredBy",offererUserId);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                chatMessages.Add(new ChatMessageModel { 
                                    id = Int16.Parse(gen.sqlDataReader["Id"].ToString()),
                                    offerId = Int16.Parse(gen.sqlDataReader["Offer_Id"].ToString()),
                                    requestorUserId = Int16.Parse(gen.sqlDataReader["Requestor_User_Id"].ToString()),
                                    offererUserId = Int16.Parse(gen.sqlDataReader["Offerer_User_Id"].ToString()),
                                    message = gen.sqlDataReader["Message"].ToString(),
                                    sentBy = gen.sqlDataReader["Sent_By"].ToString(),
                                    dateTime = gen.sqlDataReader["Date_Time"].ToString(),
                                    status = gen.sqlDataReader["Status"].ToString(),
                                });
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                chatMessages[0].error = ex.Message;
            }

            return chatMessages;
        }

    }
}
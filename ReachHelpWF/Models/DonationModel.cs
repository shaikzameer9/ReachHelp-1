using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ReachHelpWF.Interfaces;
using System.Data.SqlClient;

namespace ReachHelpWF.Models
{
    public class DonationModel: IDonations
    {
        public string phoneNumber { get; set; }
        public string emailId { get; set; }
        public string userName { get; set; }
        public string donationDate { get; set; }
        public string donationId { get; set; }
        public Int64 donatedBy { get; set; }
        public double amount { get; set; }
        public UInt16 number { get; set; }
        public string transactionId { get; set; }
        public string status { get; set; }
        public string remarks { get; set; }        
        public string error { get; set; }

        public bool InsertDonation(DonationModel donationDetails)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "INSERT INTO [ReachHelp].[dbo].[Donations] VALUES(GETDATE(),@donatedBy,@amount,@transactionId,@status)";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@donatedBy", donationDetails.donatedBy);
                        gen.sqlCommand.Parameters.AddWithValue("@amount", donationDetails.amount);
                        gen.sqlCommand.Parameters.AddWithValue("@transactionId", donationDetails.transactionId);
                        gen.sqlCommand.Parameters.AddWithValue("@status", donationDetails.status);
                        //gen.sqlCommand.Parameters.AddWithValue("@remarks", donationDetails.remarks);                       
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

        public List<IDonations> DonationDetails(DonationModel donationDetails)
        {
            GenericInitialization gen = new GenericInitialization();
            List<IDonations> donationInfo = new List<IDonations>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT [Sl_No],[Donation_Date],UR.[User_Id],UR.[User_Name],[Amount],[Transaction_Id],[Status] FROM [ReachHelp].[dbo].[Donations]D JOIN [ReachHelp].[dbo].[User_Register]UR ON UR.User_Id=D.User_Id WHERE [User_Id] = CASE @donatedBy='' THEN [User_Id] ELSE @userId END ";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@donatedBy", donationDetails.donatedBy);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    donationInfo.Add(new DonationModel
                                    {
                                        donationDate = gen.sqlDataReader["Donation_Date"].ToString(),
                                        donatedBy = Int64.Parse(gen.sqlDataReader["User_Id"].ToString()),
                                        amount = Int64.Parse(gen.sqlDataReader["Amount"].ToString()),
                                        transactionId = gen.sqlDataReader["Transaction_Id"].ToString(),
                                        status = gen.sqlDataReader["Status"].ToString(),
                                        userName = gen.sqlDataReader["User_Name"].ToString(),
                                        donationId = gen.sqlDataReader["Sl_No"].ToString()
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                donationInfo.Add(new DonationModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                donationInfo.Add(new DonationModel
                {
                    error = "Error"
                });
            }
            return donationInfo;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace ReachHelpWF.Models
{
    public class InfoLinksModel
    {
        public string infoLinkId { get; set; }
        public string infoLinkTitle { get; set; }
        public string infoLinkUrl { get; set; }
        public string infoLinkstatus { get; set; }
        public string infoLinkAddedById { get; set; }
        public string infoLinkAddedByName { get; set; }
        public string infoLinkDate { get; set; }
        public string error { get; set; }
        public string count { get; set; }

        public List<InfoLinksModel> ListInfoLinksUser()
        {
            GenericInitialization gen = new GenericInitialization();
            List<InfoLinksModel> infoLinkList = new List<InfoLinksModel>();
            try
            {
                gen.queryString = "SELECT  [Info_Links_Id] ,[Title] ,[URL] ,[Added_Date]  FROM [ReachHelp].[dbo].[Info_Links] WHERE [Status]='Active'";
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                infoLinkList.Add(new InfoLinksModel
                                {
                                    infoLinkId = gen.sqlDataReader["Info_Links_Id"].ToString(),
                                    infoLinkTitle = gen.sqlDataReader["Title"].ToString(),
                                    infoLinkUrl = gen.sqlDataReader["URL"].ToString(),
                                    infoLinkDate = gen.sqlDataReader["Added_Date"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                infoLinkList.Add(new InfoLinksModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                infoLinkList.Add(new InfoLinksModel
                {
                    error = "Error"
                });
            }
            return infoLinkList;
        }

        public List<InfoLinksModel> ListInfoLinksAdmin(int startValue, int noOFRows)
        {
            GenericInitialization gen = new GenericInitialization();
            List<InfoLinksModel> infoLinkList = new List<InfoLinksModel>();
            try
            {
                gen.queryString = "DECLARE @count INT;SELECT @count=COUNT(Info_Links_Id) FROM Info_Links;SELECT Info_Links_Id,Title,URL,Added_By,User_Name AS Added_By_Name,IL.[Status], IL.Added_Date,@count AS [Count] FROM Info_Links IL JOIN [ReachHelp].[dbo].[User_Register] UR ON UR.user_Id=IL.Added_By ORDER BY Info_Links_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOFRows ROWS ONLY";
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@noOFRows", noOFRows);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                infoLinkList.Add(new InfoLinksModel
                                {
                                    infoLinkId = gen.sqlDataReader["Info_Links_Id"].ToString(),
                                    infoLinkTitle = gen.sqlDataReader["Title"].ToString(),
                                    infoLinkUrl = gen.sqlDataReader["URL"].ToString(),
                                    infoLinkAddedById = gen.sqlDataReader["Added_By"].ToString(),
                                    infoLinkAddedByName = gen.sqlDataReader["Added_By_Name"].ToString(),
                                    infoLinkstatus = gen.sqlDataReader["Status"].ToString(),
                                    infoLinkDate = gen.sqlDataReader["Added_Date"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                infoLinkList.Add(new InfoLinksModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                infoLinkList.Add(new InfoLinksModel
                {
                    error = "Error"
                });
            }
            return infoLinkList;
        }

        public bool AddInfoLinks(InfoLinksModel infoLinkDetails)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {               
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (infoLinkDetails.infoLinkId == "" || infoLinkDetails.infoLinkId == null) // New InfoLink
                    {
                        gen.queryString = "IF NOT EXISTS(SELECT Info_Links_Id FROM [ReachHelp].[dbo].[Info_Links] WHERE [Title]=@infoLinkTitle) INSERT INTO [ReachHelp].[dbo].[Info_Links]([Title],[URL],[Status],[Added_By]) VALUES(@infoLinkTitle,@infoLinkUrl,'Active',@infoLinkAddedBy)";
                    }
                    else
                    {
                        gen.queryString = "UPDATE [ReachHelp].[dbo].[Info_Links] SET [Title]=@infoLinkTitle,[URL]=@infoLinkUrl,[Status]=@infoStatus WHERE [Info_Links_Id]=@infoLinkId";
                    }
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        if (infoLinkDetails.infoLinkId == "" || infoLinkDetails.infoLinkId == null) // New InfoLink
                        {
                            gen.sqlCommand.Parameters.AddWithValue("@infoLinkTitle", infoLinkDetails.infoLinkTitle);
                            gen.sqlCommand.Parameters.AddWithValue("@infoLinkUrl", infoLinkDetails.infoLinkUrl);
                            gen.sqlCommand.Parameters.AddWithValue("@infoStatus", infoLinkDetails.infoLinkstatus);
                            gen.sqlCommand.Parameters.AddWithValue("@infoLinkAddedBy", infoLinkDetails.infoLinkAddedById);
                        }
                        else
                        {
                            gen.sqlCommand.Parameters.AddWithValue("@infoLinkId", infoLinkDetails.infoLinkId);
                            gen.sqlCommand.Parameters.AddWithValue("@infoLinkTitle", infoLinkDetails.infoLinkTitle);
                            gen.sqlCommand.Parameters.AddWithValue("@infoLinkUrl", infoLinkDetails.infoLinkUrl);
                            gen.sqlCommand.Parameters.AddWithValue("@infoStatus", infoLinkDetails.infoLinkstatus);
                        }
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
    }
}
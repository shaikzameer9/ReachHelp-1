using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace ReachHelpWF.Models
{
    public class RolesModel
    {
        public string roleId { get; set; }
        public string roleName { get; set; }
        public string roleStatus { get; set; }
        public string error { get; set; }

        public List<RolesModel> ListUserRoles()
        {
            List<RolesModel> userRoles = new List<RolesModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT Role_Id,Role_Name,[Status] FROM [ReachHelp].[dbo].[Role_Master]";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {                       
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                userRoles.Add(new RolesModel
                                {
                                    roleId = gen.sqlDataReader["Role_Id"].ToString(),
                                    roleName = gen.sqlDataReader["Role_Name"].ToString(),
                                    roleStatus = gen.sqlDataReader["Status"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                userRoles.Add(new RolesModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                userRoles.Add(new RolesModel
                {
                    error = "Error"
                });
            }
            return userRoles;
        }
    }
}
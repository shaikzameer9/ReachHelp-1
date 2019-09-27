using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace ReachHelpWF.Models
{
    public class UnitModel
    {
        public string unitId { get; set; }
        public string unitName { get; set; }
        public string error { get; set; }
        public string subCategoryId { get; set; }

        public List<UnitModel> GetUnitsForSubCategory(string subCategoryId)
        {
            List<UnitModel> unitList = new List<UnitModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT UM.Unit_Id,UM.Unit_Name FROM [ReachHelp].[dbo].[Sub_Category_Master] SCM JOIN [ReachHelp].[dbo].[Sub_Category_Unit_Mapping] SCU ON SCM.Sub_Category_Id=SCU.Sub_Category_Id JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = SCU.Unit_Id WHERE SCM.Sub_Category_Id=@subCategoryId";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", subCategoryId);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                unitList.Add(new UnitModel
                                {
                                    unitId = gen.sqlDataReader["Unit_Id"].ToString(),
                                    unitName = gen.sqlDataReader["Unit_Name"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                unitList.Add(new UnitModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                unitList.Add(new UnitModel
                {
                    error = "Error"
                });
            }
            return unitList;
        }

        public bool ConfigureUnits(UnitModel unitConfig)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {                
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "IF NOT EXISTS(SELECT Mapping_Id FROM [ReachHelp].[dbo].[Sub_Category_Unit_Mapping] WHERE Sub_Category_Id=@subCategoryId AND Unit_Id=@unitId) INSERT INTO [ReachHelp].[dbo].[Sub_Category_Unit_Mapping] VALUES(@subCategoryId,@unitId)";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", unitConfig.subCategoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@unitId", unitConfig.unitId);
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

        public List<UnitModel> GetAllUnits()
        {
            List<UnitModel> unitList = new List<UnitModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT Unit_Id,Unit_Name FROM [ReachHelp].[dbo].[Unit_Master] ORDER BY Unit_Id";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        //gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", subCategoryId);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                unitList.Add(new UnitModel
                                {
                                    unitId = gen.sqlDataReader["Unit_Id"].ToString(),
                                    unitName = gen.sqlDataReader["Unit_Name"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                unitList.Add(new UnitModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                unitList.Add(new UnitModel
                {
                    error = "Error"
                });
            }
            return unitList;
        }

        public bool AddUpdateUnitForAdmin(UnitModel unitConfig) {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (unitConfig.unitId == "" || unitConfig.unitId == null)
                    {
                        gen.queryString = "IF NOT EXISTS(SELECT [Unit_Name] FROM [ReachHelp].[dbo].[Unit_Master] WHERE Unit_Name=@unitName) INSERT INTO [ReachHelp].[dbo].[Unit_Master] VALUES(@unitName)";
                    }
                    else
                    {
                        gen.queryString = "IF EXISTS(SELECT [Unit_Name] FROM [ReachHelp].[dbo].[Unit_Master] WHERE Unit_Id=@unitId) UPDATE [ReachHelp].[dbo].[Unit_Master] SET Unit_Name = @unitName WHERE Unit_Id = @unitId";
                    }
                    
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        if (unitConfig.unitId != null)
                        {
                            gen.sqlCommand.Parameters.AddWithValue("@unitId", unitConfig.unitId);
                        }
                        gen.sqlCommand.Parameters.AddWithValue("@unitName", unitConfig.unitName);
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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Collections;

namespace ReachHelpWF.Models
{
    public class SubCategory
    {
        public string subCategoryId { get; set; }
        public string subCategoryName { get; set; }
    }
    public class CategoryModel 
    {
        public string categoryId { get; set; }
        public string categoryName { get; set; }
        public string subCategoryId { get; set; }
        public string categoryStatus { get; set; }
        public string subCategoryName { get; set; }
        public string subCategoryStatus { get; set; }
        public string measurable { get; set; }
        public string units { get; set; }
        public string error { get; set; }
        public List<SubCategory> subCategoryList = new List<SubCategory>();
        public string count { get; set; }

        public List<CategoryModel> ListCategoryForUser(string languageId)
        {
            List<CategoryModel> categoryList = new List<CategoryModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT Category_Id,CASE WHEN LD1.Word IS NULL THEN Category_Name ELSE LD1.Word END AS Category_Name FROM [ReachHelp].[dbo].Category_Master CM LEFT JOIN [ReachHelp].[dbo].[Language_Dictionary] LD ON LD.Word = CM.Category_Name	LEFT JOIN [ReachHelp].[dbo].[Language_Dictionary] LD1 ON LD1.Map_Id = LD.Map_Id AND LD1.Language_Id=@languageId WHERE CM.[Status]='Active' ORDER BY Category_Id ";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@languageId", languageId);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                categoryList.Add(new CategoryModel
                                {
                                    categoryId = gen.sqlDataReader["Category_Id"].ToString(),
                                    categoryName = gen.sqlDataReader["Category_Name"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                categoryList.Add(new CategoryModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                categoryList.Add(new CategoryModel
                {
                    error = "Error"
                });
            }
            return categoryList;
        }

        public List<CategoryModel> ListCategoryForAdmin(int startValue, int noOfRows)
        {
            List<CategoryModel> categoryList = new List<CategoryModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT [Category_Id],[Category_Name],[Status],COUNT(Category_Id) OVER (PARTITION BY 1) AS Count FROM [ReachHelp].[dbo].[Category_Master]";

                    if (noOfRows > 0)
                    {
                        gen.queryString += " ORDER BY Category_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY";
                    }

                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@noOfRows", noOfRows);

                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                categoryList.Add(new CategoryModel
                                {
                                    categoryId = gen.sqlDataReader["Category_Id"].ToString(),
                                    categoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    categoryStatus = gen.sqlDataReader["Status"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                categoryList.Add(new CategoryModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                categoryList.Add(new CategoryModel
                {
                    error = "Error"
                });
            }
            return categoryList;
        }

        public List<CategoryModel> GetSubCategoryForAdmin(int startValue, int noOfRows)
        {
            List<CategoryModel> subCategoryList = new List<CategoryModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    //gen.queryString = " SELECT DISTINCT SCM.Sub_Category_Id,Sub_Category_Name,CM.Category_Id,CM.Category_Name, STUFF ((SELECT ','+UM1.Unit_Name  FROM Sub_Category_Master SCM1 JOIN Category_Master CM ON CM.Category_Id = SCM1.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Unit_Mapping] SCU ON SCU.Sub_Category_Id = SCM1.Sub_Category_Id 	JOIN [ReachHelp].[dbo].[Unit_Master] UM1 ON UM1.Unit_Id = SCU.Unit_Id WHERE SCM1.Sub_Category_Id = SCM.Sub_Category_Id FOR XML PATH ('')),1,1,'') Units, SCM.Status  FROM Sub_Category_Master SCM JOIN Category_Master CM ON CM.Category_Id = SCM.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Unit_Mapping] SCU ON SCU.Sub_Category_Id = SCM.Sub_Category_Id 	JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = SCU.Unit_Id ";
                    //gen.queryString = "SELECT Sub_Category_Id,Sub_Category_Name,CM.Category_Id,CM.Category_Name,SCM.Status FROM Sub_Category_Master SCM JOIN Category_Master CM ON CM.Category_Id = SCM.Category_Id";
                    gen.queryString = "SELECT DISTINCT SCM.Sub_Category_Id,Sub_Category_Name,CM.Category_Id,CM.Category_Name,SCM.Measurable, STUFF ((SELECT ','+UM1.Unit_Name FROM Sub_Category_Master SCM1 JOIN Category_Master CM ON CM.Category_Id = SCM1.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Unit_Mapping] SCU ON SCU.Sub_Category_Id = SCM1.Sub_Category_Id 	JOIN [ReachHelp].[dbo].[Unit_Master] UM1 ON UM1.Unit_Id = SCU.Unit_Id WHERE SCM1.Sub_Category_Id = SCM.Sub_Category_Id FOR XML PATH ('')),1,1,'') Units, SCM.Status,COUNT(SCM.Sub_Category_Id) OVER (PARTITION BY 1) AS Count  FROM Sub_Category_Master SCM JOIN Category_Master CM ON CM.Category_Id = SCM.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Unit_Mapping] SCU ON SCU.Sub_Category_Id = SCM.Sub_Category_Id 	JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id = SCU.Unit_Id ORDER BY SCM.Sub_Category_Id DESC OFFSET @startValue ROWS FETCH NEXT @noOfRows ROWS ONLY";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        //gen.sqlCommand.Parameters.AddWithValue("@categoryId", categoryId);

                        gen.sqlCommand.Parameters.AddWithValue("@startValue", startValue);
                        gen.sqlCommand.Parameters.AddWithValue("@noOfRows", noOfRows);

                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                subCategoryList.Add(new CategoryModel
                                {
                                    subCategoryId = gen.sqlDataReader["Sub_Category_Id"].ToString(),
                                    subCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    categoryId = gen.sqlDataReader["Category_Id"].ToString(),
                                    categoryName = gen.sqlDataReader["Category_Name"].ToString(),
                                    units = gen.sqlDataReader["Units"].ToString(),
                                    measurable = gen.sqlDataReader["Measurable"].ToString(),
                                    subCategoryStatus = gen.sqlDataReader["Status"].ToString(),
                                    count = gen.sqlDataReader["Count"].ToString(),
                                    error = ""
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                subCategoryList.Add(new CategoryModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                subCategoryList.Add(new CategoryModel
                {
                    error = "Error"
                });
            }
            return subCategoryList;
        }

        public List<CategoryModel> GetSubCategoryForUser(string categoryId,string languageId)
        {
            List<CategoryModel> subCategoryList = new List<CategoryModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    //gen.queryString = "SELECT Sub_Category_Id,CASE WHEN LD1.Word IS NULL THEN Sub_Category_Name ELSE LD1.Word END AS Sub_Category_Name FROM [ReachHelp].[dbo].Sub_Category_Master SCM JOIN [ReachHelp].[dbo].[Language_Dictionary] LD ON LD.Word = SCM.Category_Name	LEFT JOIN [ReachHelp].[dbo].[Language_Dictionary] LD1 ON LD1.Map_Id = LD.Map_Id AND LD1.Language_Id=@languageId WHERE SCM.[Status]='Active' ORDER BY Category_Id ";
                    gen.queryString = "SELECT Sub_Category_Id,CASE WHEN LD1.Word IS NULL THEN Sub_Category_Name ELSE LD1.Word END AS Sub_Category_Name,Measurable FROM [ReachHelp].[dbo].Sub_Category_Master SCM JOIN [ReachHelp].[dbo].[Language_Dictionary] LD ON LD.Word = SCM.Sub_Category_Name	LEFT JOIN [ReachHelp].[dbo].[Language_Dictionary] LD1 ON LD1.Map_Id = LD.Map_Id AND LD1.Language_Id=@languageId WHERE SCM.[Status]='Active' AND Category_Id =@categoryId ORDER BY Category_Id ";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@categoryId", categoryId);
                        gen.sqlCommand.Parameters.AddWithValue("@languageId", languageId);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                subCategoryList.Add(new CategoryModel
                                {
                                    subCategoryId = gen.sqlDataReader["Sub_Category_Id"].ToString(),
                                    subCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                    measurable = gen.sqlDataReader["Measurable"].ToString(),
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                subCategoryList.Add(new CategoryModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                subCategoryList.Add(new CategoryModel
                {
                    error = "Error"
                });
            }
            return subCategoryList;
        }        

        public bool AddCategory(CategoryModel categoryDetails)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                if (categoryDetails.categoryId == "" || categoryDetails.categoryId == null) // A new Category
                {
                    gen.queryString = "IF NOT EXISTS (SELECT Category_Id FROM [ReachHelp].[dbo].[Category_Master] WHERE Category_Name=@categoryName) INSERT INTO [ReachHelp].[dbo].[Category_Master](Category_Name,Status) VALUES(@categoryName,'Active')";
                }
                else //Update a category
                {
                    gen.queryString = "UPDATE [ReachHelp].[dbo].[Category_Master] SET Category_Name=@categoryName,[Status]=@categoryStatus WHERE Category_Id=@categoryId";
                }
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        if (categoryDetails.categoryId == "" || categoryDetails.categoryId == null) // A new Category
                        {
                            gen.sqlCommand.Parameters.AddWithValue("@categoryName", categoryDetails.categoryName);
                            gen.sqlCommand.Parameters.AddWithValue("@categoryStatus", categoryDetails.categoryStatus);
                        }
                        else
                        {
                            gen.sqlCommand.Parameters.AddWithValue("@categoryId", categoryDetails.categoryId);
                            gen.sqlCommand.Parameters.AddWithValue("@categoryName", categoryDetails.categoryName);
                            gen.sqlCommand.Parameters.AddWithValue("@categoryStatus", categoryDetails.categoryStatus);
                        }
                        
                        LanguageModel addLanguage = new LanguageModel();
                        addLanguage.AddEnglishWords(categoryDetails.categoryName);
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

        public bool AddSubCategory(CategoryModel subCategoryDetails)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                if (subCategoryDetails.subCategoryId == "" || subCategoryDetails.subCategoryId == null) // A new sub Category
                {
                    gen.queryString = "DECLARE @subCategoryId INT IF NOT EXISTS (SELECT Sub_Category_Id FROM [ReachHelp].[dbo].[Sub_Category_Master]  WHERE Sub_Category_Name=@subCategoryName AND Category_Id=@categoryId)  BEGIN INSERT INTO [ReachHelp].[dbo].[Sub_Category_Master] VALUES(@subcategoryName,@categoryId,@measurable,'Active') SELECT @subCategoryId=SCOPE_IDENTITY() INSERT INTO [ReachHelp].[dbo].[Sub_Category_Unit_Mapping] SELECT @subCategoryId,CAST(TT.VALUE AS INT) FROM [dbo].[udf_split_first_delimiter_and_groupthem](@units,',') TT END";
                }
                else //Update a sub category
                {
                    //gen.queryString = "IF EXISTS (SELECT Sub_Category_Id FROM [ReachHelp].[dbo].[Sub_Category_Master] WHERE Sub_Category_Name=@subCategoryName AND Category_Id=@categoryId) UPDATE [ReachHelp].[dbo].[Sub_Category_Master] SET Sub_Category_Name=@subCategoryName,Category_Id=@categoryId,[Status]=@subCategoryStatus WHERE Sub_Category_Id=@subCategoryId";
                    gen.queryString = "DECLARE @count INT,@counter INT=1,@unitId INT; DECLARE @tempTable TABLE(Id INT IDENTITY(1,1),Unit_Id INT); IF EXISTS (SELECT Sub_Category_Id FROM [ReachHelp].[dbo].[Sub_Category_Master] WHERE  Category_Id=@categoryId)  UPDATE [ReachHelp].[dbo].[Sub_Category_Master] SET Sub_Category_Name=@subCategoryName,Category_Id=@categoryId,[Measurable]=@measurable,[Status]=@subCategoryStatus 	WHERE Sub_Category_Id=@subCategoryId; 	SELECT @count=COUNT(TT.VALUE) FROM [ReachHelp].[dbo].[udf_split_first_delimiter_and_groupthem](@units,',') TT; 	INSERT INTO @tempTable SELECT TT.VALUE FROM [ReachHelp].[dbo].[udf_split_first_delimiter_and_groupthem](@units,',') TT; WHILE(@counter<=@count) BEGIN	SELECT @unitId = TT.Unit_Id FROM @tempTable TT WHERE Id=@counter; 				IF NOT EXISTS (SELECT mapping_id FROM [ReachHelp].[dbo].[Sub_Category_Unit_Mapping] SCM  WHERE Sub_Category_Id=@subCategoryId AND Unit_Id=@unitId) 	INSERT INTO [ReachHelp].[dbo].[Sub_Category_Unit_Mapping] VALUES(@subCategoryId,@unitId); SET @counter=@counter+1;END";
                }
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        if (subCategoryDetails.subCategoryId == "" || subCategoryDetails.subCategoryId == null)
                        {
                            gen.sqlCommand.Parameters.AddWithValue("@subCategoryName", subCategoryDetails.subCategoryName);
                            gen.sqlCommand.Parameters.AddWithValue("@subCategoryStatus", subCategoryDetails.subCategoryStatus);
                            gen.sqlCommand.Parameters.AddWithValue("@categoryId", subCategoryDetails.categoryId);
                            gen.sqlCommand.Parameters.AddWithValue("@units", subCategoryDetails.units);
                            gen.sqlCommand.Parameters.AddWithValue("@measurable", subCategoryDetails.measurable);
                        }
                        else
                        {
                            gen.sqlCommand.Parameters.AddWithValue("@subCategoryId", subCategoryDetails.subCategoryId);
                            gen.sqlCommand.Parameters.AddWithValue("@subCategoryName", subCategoryDetails.subCategoryName);
                            gen.sqlCommand.Parameters.AddWithValue("@subCategoryStatus", subCategoryDetails.subCategoryStatus);
                            gen.sqlCommand.Parameters.AddWithValue("@units", subCategoryDetails.units);
                            gen.sqlCommand.Parameters.AddWithValue("@categoryId", subCategoryDetails.categoryId);
                            gen.sqlCommand.Parameters.AddWithValue("@measurable", subCategoryDetails.measurable);

                        }
                        LanguageModel addLanguage = new LanguageModel();
                        addLanguage.AddEnglishWords(subCategoryDetails.subCategoryName);
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

        public List<CategoryModel> ListCategoryAndSubCategory()
        {
           // Hashtable category = new Hashtable();
            List<CategoryModel> categoryList = new List<CategoryModel>();           
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT CM.Category_Id,CM.Category_Name,SCM.Sub_Category_Id,SCM.Sub_Category_Name FROM [ReachHelp].[dbo].[Category_Master] CM JOIN [ReachHelp].[dbo].[Sub_Category_Master] SCM ON SCM.Category_Id=CM.Category_Id WHERE SCM.Status='Active' AND CM.Status='Active' ORDER BY CM.Category_Id";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {                        
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            int index =-1;
                            while (gen.sqlDataReader.Read())
                            {
                                if (!Array.Exists(categoryList.ToArray(), category => category.categoryName == gen.sqlDataReader["Category_Name"].ToString()))
                                {
                                    index++;
                                    categoryList.Add(new CategoryModel
                                    {
                                        categoryId = gen.sqlDataReader["Category_Id"].ToString(),
                                        categoryName = gen.sqlDataReader["Category_Name"].ToString()
                                    });
                                    
                                }                               
                                    
                                categoryList[index].subCategoryList.Add(new SubCategory
                                {
                                    subCategoryId = gen.sqlDataReader["Sub_Category_Id"].ToString(),
                                    subCategoryName = gen.sqlDataReader["Sub_Category_Name"].ToString()
                                });                                  
                                                                
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                categoryList.Add(new CategoryModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                categoryList.Add(new CategoryModel
                {
                    error = "Error"
                });
            }
            return categoryList;
        }


    }

       
}
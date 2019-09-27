using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;


namespace ReachHelpWF.Models
{
    public class LanguageModel
    {
        public string languageId { get; set; }
        public string languageName { get; set; }
        public string englishWord { get; set; }
        public string languageWord { get; set; }
        public string mapId { get; set; }
        public string error { get; set; }

        public List<LanguageModel> ListLanguages()
        {
            GenericInitialization gen = new GenericInitialization();
            List<LanguageModel> languages = new List<LanguageModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT DISTINCT LM.Language_Id, Language_Name FROM [ReachHelp].[dbo].[Language_Master] LM JOIN [ReachHelp].[dbo].[Language_Dictionary] LD ON LD.Language_Id = LM.Language_Id";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                languages.Add(new LanguageModel
                                {
                                    languageId = gen.sqlDataReader["Language_Id"].ToString(),
                                    languageName = gen.sqlDataReader["Language_Name"].ToString()
                                });
                            }
                        }
                    }

                }
            }
            catch (SqlException ex)
            {
                languages.Add(new LanguageModel
                {
                   error = "Error"
                });
            }
            catch (Exception ex)
            {
                languages.Add(new LanguageModel
                {
                    error = "Error"
                });
            }
            return languages;
        }

        public List<LanguageModel> ListLanguagesForAdmin()
        {
            GenericInitialization gen = new GenericInitialization();
            List<LanguageModel> languages = new List<LanguageModel>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT Language_Id, Language_Name FROM [ReachHelp].[dbo].[Language_Master]";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while (gen.sqlDataReader.Read())
                            {
                                languages.Add(new LanguageModel
                                {
                                    languageId = gen.sqlDataReader["Language_Id"].ToString(),
                                    languageName = gen.sqlDataReader["Language_Name"].ToString()
                                });
                            }
                        }
                    }

                }
            }
            catch (SqlException ex)
            {
                languages.Add(new LanguageModel
                {
                    error = "Error"
                });
            }
            catch (Exception ex)
            {
                languages.Add(new LanguageModel
                {
                    error = "Error"
                });
            }
            return languages;
        }

        public bool AddLanguage(string languageName,string languageId)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (languageId == "") //new Language
                    {
                        gen.queryString = "IF NOT EXISTS(SELECT Language_Id FROM [ReachHelp].[dbo].Language_Master WHERE Language_Name=@languageName) INSERT INTO [ReachHelp].[dbo].[Language_Master] VALUES(@languageName)";
                    }
                    else
                    {
                        gen.queryString = "UPDATE [ReachHelp].[dbo].Language_Master SET Language_Name=@languageName WHERE Language_Id=@languageId";
                    }
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@languageName", languageName);
                        if (languageId != "")
                        {
                            gen.sqlCommand.Parameters.AddWithValue("@languageId", languageId);
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

        public bool LanguageTranslation(string englishWord, string languageId, string languageWord)
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "DECLARE @mapId INT;IF NOT EXISTS(SELECT Id FROM [ReachHelp].[dbo].[Language_Dictionary] WHERE Word=@englishWord) BEGIN INSERT INTO [ReachHelp].[dbo].[Language_Dictionary](Word,Language_Id,Map_Id) SELECT @englishWord,1,CASE WHEN MAX(Map_Id) IS NULL THEN 1 ELSE MAX(Map_Id)+1 END FROM [ReachHelp].[dbo].[Language_Dictionary] SELECT @mapId = Map_Id FROM [ReachHelp].[dbo].[Language_Dictionary] WHERE Word=@englishWord  INSERT INTO [ReachHelp].[dbo].[Language_Dictionary] VALUES(@languageWord,@languageId,@mapId)END ELSE BEGIN IF NOT EXISTS(SELECT Id FROM [ReachHelp].[dbo].[Language_Dictionary] WHERE Word=@languageWord AND Language_Id=@languageId)BEGIN	 SELECT @mapId = Map_Id FROM [ReachHelp].[dbo].[Language_Dictionary] WHERE Word=@englishWord  INSERT INTO [ReachHelp].[dbo].[Language_Dictionary] VALUES(@languageWord,@languageId,@mapId) END END";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@englishWord", englishWord);
                        gen.sqlCommand.Parameters.AddWithValue("@languageId", languageId);
                        gen.sqlCommand.Parameters.Add("@languageWord", SqlDbType.NVarChar, 80).Value = languageWord;
                        //gen.sqlCommand.Parameters.AddWithValue("@languageWord", languageWord);
                        if (gen.sqlCommand.ExecuteNonQuery() > 0)
                        {
                            return true;
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
            return false;
        }

        public bool AddEnglishWords(string englishWord)
        {
            GenericInitialization gen = new GenericInitialization();            
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "IF NOT EXISTS(SELECT Id FROM [ReachHelp].[dbo].[Language_Dictionary] WHERE Word=@englishWord)INSERT INTO [ReachHelp].[dbo].[Language_Dictionary](Word,Language_Id,Map_Id)SELECT @englishWord,1,CASE WHEN MAX(Map_Id) IS NULL THEN 1 ELSE MAX(Map_Id)+1 END FROM [ReachHelp].[dbo].[Language_Dictionary]";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@englishWord", englishWord);
                        if (gen.sqlCommand.ExecuteNonQuery() > 0)
                        {
                            return true;
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
            return false;
        }

        public List<LanguageModel> ListLanguageWords(string languageId)
        {
            List<LanguageModel> listLanguage = new List<LanguageModel>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT LD.Map_Id,LD.Word English,LD1.Word [Language] FROM [ReachHelp].[dbo].[Language_Dictionary] LD JOIN [ReachHelp].[dbo].[Language_Dictionary] LD1 ON LD.Map_Id = LD1.Map_Id AND LD.Language_Id=1 WHERE LD1.Language_Id=@languageId";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@languageId", languageId);
                        using(gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            while(gen.sqlDataReader.Read())
                            {
                                listLanguage.Add(new LanguageModel
                                {
                                    englishWord = gen.sqlDataReader["English"].ToString(),
                                    languageWord = gen.sqlDataReader["Language"].ToString(),
                                    mapId = gen.sqlDataReader["Map_Id"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                listLanguage.Add(new LanguageModel
                {
                   error = "Error"
                });
            }
            catch (Exception ex)
            {
                listLanguage.Add(new LanguageModel
                {
                   error = "Error"
                });
            }
            return listLanguage;
        }
    }
}
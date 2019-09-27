using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using ReachHelpWF.Interfaces;

namespace ReachHelpWF.Models
{
    public class IndicatorsModel : IVolume, ILatency, IRatings
    {
        public Int64 NetValue { get; set; }
        public string error { get; set; }
        public UInt64 DonatedValue()
        {
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT SUM(Amount) AS Total_Sum FROM [ReachHelp].[dbo].[Donations] WHERE Status='Success'";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    return UInt64.Parse(gen.sqlDataReader["Total_Sum"].ToString()); //Total Sum
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return 0; //Error
            }
            catch (Exception ex)
            {
                return 0;      //Error            
            }
            return 0; // No Value
        }

        public UInt16 days { get; set; }
        public UInt16 hours { get; set; }
        public UInt16 minutes { get; set; }
        public UInt16 seconds { get; set; }
        public UInt16 number { get; set; }
        public double ratingCount { get; set; }
        public int quantity { get; set; }
        public string category { get; set; }
        public string subCategory { get; set; }
        public string unit { get; set; }

        public IndicatorsModel()
        {
            this.days = 0;
            this.hours = 0;
            this.minutes = 0;
            this.seconds = 0;
            this.ratingCount = 0;
        }

        public ILatency AverageLatency(bool prevMonth)
        {
            GenericInitialization gen = new GenericInitialization();
            IndicatorsModel avgLatency = new IndicatorsModel();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (prevMonth == true)
                        gen.queryString = "SELECT  AVG(DateDiff(s, Requested_Date, Confirmed_Date)/86400) as [Average_Days],AVG(DateDiff(s, Requested_Date,Confirmed_Date)%86400/3600) as [Average_Hours], AVG(DateDiff(s,Requested_Date,Confirmed_Date)%3600/60)as [Average_Minutes],AVG((DateDiff(s, Requested_Date, Confirmed_Date)%60)) as [Average_Seconds] FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM  WHERE Confirmed_Date IS NOT NULL AND DATEPART(m, Confirmed_Date) = DATEPART(m, DATEADD(m, -1, getdate())) AND DATEPART(yyyy, Confirmed_Date) = DATEPART(yyyy, DATEADD(m, -1, getdate()))";
                    else
                        gen.queryString = "SELECT  AVG(DateDiff(s, Requested_Date, Confirmed_Date)/86400) as [Average_Days],AVG(DateDiff(s, Requested_Date,Confirmed_Date)%86400/3600) as [Average_Hours], AVG(DateDiff(s,Requested_Date,Confirmed_Date)%3600/60)as [Average_Minutes],AVG((DateDiff(s, Requested_Date, Confirmed_Date)%60)) as [Average_Seconds] FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM  WHERE Confirmed_Date IS NOT NULL";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    avgLatency.days = UInt16.Parse(gen.sqlDataReader["Average_Days"].ToString());
                                    avgLatency.hours = UInt16.Parse(gen.sqlDataReader["Average_Hours"].ToString());
                                    avgLatency.minutes = UInt16.Parse(gen.sqlDataReader["Average_Minutes"].ToString());
                                    avgLatency.seconds = UInt16.Parse(gen.sqlDataReader["Average_Seconds"].ToString());
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return avgLatency; //Error
            }
            catch (Exception ex)
            {
                return avgLatency;      //Error            
            }
            return avgLatency; // No Value
        }

        public ILatency TotalLatency(bool prevMonth)
        {
            GenericInitialization gen = new GenericInitialization();
            IndicatorsModel avgLatency = new IndicatorsModel();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (prevMonth == false)
                        gen.queryString = "SELECT  SUM(DateDiff(s, Requested_Date, Confirmed_Date)/86400) as [Total_Days],SUM(DateDiff(s, Requested_Date,Confirmed_Date)%86400/3600) as [Total_Hours],SUM(DateDiff(s,Requested_Date,Confirmed_Date)%3600/60)as [Total_Minutes],SUM((DateDiff(s, Requested_Date, Confirmed_Date)%60)) as [Total_Seconds] FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM WHERE Confirmed_Date IS NOT NULL";
                    else
                        gen.queryString = "SELECT  SUM(DateDiff(s, Requested_Date, Confirmed_Date)/86400) as [Total_Days],SUM(DateDiff(s, Requested_Date,Confirmed_Date)%86400/3600) as [Total_Hours],SUM(DateDiff(s,Requested_Date,Confirmed_Date)%3600/60)as [Total_Minutes],SUM((DateDiff(s, Requested_Date, Confirmed_Date)%60)) as [Total_Seconds] FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM WHERE Confirmed_Date IS NOT NULL AND DATEPART(m, Confirmed_Date) = DATEPART(m, DATEADD(m, -1, getdate())) AND DATEPART(yyyy, Confirmed_Date) = DATEPART(yyyy, DATEADD(m, -1, getdate()))";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    avgLatency.days = UInt16.Parse(gen.sqlDataReader["Total_Days"].ToString());
                                    avgLatency.hours = UInt16.Parse(gen.sqlDataReader["Total_Hours"].ToString());
                                    avgLatency.minutes = UInt16.Parse(gen.sqlDataReader["Total_Minutes"].ToString());
                                    avgLatency.seconds = UInt16.Parse(gen.sqlDataReader["Total_Seconds"].ToString());
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return avgLatency; //Error
            }
            catch (Exception ex)
            {
                return avgLatency;      //Error            
            }
            return avgLatency; // No Value
        }

        public IRatings Ratings(bool prevMonth)
        {
            GenericInitialization gen = new GenericInitialization();
            IndicatorsModel ratings = new IndicatorsModel();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (prevMonth == false)
                        gen.queryString = "SELECT AVG(Rating) AS Rating FROM [ReachHelp].[dbo].[Offer_Request_Mapping] WHERE [Status]='Accepted'";
                    else
                        gen.queryString = "SELECT AVG(Rating) AS Rating FROM [ReachHelp].[dbo].[Offer_Request_Mapping] WHERE [Status]='Accepted' AND DATEPART(m, Confirmed_Date) = DATEPART(m, DATEADD(m, -1, getdate())) AND DATEPART(yyyy, Confirmed_Date) = DATEPART(yyyy, DATEADD(m, -1, getdate()))";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    ratings.ratingCount = float.Parse(gen.sqlDataReader["Rating"].ToString());
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return ratings; //Error
            }
            catch (Exception ex)
            {
                return ratings;      //Error            
            }
            return ratings; // No Value
        }

        public List<IVolume> ReceivedVolume(bool prevMonth)
        {
            GenericInitialization gen = new GenericInitialization();
            List<IVolume> ratings = new List<IVolume>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if(prevMonth == true)
                        gen.queryString = "SELECT SUM(Responded_Quantity)Volume,Category_Name,Unit_Name,Sub_Category_Name FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=ORM.Responded_Unit JOIN [ReachHelp].[dbo].[My_Requests]MR ON MR.My_Request_Id=ORM.Request_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master]SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id  WHERE ORM.[Status]='Accepted' AND DATEPART(m, Confirmed_Date) = DATEPART(m, DATEADD(m, -1, getdate())) AND DATEPART(yyyy, Confirmed_Date) = DATEPART(yyyy, DATEADD(m, -1, getdate())) GROUP BY Sub_Category_Name,Unit_Name,Category_Name";
                    else
                        gen.queryString = "SELECT SUM(Responded_Quantity)Volume,Category_Name,Unit_Name,Sub_Category_Name FROM [ReachHelp].[dbo].[Offer_Request_Mapping] ORM JOIN [ReachHelp].[dbo].[Unit_Master] UM ON UM.Unit_Id=ORM.Responded_Unit JOIN [ReachHelp].[dbo].[My_Requests]MR ON MR.My_Request_Id=ORM.Request_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MR.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master]SCM ON SCM.Sub_Category_Id=MR.Sub_Category_Id  WHERE ORM.[Status]='Accepted' GROUP BY Sub_Category_Name,Unit_Name,Category_Name";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    ratings.Add(new IndicatorsModel
                                    {
                                        quantity = Int32.Parse(gen.sqlDataReader["Volume"].ToString()),
                                        category = gen.sqlDataReader["Category_Name"].ToString(),
                                        subCategory = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                        unit = gen.sqlDataReader["Unit_Name"].ToString()
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return ratings; //Error
            }
            catch (Exception ex)
            {
                return ratings;      //Error            
            }
            return ratings; // No Value
        }

        public List<IVolume> OfferedVolume(bool prevMonth)
        {
            GenericInitialization gen = new GenericInitialization();
            List<IVolume> ratings = new List<IVolume>();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (prevMonth == true)
                        gen.queryString = "SELECT SUM(Quantity)Volume,Category_Name,Unit_Name,Sub_Category_Name FROM [ReachHelp].[dbo].[My_Offers]MO JOIN [ReachHelp].[dbo].[Unit_Master]UM ON MO.Unit = UM.Unit_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master]SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id WHERE DATEPART(m, Posted_Date) = DATEPART(m, DATEADD(m, -1, getdate())) AND DATEPART(yyyy, Posted_Date) = DATEPART(yyyy, DATEADD(m, -1, getdate())) GROUP BY Sub_Category_Name,Unit_Name,Category_Name";
                    else
                        gen.queryString = "SELECT SUM(Quantity)Volume,Category_Name,Unit_Name,Sub_Category_Name FROM [ReachHelp].[dbo].[My_Offers]MO JOIN [ReachHelp].[dbo].[Unit_Master]UM ON MO.Unit = UM.Unit_Id JOIN [ReachHelp].[dbo].[Category_Master] CM ON CM.Category_Id=MO.Category_Id JOIN [ReachHelp].[dbo].[Sub_Category_Master]SCM ON SCM.Sub_Category_Id=MO.Sub_Category_Id GROUP BY Sub_Category_Name,Unit_Name,Category_Name";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    ratings.Add(new IndicatorsModel
                                    {
                                        quantity = Int32.Parse(gen.sqlDataReader["Volume"].ToString()),
                                        category = gen.sqlDataReader["Category_Name"].ToString(),
                                        subCategory = gen.sqlDataReader["Sub_Category_Name"].ToString(),
                                        unit = gen.sqlDataReader["Unit_Name"].ToString()
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return ratings; //Error
            }
            catch (Exception ex)
            {
                return ratings;      //Error            
            }
            return ratings; // No Value
        }

        public List<ILatency> DetailedTotalLatency(string startDate, string endDate, string type)
        {
            List<ILatency> latency = new List<ILatency>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (type == "Monthly")
                        gen.queryString = "SELECT  DATEPART(MONTH, Confirmed_Date) Number,SUM(DateDiff(s, Requested_Date, Confirmed_Date)/86400) as [Total_Days],SUM(DateDiff(s, Requested_Date,Confirmed_Date)%86400/3600) as [Total_Hours],SUM(DateDiff(s,Requested_Date,Confirmed_Date)%3600/60)as [Total_Minutes],SUM((DateDiff(s, Requested_Date, Confirmed_Date)%60)) as [Total_Seconds]FROM        [ReachHelp].[dbo].[Offer_Request_Mapping]WHERE Confirmed_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(MONTH, Confirmed_Date)";
                    else if (type == "Weekly")
                        gen.queryString = "SELECT  DATEPART(wk, Confirmed_Date) Number,SUM(DateDiff(s, Requested_Date, Confirmed_Date)/86400) as [Total_Days],SUM(DateDiff(s, Requested_Date,Confirmed_Date)%86400/3600) as [Total_Hours],SUM(DateDiff(s,Requested_Date,Confirmed_Date)%3600/60)as [Total_Minutes],SUM((DateDiff(s, Requested_Date, Confirmed_Date)%60)) as [Total_Seconds]FROM        [ReachHelp].[dbo].[Offer_Request_Mapping]WHERE Confirmed_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(wk, Confirmed_Date)";
                    else if (type == "Daily")
                        gen.queryString = "SELECT  DATEPART(DAY, Confirmed_Date) Number,SUM(DateDiff(s, Requested_Date, Confirmed_Date)/86400) as [Total_Days],SUM(DateDiff(s, Requested_Date,Confirmed_Date)%86400/3600) as [Total_Hours],SUM(DateDiff(s,Requested_Date,Confirmed_Date)%3600/60)as [Total_Minutes],SUM((DateDiff(s, Requested_Date, Confirmed_Date)%60)) as [Total_Seconds]FROM        [ReachHelp].[dbo].[Offer_Request_Mapping]WHERE Confirmed_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(DAY, Confirmed_Date)";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@startDate", startDate);
                        gen.sqlCommand.Parameters.AddWithValue("@endDate", endDate);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    latency.Add(new IndicatorsModel
                                    {
                                        number = UInt16.Parse(gen.sqlDataReader["Number"].ToString()),
                                        hours = UInt16.Parse(gen.sqlDataReader["Total_Hours"].ToString()),
                                        days = UInt16.Parse(gen.sqlDataReader["Total_Days"].ToString()),
                                        minutes = UInt16.Parse(gen.sqlDataReader["Total_Minutes"].ToString()),
                                        seconds = UInt16.Parse(gen.sqlDataReader["Total_Seconds"].ToString())
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return latency; //Error
            }
            catch (Exception ex)
            {
                return latency;      //Error            
            }
                

            return latency;
        }


        public List<ILatency> DetailedAverageLatency(string startDate, string endDate, string type)
        {
            List<ILatency> latency = new List<ILatency>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (type == "Monthly")
                        gen.queryString = "SELECT  DATEPART(MONTH, Confirmed_Date) Number,AVG(DateDiff(s, Requested_Date, Confirmed_Date)/86400) as [Total_Days],AVG(DateDiff(s, Requested_Date,Confirmed_Date)%86400/3600) as [Total_Hours],AVG(DateDiff(s,Requested_Date,Confirmed_Date)%3600/60)as [Total_Minutes],AVG((DateDiff(s, Requested_Date, Confirmed_Date)%60)) as [Total_Seconds],YEAR(Confirmed_Date) AS YEAR FROM        [ReachHelp].[dbo].[Offer_Request_Mapping]WHERE Confirmed_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(MONTH, Confirmed_Date),YEAR(Confirmed_Date)";
                    else if (type == "Weekly")
                        gen.queryString = "SELECT  DATEPART(wk, Confirmed_Date) Number,AVG(DateDiff(s, Requested_Date, Confirmed_Date)/86400) as [Total_Days],AVG(DateDiff(s, Requested_Date,Confirmed_Date)%86400/3600) as [Total_Hours],AVG(DateDiff(s,Requested_Date,Confirmed_Date)%3600/60)as [Total_Minutes],AVG((DateDiff(s, Requested_Date, Confirmed_Date)%60)) as [Total_Seconds],YEAR(Confirmed_Date) AS YEAR FROM  [ReachHelp].[dbo].[Offer_Request_Mapping]WHERE Confirmed_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(wk, Confirmed_Date),YEAR(Confirmed_Date)";
                    else if (type == "Daily")
                        gen.queryString = "SELECT  DATEPART(DAY, Confirmed_Date) Number,AVG(DateDiff(s, Requested_Date, Confirmed_Date)/86400) as [Total_Days],AVG(DateDiff(s, Requested_Date,Confirmed_Date)%86400/3600) as [Total_Hours],AVG(DateDiff(s,Requested_Date,Confirmed_Date)%3600/60)as [Total_Minutes],AVG((DateDiff(s, Requested_Date, Confirmed_Date)%60)) as [Total_Seconds],YEAR(Confirmed_Date) AS YEAR FROM        [ReachHelp].[dbo].[Offer_Request_Mapping]WHERE Confirmed_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(DAY, Confirmed_Date),YEAR(Confirmed_Date)";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@startDate", startDate);
                        gen.sqlCommand.Parameters.AddWithValue("@endDate", endDate);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    latency.Add(new IndicatorsModel
                                    {
                                        number = UInt16.Parse(gen.sqlDataReader["Number"].ToString()),
                                        hours = UInt16.Parse(gen.sqlDataReader["Total_Hours"].ToString()),
                                        days = UInt16.Parse(gen.sqlDataReader["Total_Days"].ToString()),
                                        minutes = UInt16.Parse(gen.sqlDataReader["Total_Minutes"].ToString()),
                                        seconds = UInt16.Parse(gen.sqlDataReader["Total_Seconds"].ToString())
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return latency; //Error
            }
            catch (Exception ex)
            {
                return latency;      //Error            
            }


            return latency;
        }

        public List<IRatings> DetailedRatings(string startDate, string endDate, string type)
        {
            List<IRatings> ratings = new List<IRatings>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (type == "Monthly")
                        gen.queryString = "SELECT DATEPART(MONTH, Confirmed_Date) Number,AVG(Rating) AS Rating,YEAR(Confirmed_Date) AS YEAR FROM [ReachHelp].[dbo].[Offer_Request_Mapping] WHERE [Status]='Accepted' AND Rating IS NOT NULL AND Confirmed_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(MONTH, Confirmed_Date),YEAR(Confirmed_Date) ";
                    else if (type == "Weekly")
                        gen.queryString = "SELECT DATEPART(WK, Confirmed_Date) Number,AVG(Rating) AS Rating,YEAR(Confirmed_Date) AS YEAR FROM [ReachHelp].[dbo].[Offer_Request_Mapping] WHERE [Status]='Accepted' AND Rating IS NOT NULL AND Confirmed_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(WK, Confirmed_Date),YEAR(Confirmed_Date)";
                    else if (type == "Daily")
                        gen.queryString = "SELECT DATEPART(DAY, Confirmed_Date) Number,AVG(Rating) AS Rating,YEAR(Confirmed_Date) AS YEAR FROM [ReachHelp].[dbo].[Offer_Request_Mapping] WHERE [Status]='Accepted' AND Rating IS NOT NULL AND Confirmed_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(DAY, Confirmed_Date),YEAR(Confirmed_Date) ";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@startDate", startDate);
                        gen.sqlCommand.Parameters.AddWithValue("@endDate", endDate);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    ratings.Add(new IndicatorsModel
                                    {
                                        number = UInt16.Parse(gen.sqlDataReader["Number"].ToString()),
                                        ratingCount = UInt16.Parse(gen.sqlDataReader["Rating"].ToString())
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return ratings; //Error
            }
            catch (Exception ex)
            {
                return ratings;      //Error            
            }
            return ratings;
        }

        public List<IDonations> DonationDetails(string startDate, string endDate, string type)
        {
            List<IDonations> donation = new List<IDonations>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (type == "Monthly")
                        gen.queryString = "  SELECT DATEPART(MONTH, Donation_Date) Number,SUM(Amount) AS Amount,YEAR(Donation_Date)  AS Year FROM [ReachHelp].[dbo].[Donations] WHERE [Status]='Accepted' AND Amount IS NOT NULLAND Donation_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(month, Donation_Date),YEAR(Donation_Date) ";
                    else if (type == "Weekly")
                        gen.queryString = "  SELECT DATEPART(WK, Donation_Date) Number,SUM(Amount) AS Amount,YEAR(Donation_Date)  AS Year FROM [ReachHelp].[dbo].[Donations] WHERE [Status]='Accepted' AND Amount IS NOT NULLAND Donation_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(WK, Donation_Date),YEAR(Donation_Date)";
                    else if (type == "Daily")
                        gen.queryString = "  SELECT DATEPART(DAY, Donation_Date) Number,SUM(Amount) AS Amount,YEAR(Donation_Date)  AS Year FROM [ReachHelp].[dbo].[Donations] WHERE [Status]='Accepted' AND Amount IS NOT NULLAND Donation_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY    DATEPART(DAY, Donation_Date),YEAR(Donation_Date)";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@startDate", startDate);
                        gen.sqlCommand.Parameters.AddWithValue("@endDate", endDate);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    donation.Add(new DonationModel
                                    {
                                        number = UInt16.Parse(gen.sqlDataReader["Number"].ToString()),
                                        amount = float.Parse(gen.sqlDataReader["Amount"].ToString())
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return donation; //Error
            }
            catch (Exception ex)
            {
                return donation;      //Error            
            }            
            return donation;
        }

        public List<IUsers> UserDetails(string startDate, string endDate, string type)
        {
            List<IUsers> users = new List<IUsers>();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    if (type == "Monthly")
                        gen.queryString = "SELECT DATEPART(MONTH, Registration_Date) Number,COUNT(User_Id) AS User_Count,YEAR(Registration_Date)  AS Year FROM [ReachHelp].[dbo].[User_Register] WHERE Registration_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY  DATEPART(MONTH, Registration_Date),YEAR(Registration_Date)";
                    else if (type == "Weekly")
                        gen.queryString = "SELECT DATEPART(WK, Registration_Date) Number,COUNT(User_Id) AS User_Count,YEAR(Registration_Date)  AS Year FROM [ReachHelp].[dbo].[User_Register] WHERE Registration_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY  DATEPART(WK, Registration_Date),YEAR(Registration_Date)";
                    else if (type == "Daily")
                        gen.queryString = "SELECT DATEPART(WK, Registration_Date) Number,COUNT(User_Id) AS User_Count,YEAR(Registration_Date)  AS Year FROM [ReachHelp].[dbo].[User_Register] WHERE Registration_Date BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)GROUP BY  DATEPART(WK, Registration_Date),YEAR(Registration_Date)";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {
                        gen.sqlCommand.Parameters.AddWithValue("@startDate", startDate);
                        gen.sqlCommand.Parameters.AddWithValue("@endDate", endDate);
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {
                                    users.Add(new UserModel
                                    {
                                        number = UInt16.Parse(gen.sqlDataReader["Number"].ToString()),
                                        userCount = UInt16.Parse(gen.sqlDataReader["User_Count"].ToString())
                                    });
                                }
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                return users; //Error
            }
            catch (Exception ex)
            {
                return users;      //Error            
            }
            return users;
        }

        public IUsers TotalUserCount()
        {
            UserModel user = new UserModel();
            GenericInitialization gen = new GenericInitialization();
            try
            {
                using (gen.sqlConnection = new SqlConnection(gen.connectionString))
                {
                    gen.sqlConnection.Open();
                    gen.queryString = "SELECT COUNT(User_Id)AS User_Count FROM [ReachHelp].[dbo].[User_Register]";
                    using (gen.sqlCommand = new SqlCommand(gen.queryString, gen.sqlConnection))
                    {                       
                        using (gen.sqlDataReader = gen.sqlCommand.ExecuteReader())
                        {
                            if (gen.sqlDataReader.HasRows)
                            {
                                while (gen.sqlDataReader.Read())
                                {                                    
                                    user.userCount = UInt16.Parse(gen.sqlDataReader["User_Count"].ToString());
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
  
    }
}
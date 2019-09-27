using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReachHelpWF.Models;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Drawing;

namespace ReachHelpWF
{
    public partial class Home : System.Web.UI.MasterPage
    {
        public string connString = ConfigurationManager.AppSettings["CONNECTION_STRING"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {
            //CategoryModel category = new CategoryModel();
            //category.ListCategoryAndSubCategory();
            /*if (Session["UserName"] != null)
            {
                string role = Session["UserRole"].ToString();

                switch (role)
                {
                    case "SysAdmin":
                        Response.Redirect("~/main/allUsers");
                        break;
                    case "Monitor":
                        Response.Redirect("~/main/reportsMonitor");
                        break;
                    case "User":
                        Response.Redirect("~/main/requestHelp");
                        break;
                }
            }*/

            if (!Page.IsPostBack)
            {
                Countrylist();
            }
        }


        public void forgotPass_Click(object sender, EventArgs e)
        {
            bool fpass = forgotPass(fsmobileno.Text);
            if (fpass)
            {
                fsmobileno.Text = "";
                forgotPassValidate.Text = "<span class='alert alert-success' style='padding:3px'>OTP sent Successfully! Please Check your Email/Cell for your OTP and login with same.</span>";
            }
            else
            {
                forgotPassValidate.Text = "<span class='alert alert-danger' style='padding:3px'>Cell No. not Registered.</span>";
            }
        }

        protected void fpass_check_mobile_Changed(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();

            string query = "";
            Regex regex = null;
            if (fsmobileno.Text.Contains("@"))
            {
                regex = new Regex(@"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
         @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
         @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");
                query = "select * from User_Register where Email_Id=@sphoneno";
            }
            else
            {
                regex = new Regex(@"\+?[0-9]{10}");
                query = "select * from User_Register where Phone_Number=@sphoneno";
            }

            //SqlCommand cmd = new SqlCommand("select * from User_Register where Phone_Number=@sphoneno", con);
            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@sphoneno", fsmobileno.Text);
            SqlDataReader dr = cmd.ExecuteReader();
            //Regex regex = new Regex(@"\+?[0-9]{10}");
            Match match = regex.Match(fsmobileno.Text);

            if (match.Success)
            {
                if (dr.Read())
                {
                    fpassmobilevalidate.Text = "<i class='fa fa-check'></i>Registered";
                    this.fpassmobilevalidate.ForeColor = Color.Green;

                }
                else
                {
                    fsmobileno.Text = "";
                    fpassmobilevalidate.Text = "<i class='fa fa-close'></i>Not Registered";
                    this.fpassmobilevalidate.ForeColor = Color.Red;
                }
            }
            else
            {

                fpassmobilevalidate.Text = "<i class='fa fa-close'></i>Enter Valid " + (fsmobileno.Text.Contains("@")?"Email":"Cell No.");
                this.fpassmobilevalidate.ForeColor = Color.Red;
            }
            con.Close();
        }

        public static bool forgotPass(string fpass)
        {
            UserModel userDetails = new UserModel();
            return userDetails.forgotUserPassword(fpass);
        }

        protected void login_Click(object sender, EventArgs e)
        {
            UserModel userLogin = Login(mobileno.Text, password.Text);
            if (userLogin.status == "Failed")
            {
                validation.Text = "<span class='alert alert-danger' style='padding:3px'>Invalid Cell no./Password</span>";
            }
            else
            {
                Session["UserName"] = userLogin.userName;
                Session["UserId"] = userLogin.userId;
                Session["AccountStatus"] = userLogin.status;

                switch (userLogin.roleName)
                {
                    case "SysAdmin":
                        Session["UserRole"] = "SysAdmin";
                        Response.Redirect("~/main/adminDash");
                        break;
                    case "Monitor":
                        Session["UserRole"] = "Monitor";
                        Response.Redirect("~/main/reportsMonitor");
                        break;
                    case "User":
                        Session["UserRole"] = "User";

                        if (userLogin.status == "New")
                        {
                            Response.Redirect("~/main/userProfile");
                        }
                        else if (userLogin.status == "Active")
                        {
                            if (Session["OfferId"] != null)
                            {
                                string offerId = Session["OfferId"].ToString();
                                string offerCategoryId = Session["OfferCategoryId"].ToString();
                                string offerSubCategoryId = Session["OfferSubCategoryId"].ToString();
                                string offerQty = Session["OfferQuantity"].ToString();
                                string offerUnit = Session["OfferUnit"].ToString();
                                Response.Redirect("~/index?oid=" + offerId + "&c=" + offerCategoryId + "&sc=" + offerSubCategoryId + "&qty=" + offerQty + "&unit=" + offerUnit);
                            }
                            else
                                Response.Redirect("~/main/requestHelp");
                        }
                        break;
                }


            }
        }

        public UserModel Login(string phoneNumber, string password)
        {
            UserModel userDetails = new UserModel();
            return userDetails.UserLogin(phoneNumber, password);
        }

        public void Countrylist()
        {

            SqlConnection conn = new SqlConnection(connString);

            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT Country_Id,Country_Name FROM Country_Master", conn);
            SqlDataReader dr = cmd.ExecuteReader();
            scountry.DataSource = dr;
            scountry.Items.Clear();
            scountry.Items.Insert(0, new ListItem("--Please Select country--", ""));
            scountry.DataTextField = "Country_Name";
            scountry.DataValueField = "Country_Id";
            scountry.DataBind();
            conn.Close();
        }

        public void StateonCountry()
        {

            SqlConnection conn = new SqlConnection(connString);

            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT State_Id,State_Name FROM State_Master WHERE Country_Id=" + scountry.SelectedValue, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            sstate.DataSource = dr;
            sstate.Items.Clear();
            sstate.Items.Insert(0, new ListItem("--Please Select State--", ""));
            sstate.DataTextField = "State_Name";
            sstate.DataValueField = "State_Id";
            sstate.DataBind();
            conn.Close();
        }

        public void CityonState()
        {

            //SqlConnection conn = new SqlConnection(connString);

            //conn.Open();

            //SqlCommand cmd = new SqlCommand("SELECT City_Id,City_Name FROM City_Master WHERE State_Id=" + sstate.SelectedValue, conn);
            //SqlDataReader dr = cmd.ExecuteReader();
            //scity.DataSource = dr;
            //scity.Items.Clear();
            //scity.Items.Insert(0, new ListItem("--Please Select City--", ""));
            //scity.DataTextField = "City_Name";
            //scity.DataValueField = "City_Id";
            //scity.DataBind();
            //conn.Close();
        }

        protected void scountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            StateonCountry();
            countryCode.Value = CountryCodes.countryCodes[scountry.SelectedItem.Text];
        }

        protected void sstate_SelectedIndexChanged(object sender, EventArgs e)
        {
            //CityonState();
        }

        protected void check_mobile_Changed(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd = new SqlCommand("select * from User_Register where Phone_Number=@sphoneno", con);

            cmd.Parameters.AddWithValue("@sphoneno", sphoneno.Text);
            SqlDataReader dr = cmd.ExecuteReader();
            Regex regex = new Regex(@"\+?[0-9]{10}");
            Match match = regex.Match(sphoneno.Text);

            if (match.Success)
            {
                if (dr.Read())
                {
                    sphoneno.Text = "";
                    sphonenocheck.Text = "<i class='fa fa-close'></i>Already Registered";
                    this.sphonenocheck.ForeColor = Color.Red;
                }
                else
                {
                    sphonenocheck.Text = "<i class='fa fa-check'></i>Not Registered";
                    this.sphonenocheck.ForeColor = Color.Green;
                }
            }
            else
            {
                sphonenocheck.Text = "<i class='fa fa-close'></i>Enter Valid Cell No.";
                this.sphonenocheck.ForeColor = Color.Red;
            }
            con.Close();
        }

        protected void check_email_Changed(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd = new SqlCommand("select * from User_Register where Email_Id=@semailid", con);

            cmd.Parameters.AddWithValue("@semailid", semailid.Text);
            SqlDataReader dr = cmd.ExecuteReader();
            Regex regex = new Regex(@"^[\w!#$%&'*+\-/=?\^_`{|}~]+(\.[\w!#$%&'*+\-/=?\^_`{|}~]+)*" + "@" + @"((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$");
            Match match = regex.Match(semailid.Text);

            if (match.Success)
            {
                if (dr.Read())
                {
                    semailid.Text = "";
                    semailidlable.Text = "<i class='fa fa-close'></i>Already Registered";
                    this.semailidlable.ForeColor = Color.Red;
                }
                else
                {
                    semailidlable.Text = "<i class='fa fa-check'></i>Not Registered";
                    this.semailidlable.ForeColor = Color.Green;
                }
            }
            else
            {
                semailidlable.Text = "<i class='fa fa-close'></i>Enter Valid Email";
                this.semailidlable.ForeColor = Color.Red;
            }
            con.Close();
        }

        protected void signup_Click(object sender, EventArgs e)
        {

            if (chkDisclaimer.Checked == true)
            {
                UserModel newUser = new UserModel();
                newUser.userName = sname.Text;
                newUser.middleName = mname.Text;
                newUser.lastName = lname.Text;
                newUser.countryCode = countryCode.Value;
                newUser.phoneNumber = sphoneno.Text;
                newUser.emailId = semailid.Text;
                newUser.password = "";
                newUser.entityName = sentityname.Text;
                newUser.roleId = "3";
                newUser.designation = sdesignation.Text;
                //newUser.address = saddress.Text;
                newUser.streetAddress1 = sstreet1.Text;
                newUser.streetAddress2 = sstreet2.Text;

                newUser.countryId = scountry.SelectedValue;
                newUser.stateId = sstate.SelectedValue;
                //newUser.cityId = scity.SelectedValue;
                newUser.cityName = scity.Text;
                newUser.pincode = spincode.Text;
                newUser.latitude = "";
                newUser.longitude = "";

                bool regStatus = AddUser(newUser);
                if (regStatus)
                {

                    sinupvalidate.Text = "<span class='alert alert-success' style='padding:3px'>Registered Successfully! Please Check your registered " + (semailid.Text == "" ? "Cell" : "Email") + " for OTP and instructions to continue the login process.</span>";

                    sname.Text = "";
                    mname.Text = "";
                    lname.Text = "";
                    countryCode.Value = "";
                    sphoneno.Text = "";
                    sphonenocheck.Text = "";
                    semailid.Text = "";
                    semailidlable.Text = "";
                    sentityname.Text = "";
                    sdesignation.Text = "";
                    //saddress.Text = "";
                    sstreet1.Text = "";
                    sstreet2.Text = "";

                    Countrylist();
                    sstate.Items.Clear();
                    //scity.Items.Clear();
                    scity.Text = "";
                    spincode.Text = "";

                    
                }
                else
                {
                    sinupvalidate.Text = "<span class='alert alert-danger' style='padding:3px'>Error occured while registering</span>";
                }
            }

        }

        public static bool AddUser(UserModel userDetails)
        {
            return userDetails.RegisterUser(userDetails);
        }

    }
}
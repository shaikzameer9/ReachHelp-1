using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using ReachHelpWF.Models;
using System.Web.Script.Serialization;

namespace ReachHelpWF
{
    /// <summary>
    /// Summary description for OfferUploads
    /// </summary>
    public class OfferUploads : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {  
           
            try
            {
                string halfpath = string.Empty;
                string str_image = "";
                long ticks = DateTime.Now.Ticks;
               // List<string> doc = new List<string>();
                List<string> img = new List<string>();
                List<string> filePaths = new List<string>();               
                img.Add(".jpg"); img.Add(".jpeg"); img.Add(".png"); img.Add(".bmp"); img.Add(".gif");              

                foreach (string s in context.Request.Files)
                {
                    HttpPostedFile file = context.Request.Files[s];
                    string fileName = file.FileName;
                    string fileExtension = file.ContentType;
                    string fileExt = Path.GetExtension(fileName);                                 
                  
                    if (!string.IsNullOrEmpty(fileName))
                    {
                        fileExtension = Path.GetExtension(fileName);
                        str_image = "Uploaded" + ticks.ToString() + fileExtension;
                        string pathToSave_100 = HttpContext.Current.Server.MapPath("~/Uploads/") + str_image;
                        file.SaveAs(pathToSave_100);
                        halfpath += str_image;
                        filePaths.Add(str_image);
                    }
                }
                JavaScriptSerializer jserializer = new JavaScriptSerializer();
                context.Response.Write(jserializer.Serialize(filePaths));
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
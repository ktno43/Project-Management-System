using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace _380_Project_3
{
    public partial class Login : System.Web.UI.Page
    {
        string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Label1.Visible = true;

            if (Authenticate(TextBox1.Text, TextBox2.Text))
            {
                Response.Redirect("ProjectSelection.aspx");
            }

            else
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Font.Bold = true;
            }
        }

        private bool Authenticate(String sUserName, String sPassword)
        {
            bool bAuthenticate = false;

            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter("select UserID, Username, Password from tblUser where Username='"
                    + sUserName + "'", conn))
                {
                    DataSet ds = new DataSet();
                    sda.Fill(ds, "tblUser");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (sPassword == ds.Tables[0].Rows[0]["Password"].ToString())
                        {
                            bAuthenticate = true;
                            Session["_CurrentUserID"] = ds.Tables[0].Rows[0]["UserID"].ToString();
                        }

                        else
                        {
                            Label1.Text = "Incorrect password";
                            bAuthenticate = false;
                        }
                    }

                    else
                    {
                        Label1.Text = "User does not exist";
                        bAuthenticate = false;
                    }
                }
            }

            return bAuthenticate;
        }
    }
}
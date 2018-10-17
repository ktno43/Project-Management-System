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
    public partial class Deliverables : System.Web.UI.Page
    {
        private string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void Connect(SqlConnection sqlConn)
        {
            if (sqlConn.State == ConnectionState.Closed)
                sqlConn.Open();
        }

        public void Disconnect(SqlConnection sqlConn)
        {
            if (sqlConn.State == ConnectionState.Open)
                sqlConn.Close();
        }

        protected void Button_New_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand("insert into tblDeliverables(UserID,ProjectID,Name,Description) values(@UserID, @ProjectID, @Name, @Description)", conn))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBox1.Text);
                        cmd.Parameters.AddWithValue("@Description", Request.Form["TextArea1"]);

                        cmd.ExecuteNonQuery();
                    }

                    catch (Exception ex)
                    {
                        Response.Write(String.Format("Error while executing query...{0}", ex.ToString()));
                    }

                    finally
                    {
                        Disconnect(conn);
                    }
                }
            }
        }

        protected void Button_Del_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);

                using (SqlCommand cmd = new SqlCommand(String.Format("delete from tblDeliverables where UserID={0} and ProjectID={1} AND Name='{2}'",
                    Session["_CurrentUserID"], Session["_CurrentProjID"], TextBox1.Text), conn))
                {
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }

                    catch (Exception ex)
                    {
                        Response.Write(String.Format("Error while executing query...{0}", ex.ToString()));
                    }

                    finally
                    {
                        Disconnect(conn);
                    }
                }
            }
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {

        }

        protected void Button_Search_Click(object sender, EventArgs e)
        {

        }
    }
}
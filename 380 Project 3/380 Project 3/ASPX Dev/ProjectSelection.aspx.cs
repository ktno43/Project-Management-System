using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Configuration;

namespace _380_Project_3
{
    public partial class ProjectSelection : System.Web.UI.Page
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

        protected void Button_Open_Click(object sender, EventArgs e)
        {
            Session["_CurrentProjID"] = DropDownList1.SelectedValue;
            Response.Redirect("LandingPage.aspx");
        }

        protected void Button_New_Click(object sender, EventArgs e)
        {
            LabelProjectName.Visible = true;
            TextBoxProjectName.Visible = true;
            ButtonCreate.Visible = true;
            TextBoxProjectName.Focus();
        }

        protected void Button_Del_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);

                using (SqlCommand cmd = new SqlCommand(String.Format("delete from tblProjSelect where UserID={0} AND ProjectName='{1}'",
                    Session["_CurrentUserID"], DropDownList1.SelectedItem.Text), conn))
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

            DropDownList1.DataBind();
        }

        protected void ButtonCreate_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand("insert into tblProjSelect(UserID,ProjectName) values(@UserID, @ProjectName)", conn))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectName", TextBoxProjectName.Text);

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

            LabelProjectName.Visible = false;
            TextBoxProjectName.Visible = false;
            ButtonCreate.Visible = false;

            DropDownList1.DataBind();
        }
    }
}
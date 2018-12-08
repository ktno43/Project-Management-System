using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace _380_Project_3.ASPX_Dev
{
    public partial class ProjectSelection : System.Web.UI.Page
    {
        private string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonOpen_Click(object sender, EventArgs e)
        {
            Session["_CurrentProjID"] = DropDownListProjSelect.SelectedValue;
            Response.Redirect("LandingPage.aspx");
        }

        protected void ButtonModalCreate_Click(object sender, EventArgs e)
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

            DropDownListProjSelect.Items.Clear();
            DropDownListProjSelect.DataBind();
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);



                using (SqlCommand cmd = new SqlCommand(String.Format("delete from tblProjSelect where UserID={0} AND ProjectName='{1}'",
                    Session["_CurrentUserID"], DropDownListProjSelect.SelectedItem.Text), conn))
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
            DropDownListProjSelect.Items.Clear();
            DropDownListProjSelect.DataBind();
        }

        protected void ButtonGenReport_Click(object sender, EventArgs e)
        {

        }

        private void Connect(SqlConnection sqlConn)
        {
            if (sqlConn.State == ConnectionState.Closed)
                sqlConn.Open();
        }

        private void Disconnect(SqlConnection sqlConn)
        {
            if (sqlConn.State == ConnectionState.Open)
                sqlConn.Close();
        }
    }
}
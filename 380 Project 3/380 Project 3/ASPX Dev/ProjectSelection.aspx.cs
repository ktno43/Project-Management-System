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
        string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = GetProjectList();

                DropDownList1.DataTextField = "ProjectName";
                DropDownList1.DataValueField = "ProjectID";

                DropDownList1.DataSource = dt;
                DropDownList1.DataBind();
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand("insert into tblProjSelect(UserID,ProjectName) values(@UserID, @ProjectName)", conn))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectName", TextBox1.Text);

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

            RefreshProjectDropDown();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);

                using (SqlCommand cmd = new SqlCommand(String.Format("delete from tblProjSelect where UserID={0} AND ProjectName='{1}'",
                    Session["_CurrentUserID"], TextBox1.Text), conn))
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

            RefreshProjectDropDown();
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

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected DataTable GetProjectList()
        {
            DataTable dt = null;

            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                String sqlString = String.Format("select ProjectID, ProjectName from tblProjSelect where UserID={0} order by ProjectName", Session["_CurrentUserID"]);
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlString, conn))
                {
                    DataSet ds = new DataSet();
                    sda.Fill(ds, "tblProjSelect");

                    dt = ds.Tables["tblProjSelect"];
                }
            }

            return dt;
        }

        private void RefreshProjectDropDown()
        {
            DataTable dt = GetProjectList();

            DropDownList1.DataTextField = "ProjectName";
            DropDownList1.DataValueField = "ProjectID";

            DropDownList1.DataSource = dt;
            DropDownList1.DataBind();
        }
    }
}
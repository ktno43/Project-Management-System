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
    public partial class Tasks : System.Web.UI.Page
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

        protected void ButtonModalSearch_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand("insert into tblTasks(UserID,ProjectID,Name,Description,ExpectedStartDate,ExpectedEndDate,ExpectedEffort)" +
                    " values(@UserID, @ProjectID, @Name, @Description, @ExpStart, @ExpEnd, @ExpEffort)", conn))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@ExpStart", Convert.ToDateTime(TextBoxExpectedStartDate.Text));
                        cmd.Parameters.AddWithValue("@ExpEnd", Convert.ToDateTime(TextBoxExpectedDueDate.Text));
                        cmd.Parameters.AddWithValue("@ExpEffort", TextBoxExpectedEffort.Text);

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

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);

                using (SqlCommand cmd = new SqlCommand(String.Format("delete from tblTasks where UserID={0} and ProjectID={1} AND Name='{2}'",
                    Session["_CurrentUserID"], Session["_CurrentProjID"], TextBoxName.Text), conn))
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

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT TaskID FROM tblTasks WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                    TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd2.ExecuteReader();

                    while (sdr.Read())
                    {
                        Session["_CurrentTaskID"] = sdr[0].ToString();

                    }
                    sdr.Close();
                }

                using (SqlCommand cmd = new SqlCommand(String.Format("UPDATE tblTasks SET Name='{0}', Description='{1}', " +
                    "ExpectedStartDate='{2}', ExpectedEndDate='{3}', ExpectedEffort={4}," +
                    "ActualStartDate='{5}', ActualEndDate='{6}', ActualEffort={7} " +
                    "WHERE UserID={8} AND ProjectID={9} AND TaskID={10}",
                    TextBoxName.Text, TextBoxDescription.Text,
                    Convert.ToDateTime(TextBoxExpectedStartDate.Text).ToString("yyyy-MM-dd"), Convert.ToDateTime(TextBoxExpectedDueDate.Text).ToString("yyyy-MM-dd"), TextBoxExpectedEffort.Text,
                    Convert.ToDateTime(TextBoxActualStartDate.Text).ToString("yyyy-MM-dd"), Convert.ToDateTime(TextBoxActualEndDate.Text).ToString("yyyy-MM-dd"), TextBoxActualEffort.Text,
                    Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentTaskID"]), conn))
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

        protected void ButtonAddResource_Click(object sender, EventArgs e)
        {

        }


        protected void ImageButtonExpectedStartDate_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarExpectedStart.Visible == false)
                CalendarExpectedStart.Visible = true;

            else
                CalendarExpectedStart.Visible = false;
        }

        protected void ImageButtonExpectedDueDate_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarExpectedDue.Visible == false)
                CalendarExpectedDue.Visible = true;

            else
                CalendarExpectedDue.Visible = false;
        }

        protected void ImageButtonActualStartDate_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarActualStart.Visible == false)
                CalendarActualStart.Visible = true;

            else
                CalendarActualStart.Visible = false;
        }


        protected void ImageButtonActualEndDate_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarActualEnd.Visible == false)
                CalendarActualEnd.Visible = true;

            else
                CalendarActualEnd.Visible = false;
        }

        protected void CalendarExpectedStart_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxExpectedStartDate.Text = CalendarExpectedStart.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarExpectedStart.Visible = false;
        }

        protected void CalendarExpectedDue_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxExpectedDueDate.Text = CalendarExpectedDue.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarExpectedDue.Visible = false;
        }

        protected void CalendarActualStart_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxActualStartDate.Text = CalendarActualStart.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarActualStart.Visible = false;
        }

        protected void CalendarActualEnd_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxActualEndDate.Text = CalendarActualEnd.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarActualEnd.Visible = false;
        }
    }
}
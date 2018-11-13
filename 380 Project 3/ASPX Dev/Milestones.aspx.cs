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
    public partial class Milestones : System.Web.UI.Page
    {
        private string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;
        private string g_TaskType = "Milestone";

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
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description, ExpectedEndDate, ExpectedEffort," +
                    "ActualEndDate, ActualEffort FROM tblTasks WHERE TaskID={0} AND UserID={1} AND ProjectID={2}",
                    DropDownListMilestoneSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = sdr[0].ToString();
                        TextBoxDescription.Text = sdr[1].ToString();

                        TextBoxExpectedCompletionDate.Text = sdr[2].ToString();
                        TextBoxExpectedEffort.Text = sdr[3].ToString();

                        TextBoxActualCompletionDate.Text = sdr[4].ToString();
                        TextBoxActualEffort.Text = sdr[5].ToString();
                    }
                    sdr.Close();
                }

                Disconnect(conn);
            }

            ImageButtonActualCompletionDate.Visible = true;
            LabelActualCompletionDate.Visible = true;
            TextBoxActualCompletionDate.Visible = true;
  
            LabelActualEffort.Visible = true;
            TextBoxActualEffort.Visible = true;

            ButtonSave.Visible = true;
            ButtonDelete.Visible = true;
            ButtonGantt.Visible = true;
        }

        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand("insert into tblTasks(UserID,ProjectID,Name,Description,TaskType,ExpectedEndDate,ExpectedEffort)" +
                    " values(@UserID, @ProjectID, @Name, @Description,@TaskType, @ExpEnd, @ExpEffort)", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                    cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                    cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                    cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                    cmd.Parameters.AddWithValue("@TaskType", g_TaskType);
                    cmd.Parameters.AddWithValue("@ExpEnd", Convert.ToDateTime(TextBoxExpectedCompletionDate.Text));
                    cmd.Parameters.AddWithValue("@ExpEffort", TextBoxExpectedEffort.Text);

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

            DropDownListMilestoneSelect.DataBind();
            GridViewTaskList.DataBind();
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

            DropDownListMilestoneSelect.DataBind();
            GridViewTaskList.DataBind();
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
                // Doesn't like " ' " when you update (thinks its a string)
                using (SqlCommand cmd = new SqlCommand("UPDATE tblTasks SET Name=@Name, Description=@Description, " +
                    "ExpectedEndDate=@ExpEndDate, ExpectedEffort=@ExpEff," +
                    "ActualEndDate=@ActEndDate, ActualEffort=@ActEff " +
                    "WHERE UserID=@UserID AND ProjectID=@ProjID AND TaskID=@TaskID", conn))
                {
                    cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                    cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                    cmd.Parameters.AddWithValue("@ExpEndDate", Convert.ToDateTime(TextBoxExpectedCompletionDate.Text));
                    cmd.Parameters.AddWithValue("@ExpEff", TextBoxExpectedEffort.Text);
                    cmd.Parameters.AddWithValue("@ActEndDate", Convert.ToDateTime(TextBoxActualCompletionDate.Text));
                    cmd.Parameters.AddWithValue("@ActEff", TextBoxActualEffort.Text);
                    cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                    cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                    cmd.Parameters.AddWithValue("@TaskID", Session["_CurrentTaskID"]);

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

            DropDownListMilestoneSelect.DataBind();
            GridViewTaskList.DataBind();
        }

        protected void ImageButtonExpectedStartDate_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarExpectedCompletionDate.Visible == false)
                CalendarExpectedCompletionDate.Visible = true;

            else
                CalendarExpectedCompletionDate.Visible = false;
        }

        protected void ImageButtonActualStartDate_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarActualCompletionDate.Visible == false)
                CalendarActualCompletionDate.Visible = true;

            else
                CalendarActualCompletionDate.Visible = false;
        }

        protected void CalendarExpectedStart_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxExpectedCompletionDate.Text = CalendarExpectedCompletionDate.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarExpectedCompletionDate.Visible = false;
        }

        protected void CalendarActualStart_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxActualCompletionDate.Text = CalendarActualCompletionDate.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarActualCompletionDate.Visible = false;
        }

    }
}
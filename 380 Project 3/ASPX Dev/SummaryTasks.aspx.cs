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
    public partial class SummaryTasks : System.Web.UI.Page
    {
        private string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;
        private string g_TaskType = "Summary Task";

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


        protected void ButtonModalSetPredTask_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonModalSetSuccTask_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonModalAssociateIssue_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    foreach (GridViewRow row in this.GridViewAssociateIssues.Rows)
                    {
                        CheckBox checkRow = (row.Cells[0].FindControl("CheckBoxAssociateIssue") as CheckBox);

                        if (checkRow.Checked)
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblIssues SET AssociatedTask=@AssocTask WHERE UserID=@UserID AND ProjectID=@ProjID AND IssueID=@IssueID", conn))
                            {
                                cmd.Parameters.AddWithValue("@AssocTask", Session["_CurrentTaskID"]);
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@IssueID", row.Cells[0].Text);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        else
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblIssues SET AssociatedTask=NULL WHERE UserID=@UserID AND ProjectID=@ProjID AND IssueID=@IssueID", conn))
                            {
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@IssueID", row.Cells[0].Text);

                                cmd.ExecuteNonQuery();
                            }
                        }
                    }
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

            this.GridViewAssociatedIssues.DataBind();
        }

        protected void ButtonModalSearch_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description, ExpectedStartDate, ExpectedEndDate, ExpectedEffort," +
                    "ActualStartDate, ActualEndDate, ActualEffort FROM tblTasks WHERE TaskID={0} AND UserID={1} AND ProjectID={2}",
                    DropDownListSummTaskSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = sdr[0].ToString();
                        TextBoxDescription.Text = sdr[1].ToString();

                        TextBoxExpectedStartDate.Text = sdr[2].ToString();
                        TextBoxExpectedDueDate.Text = sdr[3].ToString();
                        TextBoxExpectedEffort.Text = sdr[4].ToString();

                        TextBoxActualStartDate.Text = sdr[5].ToString();
                        TextBoxActualEndDate.Text = sdr[6].ToString();
                        TextBoxActualEffort.Text = sdr[7].ToString();
                    }
                    sdr.Close();
                }

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
                Disconnect(conn);
            }

            id_GridviewScroll.Visible = true;
            LabelActualStartDate.Visible = true;
            ImageButtonActualStartDate.Visible = true;
            TextBoxActualStartDate.Visible = true;

            LabelActualEndDate.Visible = true;
            ImageButtonActualEndDate.Visible = true;
            TextBoxActualEndDate.Visible = true;

            LabelActualDuration.Visible = true;
            TextBoxActualDuration.Visible = true;

            LabelActualEffort.Visible = true;
            TextBoxActualEffort.Visible = true;

            ButtonSave.Visible = true;
            ButtonDelete.Visible = true;
            ButtonGantt.Visible = true;
        }

        protected void ButtonModalChangeTaskType_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);
                    using (SqlCommand cmd = new SqlCommand("UPDATE tblTasks SET TaskType=@TaskType WHERE UserID=@UserID AND ProjectID=@ProjID AND TaskID=@TaskID", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@TaskID", this.DropDownListChangeTaskType.SelectedValue);
                        cmd.Parameters.AddWithValue("@TaskType", "Task");

                        cmd.ExecuteNonQuery();
                    }
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

            this.GridViewTaskList.DataBind();
            this.DropDownListChangeTaskType.Items.Clear();
            this.DropDownListChangeTaskType.DataBind();
        }


        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand("insert into tblTasks(UserID,ProjectID,Name,Description,TaskType,ExpectedStartDate,ExpectedEndDate,ExpectedEffort)" +
                    " values(@UserID, @ProjectID, @Name, @Description,@TaskType , @ExpStart, @ExpEnd, @ExpEffort)", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                    cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                    cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                    cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                    cmd.Parameters.AddWithValue("@TaskType", g_TaskType);
                    cmd.Parameters.AddWithValue("@ExpStart", TextBoxExpectedStartDate.Text);
                    cmd.Parameters.AddWithValue("@ExpEnd", TextBoxExpectedDueDate.Text);
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

            DropDownListSummTaskSelect.Items.Clear();
            DropDownListSummTaskSelect.DataBind();
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
            DropDownListSummTaskSelect.Items.Clear();
            DropDownListSummTaskSelect.DataBind();
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

                using (SqlCommand cmd = new SqlCommand("UPDATE tblTasks SET Name=@Name, Description=@Description, " +
                    "ExpectedStartDate=@ExpStartDate, ExpectedEndDate=@ExpEndDate, ExpectedEffort=@ExpEff," +
                    "ActualStartDate=@ActStartDate, ActualEndDate=@ActEndDate, ActualEffort=@ActEff " +
                    "WHERE UserID=@UserID AND ProjectID=@ProjID AND TaskID=@TaskID", conn))
                {
                    cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                    cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                    cmd.Parameters.AddWithValue("@ExpStartDate", TextBoxExpectedStartDate.Text);
                    cmd.Parameters.AddWithValue("@ExpEndDate", TextBoxExpectedDueDate.Text);
                    cmd.Parameters.AddWithValue("@ExpEff", TextBoxExpectedEffort.Text);
                    cmd.Parameters.AddWithValue("@ActStartDate", TextBoxActualStartDate.Text);
                    cmd.Parameters.AddWithValue("@ActEndDate", TextBoxActualEndDate.Text);
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

            DropDownListSummTaskSelect.Items.Clear();
            DropDownListSummTaskSelect.DataBind();
            GridViewTaskList.DataBind();
        }

        protected void ButtonAddResource_Click(object sender, EventArgs e)
        {
            Response.Redirect("Resources.aspx");
        }

        protected void ButtonAssociateIssues_Click(object sender, EventArgs e)
        {
            this.GridViewAssociateIssues.DataBind();
        }

        protected void ButtonChangeTaskType_Click(object sender, EventArgs e)
        {

        }
    }
}
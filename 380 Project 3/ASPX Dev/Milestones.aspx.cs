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
            TextBoxExpectedDueDate.Attributes.Add("readonly", "readonly");
            TextBoxActualEndDate.Attributes.Add("readonly", "readonly");
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

                using (SqlCommand cmd = new SqlCommand("UPDATE tblTasks SET PredecessorTask=@PredTask, PredecessorDependency=@PredDependency " +
                  "WHERE UserID=@UserID AND ProjectID=@ProjID AND TaskID=@TaskID", conn))
                {
                    cmd.Parameters.AddWithValue("@PredTask", this.DropDownListSetPredTask.SelectedValue);
                    cmd.Parameters.AddWithValue("@PredDependency", this.DropDownListPredDependency.SelectedValue);
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

            TextBoxPredTask.Text = this.DropDownListSetPredTask.SelectedItem.Text;
            TextBoxPredDepen.Text = this.DropDownListPredDependency.SelectedItem.Text;

            this.DropDownListSetPredTask.DataBind();
            this.DropDownListSetSuccTask.DataBind();
            GridViewTaskList.DataBind();
        }

        protected void ButtonModalSetSuccTask_Click(object sender, EventArgs e)
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
                using (SqlCommand cmd = new SqlCommand("UPDATE tblTasks SET SuccessorTask=@PredTask, SuccessorDependency=@PredDependency " +
                  "WHERE UserID=@UserID AND ProjectID=@ProjID AND TaskID=@TaskID", conn))
                {
                    cmd.Parameters.AddWithValue("@PredTask", this.DropDownListSetSuccTask.SelectedValue);
                    cmd.Parameters.AddWithValue("@PredDependency", this.DropDownListSuccDependency.SelectedValue);
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

            TextBoxSuccTask.Text = this.DropDownListSetSuccTask.SelectedItem.Text;
            TextBoxSuccDepen.Text = this.DropDownListSuccDependency.SelectedItem.Text;

            this.DropDownListSetSuccTask.DataBind();
            this.DropDownListSetPredTask.DataBind();
            this.GridViewTaskList.DataBind();
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


        private string SafeGetString(SqlDataReader reader, int colIndex)
        {
            if (!reader.IsDBNull(colIndex))
                return reader[colIndex].ToString();
            return string.Empty;
        }

        protected void ButtonModalSearch_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description, ExpectedEndDate, ExpectedEffort," +
                    "ActualEndDate, ActualEffort, EffortCompleted, PredecessorTask, PredecessorDependency, SuccessorTask, SuccessorDependency FROM tblTasks WHERE TaskID={0} AND UserID={1} AND ProjectID={2}",
                    DropDownListMilestoneSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = SafeGetString(sdr, 0);
                        TextBoxDescription.Text = SafeGetString(sdr, 1);

                        TextBoxExpectedDueDate.Text = SafeGetString(sdr, 2);
                        TextBoxExpectedEffort.Text = SafeGetString(sdr, 3);

                        TextBoxActualEndDate.Text = SafeGetString(sdr, 4);
                        TextBoxActualEffort.Text = SafeGetString(sdr, 5);

                        TextBoxEffortCompleted.Text = SafeGetString(sdr, 6);

                        TextBoxPredTask.Text = SafeGetString(sdr, 7);
                        TextBoxPredDepen.Text = SafeGetString(sdr, 8);

                        TextBoxSuccTask.Text = SafeGetString(sdr, 9);
                        TextBoxSuccDepen.Text = SafeGetString(sdr, 10);

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

            ImageButtonActualEndDate.Visible = true;
            LabelActualEndDate.Visible = true;
            TextBoxActualEndDate.Visible = true;

            LabelActualEffort.Visible = true;
            TextBoxActualEffort.Visible = true;

            LabelEffortCompleted.Visible = true;
            TextBoxEffortCompleted.Visible = true;

            ButtonSave.Visible = true;
            ButtonDelete.Visible = true;
            ButtonGantt.Visible = true;

            GridViewAssocIssueScrollID.Visible = true;
        }

        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Milestone.');", true);
            }

            else if (TextBoxExpectedDueDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an Expected Due Date for the Milestone.');", true);
            }

            else if (TextBoxExpectedEffort.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an Expected Effort for the Milestone.');", true);
            }

            else
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
                        Disconnect(conn);
                    }
                }

                ImageButtonActualEndDate.Visible = true;
                LabelActualEndDate.Visible = true;
                TextBoxActualEndDate.Visible = true;

                LabelActualEffort.Visible = true;
                TextBoxActualEffort.Visible = true;

                LabelEffortCompleted.Visible = true;
                TextBoxEffortCompleted.Visible = true;

                ButtonSave.Visible = true;
                ButtonDelete.Visible = true;
                ButtonGantt.Visible = true;

                DropDownListMilestoneSelect.Items.Clear();
                DropDownListMilestoneSelect.DataBind();
                GridViewTaskList.DataBind();
                GridViewAssocIssueScrollID.Visible = true;
            }
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name of the Milestone to be deleted.');", true);
            }

            else
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

                DropDownListMilestoneSelect.Items.Clear();
                DropDownListMilestoneSelect.DataBind();
                GridViewTaskList.DataBind();
            }
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Milestone.');", true);
            }

            else if (TextBoxExpectedDueDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an Expected Due Date for the Milestone.');", true);
            }

            else if (TextBoxExpectedEffort.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an Expected Effort for the Milestone.');", true);
            }


            else
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
                        "ExpectedEndDate=@ExpEndDate, ExpectedEffort=@ExpEff," +
                        "ActualEndDate=@ActEndDate, ActualEffort=@ActEff, EffortCompleted=@EffCompl " +
                        "WHERE UserID=@UserID AND ProjectID=@ProjID AND TaskID=@TaskID", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@TaskID", Session["_CurrentTaskID"]);

                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@ExpEndDate", TextBoxExpectedDueDate.Text);
                        cmd.Parameters.AddWithValue("@ExpEff", TextBoxExpectedEffort.Text);
                        cmd.Parameters.AddWithValue("@ActEndDate", string.IsNullOrEmpty(TextBoxActualEndDate.Text) ? (object)DBNull.Value : TextBoxActualEndDate.Text);
                        cmd.Parameters.AddWithValue("@ActEff", string.IsNullOrEmpty(TextBoxActualEffort.Text) ? (object)DBNull.Value : TextBoxActualEffort.Text);
                        cmd.Parameters.AddWithValue("@EffCompl", string.IsNullOrEmpty(TextBoxEffortCompleted.Text) ? (object)DBNull.Value : TextBoxEffortCompleted.Text);


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

                DropDownListMilestoneSelect.Items.Clear();
                DropDownListMilestoneSelect.DataBind();
                GridViewTaskList.DataBind();
            }
        }

        protected void ButtonAssociateIssues_Click(object sender, EventArgs e)
        {
            this.GridViewAssociateIssues.DataBind();
        }
    }
}
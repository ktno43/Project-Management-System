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
            TextBoxExpectedStartDate.Attributes.Add("readonly", "readonly");
            TextBoxExpectedDueDate.Attributes.Add("readonly", "readonly");
            TextBoxActualStartDate.Attributes.Add("readonly", "readonly");
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

        protected void ButtonModalAssociateResource_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    foreach (GridViewRow row in this.GridViewAssociateResource.Rows)
                    {
                        RadioButton checkRow = (row.Cells[0].FindControl("RadioButtonResource") as RadioButton);

                        if (checkRow.Checked)
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblResources SET AssociatedTask=@AssocTask WHERE UserID=@UserID AND ProjectID=@ProjID AND ResourceID=@RescID", conn))
                            {
                                cmd.Parameters.AddWithValue("@AssocTask", Session["_CurrentTaskID"]);
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@RescID", row.Cells[0].Text);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        else
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblResources SET AssociatedTask=NULL WHERE UserID=@UserID AND ProjectID=@ProjID AND ResourceID=@RescID", conn))
                            {

                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@RescID", row.Cells[0].Text);

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

                Connect(conn);
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name FROM tblResources WHERE AssociatedTask={0} AND UserID={1} AND ProjectID={2}",
                    Session["_CurrentTaskID"], Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxResourceAssigned.Text = SafeGetString(sdr, 0);
                    }
                }
                Disconnect(conn);
            }
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

            TextBoxPredecessorTask.Text = this.DropDownListSetPredTask.SelectedItem.Text;
            TextBoxPredDepend.Text = this.DropDownListPredDependency.SelectedItem.Text;

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

            this.TextBoxSuccessorTask.Text = this.DropDownListSetSuccTask.SelectedItem.Text;
            TextBoxSuccDepend.Text = this.DropDownListSuccDependency.SelectedItem.Text;

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
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description, ExpectedStartDate, ExpectedEndDate, ExpectedEffort, ExpectedDuration," +
                    "ActualStartDate, ActualEndDate, ActualEffort, ActualDuration, EffortCompleted, SuccessorTask, SuccessorDependency, PredecessorTask, PredecessorDependency" +
                    " FROM tblTasks WHERE TaskID={0} AND UserID={1} AND ProjectID={2}",
                    DropDownListSummTaskSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = SafeGetString(sdr, 0);
                        TextBoxDescription.Text = SafeGetString(sdr, 1);

                        TextBoxExpectedStartDate.Text = SafeGetString(sdr, 2);
                        TextBoxExpectedDueDate.Text = SafeGetString(sdr, 3);
                        TextBoxExpectedEffort.Text = SafeGetString(sdr, 4);
                        TextBoxExpectedDuration.Text = SafeGetString(sdr, 5);

                        TextBoxActualStartDate.Text = SafeGetString(sdr, 6);
                        TextBoxActualEndDate.Text = SafeGetString(sdr, 7);
                        TextBoxActualEffort.Text = SafeGetString(sdr, 8);
                        TextBoxActualDuration.Text = SafeGetString(sdr, 9);
                        TextBoxEffortCompleted.Text = SafeGetString(sdr, 10);

                        TextBoxSuccessorTask.Text = SafeGetString(sdr, 11);
                        TextBoxSuccDepend.Text = SafeGetString(sdr, 12);

                        TextBoxPredecessorTask.Text = SafeGetString(sdr, 13);
                        TextBoxPredDepend.Text = SafeGetString(sdr, 14);

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

                using (SqlCommand cmd3 = new SqlCommand(String.Format("SELECT Name FROM tblResources WHERE AssociatedTask={0} AND UserID={1} AND ProjectID={2}",
                    Session["_CurrentTaskID"], Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd3.ExecuteReader();

                    TextBoxResourceAssigned.Text = "";

                    while (sdr.Read())
                    {
                        TextBoxResourceAssigned.Text = SafeGetString(sdr, 0);
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

            LabelDays.Visible = true;
            LabelActualDuration.Visible = true;
            TextBoxActualDuration.Visible = true;

            LabelActualEffort.Visible = true;
            TextBoxActualEffort.Visible = true;

            LabelEffortCompleted.Visible = true;
            TextBoxEffortCompleted.Visible = true;

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
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Summary Task.');", true);
            }

            else if (TextBoxExpectedStartDate.Text.Length == 0 || TextBoxExpectedDueDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an Expected Start Date and Expected Due Date for the Summary Task.');", true);
            }

            else if (TextBoxExpectedEffort.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an Expected Effort for the Summary Task.');", true);
            }

            else if (TextBoxExpectedDuration.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an Expected Duration for the Summary Task.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    Connect(conn);
                    using (SqlCommand cmd = new SqlCommand("insert into tblTasks(UserID,ProjectID,Name,Description,TaskType,ExpectedStartDate,ExpectedEndDate,ExpectedEffort, ExpectedDuration)" +
                        " values(@UserID, @ProjectID, @Name, @Description,@TaskType , @ExpStart, @ExpEnd, @ExpEffort, @ExpDuration)", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@TaskType", g_TaskType);
                        cmd.Parameters.AddWithValue("@ExpStart", TextBoxExpectedStartDate.Text);
                        cmd.Parameters.AddWithValue("@ExpEnd", TextBoxExpectedDueDate.Text);
                        cmd.Parameters.AddWithValue("@ExpEffort", TextBoxExpectedEffort.Text);
                        cmd.Parameters.AddWithValue("@ExpDuration", TextBoxActualDuration.Text);

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

                DropDownListSummTaskSelect.Items.Clear();
                DropDownListSummTaskSelect.DataBind();
                GridViewTaskList.DataBind();

                id_GridviewScroll.Visible = true;
                LabelActualStartDate.Visible = true;
                ImageButtonActualStartDate.Visible = true;
                TextBoxActualStartDate.Visible = true;

                LabelActualEndDate.Visible = true;
                ImageButtonActualEndDate.Visible = true;
                TextBoxActualEndDate.Visible = true;

                LabelDays.Visible = true;
                LabelActualDuration.Visible = true;
                TextBoxActualDuration.Visible = true;

                LabelActualEffort.Visible = true;
                TextBoxActualEffort.Visible = true;

                LabelEffortCompleted.Visible = true;
                TextBoxEffortCompleted.Visible = true;

                ButtonSave.Visible = true;
                ButtonDelete.Visible = true;
                ButtonGantt.Visible = true;
            }
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name of the Summary Task to be deleted.');", true);
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
                DropDownListSummTaskSelect.Items.Clear();
                DropDownListSummTaskSelect.DataBind();
                GridViewTaskList.DataBind();
            }
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Summary Task.');", true);
            }

            else if (TextBoxExpectedStartDate.Text.Length == 0 || TextBoxExpectedDueDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an Expected Start Date and Expected Due Date for the Summary Task.');", true);
            }

            else if (TextBoxExpectedEffort.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an Expected Effort for the Summary Task.');", true);
            }

            else if (TextBoxExpectedDuration.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an Expected Duration for the Summary Task.');", true);
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
                        "ExpectedStartDate=@ExpStartDate, ExpectedEndDate=@ExpEndDate, ExpectedEffort=@ExpEff, ExpectedDuration=@ExpDur," +
                        "ActualStartDate=@ActStartDate, ActualEndDate=@ActEndDate, ActualEffort=@ActEff, ActualDuration=@ActDur, EffortCompleted=@EffCompl " +
                        "WHERE UserID=@UserID AND ProjectID=@ProjID AND TaskID=@TaskID", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@TaskID", Session["_CurrentTaskID"]);

                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);

                        cmd.Parameters.AddWithValue("@ExpStartDate", TextBoxExpectedStartDate.Text);
                        cmd.Parameters.AddWithValue("@ExpEndDate", TextBoxExpectedDueDate.Text);
                        cmd.Parameters.AddWithValue("@ExpEff", TextBoxExpectedEffort.Text);
                        cmd.Parameters.AddWithValue("@ExpDur", TextBoxExpectedDuration.Text);

                        cmd.Parameters.AddWithValue("@ActStartDate", string.IsNullOrEmpty(TextBoxActualStartDate.Text) ? (object)DBNull.Value : TextBoxActualStartDate.Text);
                        cmd.Parameters.AddWithValue("@ActEndDate", string.IsNullOrEmpty(TextBoxActualEndDate.Text) ? (object)DBNull.Value : TextBoxActualEndDate.Text);
                        cmd.Parameters.AddWithValue("@ActEff", string.IsNullOrEmpty(TextBoxActualEffort.Text) ? (object)DBNull.Value : TextBoxActualEffort.Text);
                        cmd.Parameters.AddWithValue("@ActDur", string.IsNullOrEmpty(TextBoxActualDuration.Text) ? (object)DBNull.Value : TextBoxActualDuration.Text);
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

                DropDownListSummTaskSelect.Items.Clear();
                DropDownListSummTaskSelect.DataBind();
                GridViewTaskList.DataBind();
            }
        }

        protected void ButtonAddResource_Click(object sender, EventArgs e)
        {
            Response.Redirect("Resources.aspx");
        }

        protected void ButtonAssociateIssues_Click(object sender, EventArgs e)
        {
            this.GridViewAssociateIssues.DataBind();
        }

    }
}
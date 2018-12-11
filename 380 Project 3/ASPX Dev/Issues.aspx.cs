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
    public partial class Issues : System.Web.UI.Page
    {
        private string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            TextBoxExpectedCompletionDate.Attributes.Add("readonly", "readonly");
            TextBoxDateRaised.Attributes.Add("readonly", "readonly");
            TextBoxDateAssigned.Attributes.Add("readonly", "readonly");
            TextBoxActualCompletionDate.Attributes.Add("readonly", "readonly");
            TextBoxSeverity.Attributes.Add("readonly", "readonly");
            TextBoxPriority.Attributes.Add("readonly", "readonly");
            TextBoxStatus.Attributes.Add("readonly", "readonly");
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

        protected void ButtonModalAssocDecisions_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    foreach (GridViewRow row in this.GridViewAssociateDecisions.Rows)
                    {
                        CheckBox checkRow = (row.Cells[0].FindControl("CheckBoxAssociateDecisions") as CheckBox);

                        if (checkRow.Checked)
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblDecisions SET AssociatedIssue=@AssocIssue WHERE UserID=@UserID AND ProjectID=@ProjID AND DecisionID=@DecisionID", conn))
                            {
                                cmd.Parameters.AddWithValue("@AssocIssue", Session["_CurrentIssueID"]);
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@DecisionID", row.Cells[0].Text);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        else
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblDecisions SET AssociatedIssue=NULL WHERE UserID=@UserID AND ProjectID=@ProjID AND DecisionID=@DecisionID", conn))
                            {
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@DecisionID", row.Cells[0].Text);

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


            this.GridViewAssociatedDecisions.DataBind();
        }

        protected void ButtonModalAddStatus_Click(object sender, EventArgs e)
        {
            ListItem li = new ListItem(TextBoxAddStatus.Text, ListBoxStatus.Items.Count.ToString());
            this.ListBoxStatus.Items.Add(li);
            this.ListBoxStatus.SelectedIndex = ListBoxStatus.Items.Count - 1;
        }

        protected void ButtonModalAddSeverity_Click(object sender, EventArgs e)
        {
            ListItem li = new ListItem(TextBoxAddSeverity.Text, ListBoxSeverity.Items.Count.ToString());
            this.ListBoxSeverity.Items.Add(li);
            this.ListBoxSeverity.SelectedIndex = ListBoxSeverity.Items.Count - 1;
        }

        protected void ButtonModalAddPriority_Click(object sender, EventArgs e)
        {
            ListItem li = new ListItem(TextBoxAddPriority.Text, ListBoxPriority.Items.Count.ToString());
            this.ListBoxPriority.Items.Add(li);
            this.ListBoxPriority.SelectedIndex = ListBoxPriority.Items.Count - 1;
        }

        protected void ButtonModalAssocActItems_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    foreach (GridViewRow row in this.GridViewAssociateActionItems.Rows)
                    {
                        CheckBox checkRow = (row.Cells[0].FindControl("CheckBoxAssociateActItems") as CheckBox);

                        if (checkRow.Checked)
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblActionItems SET AssociatedIssue=@AssocIssue WHERE UserID=@UserID AND ProjectID=@ProjID AND ActionItemID=@ActionID", conn))
                            {
                                cmd.Parameters.AddWithValue("@AssocIssue", Session["_CurrentIssueID"]);
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@ActionID", row.Cells[0].Text);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        else
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblActionItems SET AssociatedIssue=NULL WHERE UserID=@UserID AND ProjectID=@ProjID AND ActionItemID=@ActionID", conn))
                            {
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@ActionID", row.Cells[0].Text);

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

            GridViewAssociatedActItem.DataBind();
        }

        private void SaveListBoxes()
        {
            string severityListBoxItem = this.HiddenFieldSeverity.Value;
            string[] arrSeverityListBox = severityListBoxItem.Split('|');

            string priorityListBoxItem = this.HiddenFieldPriority.Value;
            string[] arrPriorityListBox = priorityListBoxItem.Split('|');

            string statusListBoxItem = this.HiddenFieldStatus.Value;
            string[] arrStatusListBox = statusListBoxItem.Split('|');

            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT IssueID FROM tblIssues WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentIssueID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }

                    using (SqlCommand cmd3 = new SqlCommand(String.Format("UPDATE tblIssues SET Status = NULL, Priority = NULL, Severity = NULL WHERE IssueID={0}",
                        Session["_CurrentIssueID"]), conn))
                    {
                        try
                        {
                            cmd3.ExecuteNonQuery();
                        }

                        catch (Exception ex)
                        {
                            Response.Write(String.Format("Error while executing query...{0}", ex.ToString()));
                        }
                    }


                    using (SqlCommand cmd = new SqlCommand(string.Format("delete from tblStatusIssues where UserID={0} and ProjectID={1} AND AssociatedIssue={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentIssueID"]), conn))
                    {
                        using (SqlCommand cmd2 = new SqlCommand(string.Format("delete from tblPriorityIssues where UserID={0} and ProjectID={1} AND AssociatedIssue={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentIssueID"]), conn))
                        {
                            using (SqlCommand cmd3 = new SqlCommand(string.Format("delete from tblSeverityIssues where UserID={0} and ProjectID={1} AND AssociatedIssue={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentIssueID"]), conn))
                            {

                                cmd.ExecuteNonQuery();
                                cmd2.ExecuteNonQuery();
                                cmd3.ExecuteNonQuery();
                            }
                        }
                    }
                    int count = 0;

                    foreach (string statusListItem in arrStatusListBox)
                    {
                        using (SqlCommand cmd4 = new SqlCommand("insert into tblStatusIssues(UserID,ProjectID,StatusName,Sequence, AssociatedIssue) values(@UserID, @ProjectID, @StatusName, @Sequence, @AssocIssue)", conn))
                        {
                            cmd4.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd4.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                            cmd4.Parameters.AddWithValue("@StatusName", statusListItem);
                            cmd4.Parameters.AddWithValue("@Sequence", count);
                            cmd4.Parameters.AddWithValue("@AssocIssue", Session["_CurrentIssueID"]);
                            cmd4.ExecuteNonQuery();
                        }
                        count++;
                    }


                    count = 0;
                    foreach (string priorityListItem in arrPriorityListBox)
                    {
                        using (SqlCommand cmd5 = new SqlCommand("insert into tblPriorityIssues(UserID,ProjectID,PriorityName,Sequence, AssociatedIssue) values(@UserID, @ProjectID, @PriorityName, @Sequence, @AssocIssue)", conn))
                        {
                            cmd5.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd5.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                            cmd5.Parameters.AddWithValue("@PriorityName", priorityListItem);
                            cmd5.Parameters.AddWithValue("@Sequence", count);
                            cmd5.Parameters.AddWithValue("@AssocIssue", Session["_CurrentIssueID"]);
                            cmd5.ExecuteNonQuery();
                        }
                        count++;
                    }


                    count = 0;
                    foreach (string severityListItem in arrSeverityListBox)
                    {
                        using (SqlCommand cmd6 = new SqlCommand("insert into tblSeverityIssues(UserID,ProjectID,SeverityName,Sequence,AssociatedIssue) values(@UserID, @ProjectID, @SeverityName, @Sequence,@AssocIssue)", conn))
                        {
                            cmd6.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd6.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                            cmd6.Parameters.AddWithValue("@SeverityName", severityListItem);
                            cmd6.Parameters.AddWithValue("@Sequence", count);
                            cmd6.Parameters.AddWithValue("@AssocIssue", Session["_CurrentIssueID"]);
                            cmd6.ExecuteNonQuery();
                        }
                        count++;
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

            this.ListBoxPriority.DataBind();
            this.ListBoxStatus.DataBind();
            this.ListBoxSeverity.DataBind();

        }

        private string SafeGetString(SqlDataReader reader, int colIndex)
        {
            if (!reader.IsDBNull(colIndex))
            {
                if (reader[colIndex].GetType() == typeof(DateTime))
                    return Convert.ToDateTime(reader[colIndex]).ToShortDateString();
                else
                    return reader[colIndex].ToString();
            }
            return string.Empty;
        }

        protected void ButtonModalSearch_Click(object sender, EventArgs e)
        {

            Session["_CurrentIssueID"] = this.DropDownListIssuesSelect.SelectedValue;
            this.ListBoxSeverity.DataBind();
            this.ListBoxPriority.DataBind();
            this.ListBoxStatus.DataBind();
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description, ExpectedCompletionDate, DateRaised, DateAssigned," +
                    "Severity, Priority, ActualCompletionDate,Status, StatusDescription, UpdateDate " +
                    "FROM tblIssues WHERE IssueID={0} AND UserID={1} AND ProjectID={2}",
                    this.DropDownListIssuesSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = SafeGetString(sdr, 0);
                        TextBoxDescription.Text = SafeGetString(sdr, 1);
                        TextBoxExpectedCompletionDate.Text = SafeGetString(sdr, 2);
                        TextBoxDateRaised.Text = SafeGetString(sdr, 3);
                        TextBoxDateAssigned.Text = SafeGetString(sdr, 4);

                        if (String.IsNullOrEmpty(SafeGetString(sdr, 5)))
                            TextBoxSeverity.Text = "";
                        else
                        {
                            ListBoxSeverity.SelectedIndex = Int32.Parse(SafeGetString(sdr, 5));
                            TextBoxSeverity.Text = ListBoxSeverity.SelectedItem.ToString();
                        }

                        if (String.IsNullOrEmpty(SafeGetString(sdr, 6)))
                            TextBoxPriority.Text = "";
                        else
                        {
                            ListBoxPriority.SelectedIndex = Int32.Parse(SafeGetString(sdr, 6));
                            TextBoxPriority.Text = ListBoxPriority.SelectedItem.ToString();
                        }

                        TextBoxActualCompletionDate.Text = SafeGetString(sdr, 7);

                        if (String.IsNullOrEmpty(SafeGetString(sdr, 8)))
                            TextBoxStatus.Text = "";
                        else
                        {
                            ListBoxStatus.SelectedIndex = Int32.Parse(SafeGetString(sdr, 8));
                            TextBoxStatus.Text = ListBoxStatus.SelectedItem.ToString();
                        }

                        TextBoxStatusDescription.Text = SafeGetString(sdr, 9);
                        TextBoxLastUpdated.Text = SafeGetString(sdr, 10);
                    }

                    sdr.Close();
                }

                Disconnect(conn);
            }

            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT IssueID FROM tblIssues WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                    TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd2.ExecuteReader();

                    while (sdr.Read())
                    {
                        Session["_CurrentIssueID"] = sdr[0].ToString();

                    }
                    sdr.Close();
                }
            }

            this.GridViewAssociatedActItem.DataBind();
            this.GridViewAssociatedDecisions.DataBind();
            ButtonSave.Visible = true;
            ButtonDelete.Visible = true;

            this.LabelActualCompletionDate.Visible = true;
            this.TextBoxActualCompletionDate.Visible = true;
            this.ImageButtonActCompletionDate.Visible = true;

            ImageButtonClearActCompl.Visible = true;

            LabelSeverity.Visible = true;
            TextBoxSeverity.Visible = true;
            ButtonAddSeverity.Visible = true;
            ButtonRemoveSeverity.Visible = true;
            ListBoxSeverity.Visible = true;
            ImageButtonSeverityMoveDown.Visible = true;
            ImageSeverityMoveUp.Visible = true;

            LabelPri.Visible = true;
            TextBoxPriority.Visible = true;
            ButtonAddPriority.Visible = true;
            ButtonRemovePriority.Visible = true;
            ListBoxPriority.Visible = true;
            ImageButtonPriorityMoveDown.Visible = true;
            ImageButtonPriorityMoveUp.Visible = true;

            LabelStatus.Visible = true;
            TextBoxStatus.Visible = true;
            ButtonAddStatus.Visible = true;
            ButtonRemoveStatus.Visible = true;
            ListBoxStatus.Visible = true;
            ImageButtonStatusMoveDown.Visible = true;
            ImageButtonStatusMoveUp.Visible = true;

            LabelStatusDescr.Visible = true;
            TextBoxStatusDescription.Visible = true;
            LabelUpdated.Visible = true;
            TextBoxLastUpdated.Visible = true;

            LabelAssocItem.Visible = true;
            ButtonAssociateActionItems.Visible = true;
            GridViewActionItemScroll.Visible = true;

            LabelAssocDec.Visible = true;
            ButtonAssociateDecisions.Visible = true;
            GridViewDecisionScroll.Visible = true;
        }

        private void LoadDefaultStatusListBox()
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {

                try
                {
                    Connect(conn);

                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT IssueID FROM tblIssues WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentIssueID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }

                    int statusRowCount = -1;
                    int priorityRowCount = -1;
                    int severityRowCount = -1;

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblStatusIssues where UserID={0} and ProjectID={1} AND AssociatedIssue={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentIssueID"]), conn))
                    {
                        statusRowCount = (int)cmdCount.ExecuteScalar();
                    }

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblPriorityIssues where UserID={0} and ProjectID={1} AND AssociatedIssue={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentIssueID"]), conn))
                    {
                        priorityRowCount = (int)cmdCount.ExecuteScalar();
                    }

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblSeverityIssues where UserID={0} and ProjectID={1} AND AssociatedIssue={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentIssueID"]), conn))
                    {
                        severityRowCount = (int)cmdCount.ExecuteScalar();
                    }

                    string[] arrDefaultStatuses = { "Open", "Closed", "In Progress", "Hold", "Complete" };
                    string[] arrDefaultPriorities = { "Low", "Medium", "High" };
                    string[] arrDefaultSeverities = { "Minor", "Low", "Medium", "High", "Critical" };

                    if (statusRowCount == 0)
                    {
                        for (int i = 0; i < arrDefaultStatuses.Length; i += 1)
                        {
                            using (SqlCommand cmd = new SqlCommand("insert into tblStatusIssues(UserID,ProjectID,StatusName,Sequence, AssociatedIssue)" +
                                " values(@UserID, @ProjectID, @StatusName, @Sequence,@AssocIssue)", conn))
                            {
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@StatusName", arrDefaultStatuses[i]);
                                cmd.Parameters.AddWithValue("@Sequence", i);
                                cmd.Parameters.AddWithValue("@AssocIssue", Session["_CurrentIssueID"]);

                                cmd.ExecuteNonQuery();
                            }
                        }
                        this.ListBoxStatus.DataBind();
                    }

                    if (priorityRowCount == 0)
                    {
                        for (int j = 0; j < arrDefaultPriorities.Length; j += 1)
                        {
                            using (SqlCommand cmd2 = new SqlCommand("insert into tblPriorityIssues(UserID,ProjectID,PriorityName,Sequence,AssociatedIssue)" +
                                " values(@UserID, @ProjectID, @PriorityName, @Sequence,@AssocIssue)", conn))
                            {
                                cmd2.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd2.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                cmd2.Parameters.AddWithValue("@PriorityName", arrDefaultStatuses[j]);
                                cmd2.Parameters.AddWithValue("@Sequence", j);
                                cmd2.Parameters.AddWithValue("@AssocIssue", Session["_CurrentIssueID"]);

                                cmd2.ExecuteNonQuery();
                            }
                        }
                        this.ListBoxPriority.DataBind();
                    }

                    if (severityRowCount == 0)
                    {
                        for (int k = 0; k < arrDefaultSeverities.Length; k += 1)
                        {
                            using (SqlCommand cmd3 = new SqlCommand("insert into tblSeverityIssues(UserID,ProjectID,SeverityName,Sequence,AssociatedIssue)" +
                                " values(@UserID, @ProjectID, @SeverityName, @Sequence,@AssocIssue)", conn))
                            {
                                cmd3.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd3.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                cmd3.Parameters.AddWithValue("@SeverityName", arrDefaultSeverities[k]);
                                cmd3.Parameters.AddWithValue("@Sequence", k);
                                cmd3.Parameters.AddWithValue("@AssocIssue", Session["_CurrentIssueID"]);

                                cmd3.ExecuteNonQuery();
                            }
                        }
                        this.ListBoxSeverity.DataBind();
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
        }

        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Issue.');", true);
            }

            else if (TextBoxExpectedCompletionDate.Text.Length == 0 || TextBoxDateRaised.Text.Length == 0 || TextBoxDateAssigned.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please select a date for the Expected COmpletion Date, Date Raised, and Date Assigned fields.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    try
                    {
                        Connect(conn);
                        using (SqlCommand cmd = new SqlCommand("insert into tblIssues(UserID,ProjectID,Name,Description,DateRaised,DateAssigned,ExpectedCompletionDate) " +
                            "values(@UserID, @ProjectID, @Name, @Description,@DateRaised,@DateAssigned,@ExpectedCompletionDate)", conn))
                        {

                            cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                            cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                            cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                            cmd.Parameters.AddWithValue("@DateRaised", TextBoxDateRaised.Text);
                            cmd.Parameters.AddWithValue("@DateAssigned", TextBoxDateAssigned.Text);
                            cmd.Parameters.AddWithValue("@ExpectedCompletionDate", TextBoxExpectedCompletionDate.Text);

                            cmd.ExecuteNonQuery();
                            LoadDefaultStatusListBox();
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
                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT IssueID FROM tblIssues WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentIssueID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }
                    Disconnect(conn);
                }

                this.DropDownListIssuesSelect.Items.Clear();
                this.DropDownListIssuesSelect.DataBind();

                this.LabelActualCompletionDate.Visible = true;
                this.TextBoxActualCompletionDate.Visible = true;
                this.ImageButtonActCompletionDate.Visible = true;

                LabelSeverity.Visible = true;
                TextBoxSeverity.Visible = true;
                ButtonAddSeverity.Visible = true;
                ButtonRemoveSeverity.Visible = true;
                ListBoxSeverity.Visible = true;
                ImageButtonSeverityMoveDown.Visible = true;
                ImageSeverityMoveUp.Visible = true;

                LabelPri.Visible = true;
                TextBoxPriority.Visible = true;
                ButtonAddPriority.Visible = true;
                ButtonRemovePriority.Visible = true;
                ListBoxPriority.Visible = true;
                ImageButtonPriorityMoveDown.Visible = true;
                ImageButtonPriorityMoveUp.Visible = true;

                LabelStatus.Visible = true;
                TextBoxStatus.Visible = true;
                ButtonAddStatus.Visible = true;
                ButtonRemoveStatus.Visible = true;
                ListBoxStatus.Visible = true;
                ImageButtonStatusMoveDown.Visible = true;
                ImageButtonStatusMoveUp.Visible = true;

                LabelStatusDescr.Visible = true;
                TextBoxStatusDescription.Visible = true;
                LabelUpdated.Visible = true;
                TextBoxLastUpdated.Visible = true;

                LabelAssocItem.Visible = true;
                ButtonAssociateActionItems.Visible = true;

                LabelAssocDec.Visible = true;
                ButtonAssociateDecisions.Visible = true;
            }
        }



        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Issue.');", true);
            }

            else if (TextBoxExpectedCompletionDate.Text.Length == 0 || TextBoxDateRaised.Text.Length == 0 || TextBoxDateAssigned.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please select a date for the Expected COmpletion Date, Date Raised, and Date Assigned fields.');", true);
            }

            else if (TextBoxSeverity.Text.Length == 0 || TextBoxPriority.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please select a severity and priority.');", true);
            }

            else if (TextBoxStatus.Text.Length == 0 || TextBoxStatusDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please select a status and enter a status description.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    try
                    {
                        Connect(conn);

                        using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT IssueID FROM tblIssues WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                            TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                        {
                            SqlDataReader sdr = cmd2.ExecuteReader();

                            while (sdr.Read())
                            {
                                Session["_CurrentIssueID"] = sdr[0].ToString();

                            }
                            sdr.Close();
                        }

                        using (SqlCommand cmd = new SqlCommand("UPDATE tblIssues SET Name=@Name, Description=@Description, " +
                            "DateRaised=@DateRaised, DateAssigned=@DateAssigned, ExpectedCompletionDate=@ExpCompl," +
                            "ActualCompletionDate=@ActCompl, Priority=@Priority, Severity=@Severity, Status=@Status, StatusDescription=@StatusDescr " +
                            "WHERE UserID=@UserID AND ProjectID=@ProjID AND IssueID=@IssueID", conn))
                        {

                            cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                            cmd.Parameters.AddWithValue("@IssueID", Session["_CurrentIssueID"]);

                            cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                            cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                            cmd.Parameters.AddWithValue("@DateRaised", TextBoxDateRaised.Text);
                            cmd.Parameters.AddWithValue("@DateAssigned", TextBoxDateAssigned.Text);
                            cmd.Parameters.AddWithValue("@ExpCompl", TextBoxExpectedCompletionDate.Text);
                            cmd.Parameters.AddWithValue("@ActCompl", string.IsNullOrEmpty(TextBoxActualCompletionDate.Text) ? (object)DBNull.Value : TextBoxActualCompletionDate.Text);

                            string prevSelectedStatus = ListBoxStatus.SelectedItem.ToString();
                            string prevSelectedSeverity = ListBoxSeverity.SelectedItem.ToString();
                            string prevSelectedPriority = ListBoxPriority.SelectedItem.ToString();

                            SaveListBoxes();

                            int updatedStatusIndex = 0;
                            for (int i = 0; i < ListBoxStatus.Items.Count; i++)
                            {
                                if (ListBoxStatus.Items[i].ToString().Equals(prevSelectedStatus))
                                    updatedStatusIndex = i;
                            }

                            int updatedSeverityIndex = 0;
                            for (int i = 0; i < ListBoxSeverity.Items.Count; i++)
                            {
                                if (ListBoxSeverity.Items[i].ToString().Equals(prevSelectedSeverity))
                                    updatedSeverityIndex = i;
                            }

                            int updatedPriorityIndex = 0;
                            for (int i = 0; i < ListBoxPriority.Items.Count; i++)
                            {
                                if (ListBoxPriority.Items[i].ToString().Equals(prevSelectedPriority))
                                    updatedPriorityIndex = i;
                            }

                            cmd.Parameters.AddWithValue("@Priority", updatedPriorityIndex);
                            cmd.Parameters.AddWithValue("@Severity", updatedSeverityIndex);
                            cmd.Parameters.AddWithValue("@Status", updatedStatusIndex);
                            cmd.Parameters.AddWithValue("@StatusDescr", TextBoxStatusDescription.Text);


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

                this.DropDownListIssuesSelect.Items.Clear();
                this.DropDownListIssuesSelect.DataBind();
            }
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name of the Issue to delete.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    Connect(conn);

                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT IssueID FROM tblIssues WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentIssueID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }

                    using (SqlCommand cmd3 = new SqlCommand(String.Format("UPDATE tblActionItems SET AssociatedIssue = NULL WHERE AssociatedIssue={0}", Session["_CurrentIssueID"]), conn))
                    {
                        try
                        {
                            cmd3.ExecuteNonQuery();
                        }

                        catch (Exception ex)
                        {
                            Response.Write(String.Format("Error while executing query...{0}", ex.ToString()));
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand(string.Format("delete from tblStatusIssues where UserID={0} and ProjectID={1} AND AssociatedIssue={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentIssueID"]), conn))
                    {
                        using (SqlCommand cmd2 = new SqlCommand(string.Format("delete from tblPriorityIssues where UserID={0} and ProjectID={1} AND AssociatedIssue={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentIssueID"]), conn))
                        {
                            using (SqlCommand cmd3 = new SqlCommand(string.Format("delete from tblSeverityIssues where UserID={0} and ProjectID={1} AND AssociatedIssue={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentIssueID"]), conn))
                            {

                                cmd.ExecuteNonQuery();
                                cmd2.ExecuteNonQuery();
                                cmd3.ExecuteNonQuery();
                            }
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand(String.Format("delete from tblIssues where UserID={0} and ProjectID={1} AND Name='{2}'",
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

                this.DropDownListIssuesSelect.Items.Clear();
                this.DropDownListIssuesSelect.DataBind();
                GridViewAssociatedActItem.DataBind();
                GridViewAssociatedDecisions.DataBind();
            }
        }

        protected void ButtonRemoveSeverity_Click(object sender, EventArgs e)
        {
            this.ListBoxSeverity.Items.Remove(this.ListBoxSeverity.SelectedItem.ToString());
        }


        protected void ButtonRemovePriority_Click(object sender, EventArgs e)
        {
            this.ListBoxPriority.Items.Remove(this.ListBoxPriority.SelectedItem.ToString());
        }

        protected void ButtonRemoveStatus_Click(object sender, EventArgs e)
        {
            this.ListBoxStatus.Items.Remove(this.ListBoxStatus.SelectedItem.ToString());

        }

        protected void TextBoxLastUpdated_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBoxStatusDescription_TextChanged(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT IssueID FROM tblIssues WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentIssueID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }

                    using (SqlCommand cmd = new SqlCommand("UPDATE tblIssues SET UpdateDate=@LastUpdated" +
                        " WHERE UserID=@UserID AND ProjectID=@ProjID AND IssueID=@IssueID", conn))
                    {

                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@IssueID", Session["_CurrentIssueID"]);


                        cmd.Parameters.AddWithValue("@LastUpdated", DateTime.Today);

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

                TextBoxLastUpdated.Text = DateTime.Today.ToShortDateString();
            }
        }

        protected void ImageButtonClearActCompl_Click(object sender, ImageClickEventArgs e)
        {
            TextBoxActualCompletionDate.Text = "";
        }
    }
}
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
            this.ListBoxStatus.Items.Add(TextBoxAddStatus.Text);
            this.ListBoxStatus.SelectedIndex = ListBoxStatus.Items.Count - 1;
        }

        protected void ButtonModalAddSeverity_Click(object sender, EventArgs e)
        {
            this.ListBoxSeverity.Items.Add(TextBoxAddSeverity.Text);
            this.ListBoxSeverity.SelectedIndex = ListBoxSeverity.Items.Count - 1;
        }

        protected void ButtonModalAddPriority_Click(object sender, EventArgs e)
        {
            this.ListBoxPriority.Items.Add(TextBoxAddPriority.Text);
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

            GridViewAssociatedTasks.DataBind();
        }

        private void SaveListBoxes()
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    using (SqlCommand cmd = new SqlCommand(string.Format("delete from tblStatus where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        using (SqlCommand cmd2 = new SqlCommand(string.Format("delete from tblPriority where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                        {
                            using (SqlCommand cmd3 = new SqlCommand(string.Format("delete from tblSeverity where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                            {

                                cmd.ExecuteNonQuery();
                                cmd2.ExecuteNonQuery();
                                cmd3.ExecuteNonQuery();

                                for (int i = 0; i < ListBoxStatus.Items.Count; i += 1)
                                {
                                    using (SqlCommand cmd4 = new SqlCommand("insert into tblStatus(UserID,ProjectID,StatusName,Sequence) values(@UserID, @ProjectID, @StatusName, @Sequence)", conn))
                                    {
                                        cmd4.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                        cmd4.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                        cmd4.Parameters.AddWithValue("@StatusName", ListBoxStatus.Items[i].ToString());
                                        cmd4.Parameters.AddWithValue("@Sequence", i);
                                        cmd4.ExecuteNonQuery();
                                    }
                                }


                                for (int j = 0; j < ListBoxPriority.Items.Count; j += 1)
                                {
                                    using (SqlCommand cmd5 = new SqlCommand("insert into tblPriority(UserID,ProjectID,PriorityName,Sequence) values(@UserID, @ProjectID, @PriorityName, @Sequence)", conn))
                                    {
                                        cmd5.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                        cmd5.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                        cmd5.Parameters.AddWithValue("@PriorityName", ListBoxPriority.Items[j].ToString());
                                        cmd5.Parameters.AddWithValue("@Sequence", j);
                                        cmd5.ExecuteNonQuery();
                                    }
                                }

                                for (int k = 0; k < ListBoxSeverity.Items.Count; k += 1)
                                {
                                    using (SqlCommand cmd6 = new SqlCommand("insert into tblSeverity(UserID,ProjectID,SeverityName,Sequence) values(@UserID, @ProjectID, @SeverityName, @Sequence)", conn))
                                    {
                                        cmd6.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                        cmd6.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                        cmd6.Parameters.AddWithValue("@SeverityName", ListBoxSeverity.Items[k].ToString());
                                        cmd6.Parameters.AddWithValue("@Sequence", k);
                                        cmd6.ExecuteNonQuery();
                                    }
                                }
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
        }


        protected void ButtonModalSearch_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description, ExpectedCompletionDate, DateRaised, DateAssigned " +
                    "FROM tblIssues WHERE IssueID={0} AND UserID={1} AND ProjectID={2}",
                    this.DropDownListIssuesSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = sdr[0].ToString();
                        TextBoxDescription.Text = sdr[1].ToString();
                        TextBoxExpectedCompletionDate.Text = sdr[2].ToString();
                        TextBoxDateRaised.Text = sdr[3].ToString();
                        TextBoxDateAssigned.Text = sdr[4].ToString();
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

            this.GridViewActionItemScroll.Visible = true;
            this.GridViewAssociatedTasks.DataBind();
            this.GridViewDecisionScroll.Visible = true;
            this.GridViewAssociatedDecisions.DataBind();
            ButtonSave.Visible = true;
            ButtonDelete.Visible = true;

            this.LabelActualCompletionDate.Visible = true;
            this.TextBoxActualCompletionDate.Visible = true;
            this.ImageButtonActCompletionDate.Visible = true;
        }

        private void LoadDefaultStatusListBox()
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {

                try
                {
                    Connect(conn);
                    int statusRowCount = -1;
                    int priorityRowCount = -1;
                    int severityRowCount = -1;

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblStatus where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        statusRowCount = (int)cmdCount.ExecuteScalar();
                    }

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblPriority where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        priorityRowCount = (int)cmdCount.ExecuteScalar();
                    }

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblSeverity where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
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
                            using (SqlCommand cmd = new SqlCommand("insert into tblStatus(UserID,ProjectID,StatusName,Sequence)" +
                                " values(@UserID, @ProjectID, @StatusName, @Sequence)", conn))
                            {
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@StatusName", arrDefaultStatuses[i]);
                                cmd.Parameters.AddWithValue("@Sequence", i);

                                cmd.ExecuteNonQuery();
                            }
                        }
                        this.ListBoxStatus.DataBind();
                    }

                    if (priorityRowCount == 0)
                    {
                        for (int j = 0; j < arrDefaultPriorities.Length; j += 1)
                        {
                            using (SqlCommand cmd2 = new SqlCommand("insert into tblPriority(UserID,ProjectID,PriorityName,Sequence)" +
                                " values(@UserID, @ProjectID, @PriorityName, @Sequence)", conn))
                            {
                                cmd2.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd2.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                cmd2.Parameters.AddWithValue("@PriorityName", arrDefaultStatuses[j]);
                                cmd2.Parameters.AddWithValue("@Sequence", j);

                                cmd2.ExecuteNonQuery();
                            }
                        }
                        this.ListBoxPriority.DataBind();
                    }

                    if (severityRowCount == 0)
                    {
                        for (int k = 0; k < arrDefaultSeverities.Length; k += 1)
                        {
                            using (SqlCommand cmd3 = new SqlCommand("insert into tblSeverity(UserID,ProjectID,SeverityName,Sequence)" +
                                " values(@UserID, @ProjectID, @SeverityName, @Sequence)", conn))
                            {
                                cmd3.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd3.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                cmd3.Parameters.AddWithValue("@SeverityName", arrDefaultSeverities[k]);
                                cmd3.Parameters.AddWithValue("@Sequence", k);

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

                        LoadDefaultStatusListBox();
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



        protected void ButtonSave_Click(object sender, EventArgs e)
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
                        "ActualCompletionDate=@ActCompl " +
                        "WHERE UserID=@UserID AND ProjectID=@ProjID AND IssueID=@IssueID", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@DateRaised", TextBoxDateRaised.Text);
                        cmd.Parameters.AddWithValue("@DateAssigned", TextBoxDateAssigned.Text);
                        cmd.Parameters.AddWithValue("@ExpCompl", TextBoxExpectedCompletionDate.Text);
                        cmd.Parameters.AddWithValue("@ActCompl", TextBoxActualCompletionDate.Text);
                        cmd.Parameters.AddWithValue("@IssueID", Session["_CurrentIssueID"]);


                        SaveListBoxes();
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

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);

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

    }
}
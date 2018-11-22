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

        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand("insert into tblIssues(UserID,ProjectID,Name,Description,DateRaised,DateAssigned,ExpectedCompletionDate) " +
                    "values(@UserID, @ProjectID, @Name, @Description,@DateRaised,@DateAssigned,@ExpectedCompletionDate)", conn))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@DateRaised", Convert.ToDateTime(TextBoxDateRaised.Text));
                        cmd.Parameters.AddWithValue("@DateAssigned", Convert.ToDateTime(TextBoxDateAssigned.Text));
                        cmd.Parameters.AddWithValue("@ExpectedCompletionDate", Convert.ToDateTime(TextBoxExpectedCompletionDate.Text));


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

            this.DropDownListIssuesSelect.DataBind();
        }

        protected void ImageButtonExpCompletionDate_Click(object sender, ImageClickEventArgs e)
        {
            if (this.CalendarExpCompletionDate.Visible == false)
            {
                this.CalendarExpCompletionDate.Visible = true;
            }

            else
                this.CalendarExpCompletionDate.Visible = false;
        }

        protected void ImageButtonDateRaised_Click(object sender, ImageClickEventArgs e)
        {
            if (this.CalendarDateRaised.Visible == false)
            {
                this.CalendarDateRaised.Visible = true;
            }

            else
                this.CalendarDateRaised.Visible = false;
        }

        protected void ImageButtonDateAssigned_Click(object sender, ImageClickEventArgs e)
        {
            if (this.CalendarDateAssigned.Visible == false)
            {
                this.CalendarDateAssigned.Visible = true;
            }

            else
                this.CalendarDateAssigned.Visible = false;
        }

        protected void CalendarExpCompletionDate_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxExpectedCompletionDate.Text = CalendarExpCompletionDate.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarExpCompletionDate.Visible = false;
        }

        protected void CalendarDateRaised_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxDateRaised.Text = CalendarDateRaised.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarDateRaised.Visible = false;
        }

        protected void CalendarDateAssigned_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxDateAssigned.Text = CalendarDateAssigned.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarDateAssigned.Visible = false;
        }

        protected void CalendarActCompletionDate_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxActualCompletionDate.Text = CalendarActCompletionDate.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarActCompletionDate.Visible = false;
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
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
                // Doesn't like " ' " when you update (thinks its a string)
                using (SqlCommand cmd = new SqlCommand("UPDATE tblIssues SET Name=@Name, Description=@Description, " +
                    "DateRaised=@DateRaised, DateAssigned=@DateAssigned, ExpectedCompletionDate=@ExpCompl," +
                    "ActualCompletionDate=@ActCompl " +
                    "WHERE UserID=@UserID AND ProjectID=@ProjID AND IssueID=@IssueID", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                    cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                    cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                    cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                    cmd.Parameters.AddWithValue("@DateRaised", Convert.ToDateTime(TextBoxDateRaised.Text));
                    cmd.Parameters.AddWithValue("@DateAssigned", Convert.ToDateTime(TextBoxDateAssigned.Text));
                    cmd.Parameters.AddWithValue("@ExpCompl", Convert.ToDateTime(TextBoxExpectedCompletionDate.Text));
                    cmd.Parameters.AddWithValue("@ActCompl", Convert.ToDateTime(TextBoxActualCompletionDate.Text));
                    cmd.Parameters.AddWithValue("@IssueID", Session["_CurrentIssueID"]);

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

            this.DropDownListIssuesSelect.DataBind();
        }
    }
}
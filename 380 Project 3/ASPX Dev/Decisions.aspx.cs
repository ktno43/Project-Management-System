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
    public partial class Decisions : System.Web.UI.Page
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
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description,DateCreated, DateNeeded FROM tblDecisions WHERE DecisionID={0} AND UserID={1} AND ProjectID={2}",
                    this.DropDownListDecisionSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = sdr[0].ToString();
                        TextBoxDescription.Text = sdr[1].ToString();
                        TextBoxDateCreated.Text = sdr[2].ToString();
                        TextBoxDateNeeded.Text = sdr[3].ToString();
                    }
                    sdr.Close();
                }

                Disconnect(conn);
            }

            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT DecisionID FROM tblDecisions WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                    TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd2.ExecuteReader();

                    while (sdr.Read())
                    {
                        Session["_CurrentDecisionID"] = sdr[0].ToString();

                    }
                    sdr.Close();
                }
            }

            ButtonSave.Visible = true;
            ButtonDelete.Visible = true;
        }

        protected void ButtonModalAddStatus_Click(object sender, EventArgs e)
        {
            this.ListBoxStatus.Items.Add(TextBoxAddStatus.Text);
            this.ListBoxStatus.SelectedIndex = ListBoxStatus.Items.Count - 1;
        }

        protected void ButtonModalAddImpact_Click(object sender, EventArgs e)
        {
            this.ListBoxImpact.Items.Add(TextBoxAddImpact.Text);
            this.ListBoxImpact.SelectedIndex = ListBoxImpact.Items.Count - 1;
        }

        protected void ButtonModalAddPriority_Click(object sender, EventArgs e)
        {
            this.ListBoxPriority.Items.Add(TextBoxAddPriority.Text);
            this.ListBoxPriority.SelectedIndex = ListBoxPriority.Items.Count - 1;
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
                            using (SqlCommand cmd3 = new SqlCommand(string.Format("delete from tblImpact where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
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

                                for (int k = 0; k < ListBoxImpact.Items.Count; k += 1)
                                {
                                    using (SqlCommand cmd6 = new SqlCommand("insert into tblImpact(UserID,ProjectID,ImpactName,Sequence) values(@UserID, @ProjectID, @ImpactName, @Sequence)", conn))
                                    {
                                        cmd6.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                        cmd6.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                        cmd6.Parameters.AddWithValue("@ImpactName", ListBoxImpact.Items[k].ToString());
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

        private void LoadDefaultStatusListBox()
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {

                try
                {
                    Connect(conn);

                    string[] arrDefaultStatuses = { "Open", "Closed", "In Progress", "Hold", "Complete" };
                    string[] arrDefaultPriorities = { "Low", "Medium", "High" };
                    string[] arrDefaultImpacts = { "Minor", "Low", "Medium", "High", "Critical" };

                    int statusRowCount = -1;
                    int priorityRowCount = -1;
                    int impactRowCount = -1;

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblStatus where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        statusRowCount = (int)cmdCount.ExecuteScalar();
                    }

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblPriority where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        priorityRowCount = (int)cmdCount.ExecuteScalar();
                    }

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblImpact where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        impactRowCount = (int)cmdCount.ExecuteScalar();
                    }

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

                    if (impactRowCount == 0)
                    {

                        for (int k = 0; k < arrDefaultImpacts.Length; k += 1)
                        {
                            using (SqlCommand cmd3 = new SqlCommand("insert into tblImpact(UserID,ProjectID,ImpactName,Sequence)" +
                                " values(@UserID, @ProjectID, @ImpactName, @Sequence)", conn))
                            {
                                cmd3.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd3.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                cmd3.Parameters.AddWithValue("@ImpactName", arrDefaultImpacts[k]);
                                cmd3.Parameters.AddWithValue("@Sequence", k);

                                cmd3.ExecuteNonQuery();
                            }
                        }

                        this.ListBoxImpact.DataBind();
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

                    using (SqlCommand cmd = new SqlCommand("insert into tblDecisions(UserID,ProjectID,Name,Description,DateCreated,DateNeeded) values(@UserID, @ProjectID, @Name, @Description,@DateCreated,@DateNeeded)", conn))
                    {


                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@DateCreated", TextBoxDateCreated.Text);
                        cmd.Parameters.AddWithValue("@DateNeeded", TextBoxDateNeeded.Text);


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
            }

            this.DropDownListDecisionSelect.Items.Clear();
            this.DropDownListDecisionSelect.DataBind();

            this.GridViewListofDecisions.DataBind();

            ButtonSave.Visible = true;
            ButtonDelete.Visible = true;

            LabelActualCompletionDate.Visible = true;
            ImageButtonActCompletionDate.Visible = true;
            TextBoxActCompletionDate.Visible = true;

            LabelDateMade.Visible = true;
            ImageButtonDateMade.Visible = true;
            TextBoxDateMade.Visible = true;

            LabelDecisionMaker.Visible = true;
            TextBoxDecisionMaker.Visible = true;
            ButtonDecisionMaker.Visible = true;
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);

                using (SqlCommand cmd = new SqlCommand(String.Format("delete from tblDecisions where UserID={0} and ProjectID={1} AND Name='{2}'",
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


            this.GridViewListofDecisions.DataBind();

            this.DropDownListDecisionSelect.Items.Clear();
            this.DropDownListDecisionSelect.DataBind();

            ButtonSave.Visible = true;
            ButtonDelete.Visible = true;

            LabelActualCompletionDate.Visible = true;
            ImageButtonActCompletionDate.Visible = true;
            TextBoxActCompletionDate.Visible = true;

            LabelDateMade.Visible = true;
            ImageButtonDateMade.Visible = true;
            TextBoxDateMade.Visible = true;

            LabelDecisionMaker.Visible = true;
            TextBoxDecisionMaker.Visible = true;
            ButtonDecisionMaker.Visible = true;
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);
                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT DecisionID FROM tblDecision WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentDecisionID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }

                    using (SqlCommand cmd = new SqlCommand("UPDATE tblDecisions SET Name=@Name, Description=@Description, DateCreated=@DateCreated" +
                        " DateNeeded=@DateNeeded, DateMade=@DateMade, ActualCompletionDate=@ActComplDate" +
                        " WHERE UserID=@UserID AND ProjectID=@ProjID AND DeliverableID=@DelivID", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@DateCreated", TextBoxDateCreated.Text);
                        cmd.Parameters.AddWithValue("@DateNeeded", TextBoxDateNeeded.Text);
                        cmd.Parameters.AddWithValue("@DateMade", TextBoxDateMade.Text);
                        cmd.Parameters.AddWithValue("@ActComplDate", TextBoxActCompletionDate.Text);


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


            this.GridViewListofDecisions.DataBind();

            this.DropDownListDecisionSelect.Items.Clear();
            this.DropDownListDecisionSelect.DataBind();
        }

        protected void ButtonRemoveImpact_Click(object sender, EventArgs e)
        {
            this.ListBoxImpact.Items.Remove(this.ListBoxImpact.SelectedItem.ToString());

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

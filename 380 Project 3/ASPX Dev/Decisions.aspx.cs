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
            TextBoxDateCreated.Attributes.Add("readonly", "readonly");
            TextBoxDateNeeded.Attributes.Add("readonly", "readonly");
            TextBoxExpCompletionDate.Attributes.Add("readonly", "readonly");
            TextBoxActCompletionDate.Attributes.Add("readonly", "readonly");
            TextBoxDateMade.Attributes.Add("readonly", "readonly");

            TextBoxImpact.Attributes.Add("readonly", "readonly");
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
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblResources SET AssociatedDecision=@AssocDec WHERE UserID=@UserID AND ProjectID=@ProjID AND ResourceID=@RescID", conn))
                            {
                                cmd.Parameters.AddWithValue("@AssocDec", Session["_CurrentDecisionID"]);
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@RescID", row.Cells[0].Text);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        else
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblResources SET AssociatedDecision=NULL WHERE UserID=@UserID AND ProjectID=@ProjID AND ResourceID=@RescID", conn))
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
                using (SqlCommand cmd3 = new SqlCommand(String.Format("SELECT Name FROM tblResources WHERE AssociatedDecision={0} AND UserID={1} AND ProjectID={2}",
                    Session["_CurrentDecisionID"], Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd3.ExecuteReader();

                    TextBoxDecisionMaker.Text = "";

                    while (sdr.Read())
                    {
                        TextBoxDecisionMaker.Text = SafeGetString(sdr, 0);
                    }

                    sdr.Close();
                }
                Disconnect(conn);
            }
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
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description,DateCreated, DateNeeded, DateMade, ExpectedCompletionDate," +
                    "ActualCompletionDate, Status, StatusDescription, Priority, Impact, UpdateDate FROM tblDecisions WHERE DecisionID={0} AND UserID={1} AND ProjectID={2}",
                    this.DropDownListDecisionSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = SafeGetString(sdr, 0);
                        TextBoxDescription.Text = SafeGetString(sdr, 1);
                        TextBoxDateCreated.Text = SafeGetString(sdr, 2);
                        TextBoxDateNeeded.Text = SafeGetString(sdr, 3);
                        TextBoxDateMade.Text = SafeGetString(sdr, 4);
                        TextBoxExpCompletionDate.Text = SafeGetString(sdr, 5);
                        TextBoxActCompletionDate.Text = SafeGetString(sdr, 6);

                        if (String.IsNullOrEmpty(SafeGetString(sdr, 7)))
                            TextBoxStatus.Text = "";
                        else
                        {
                            ListBoxStatus.SelectedIndex = Int32.Parse(SafeGetString(sdr, 7));
                            TextBoxStatus.Text = ListBoxStatus.SelectedItem.ToString();
                        }

                        TextBoxStatusDescription.Text = SafeGetString(sdr, 8);

                        if (String.IsNullOrEmpty(SafeGetString(sdr, 9)))
                            TextBoxPriority.Text = "";
                        else
                        {
                            ListBoxPriority.SelectedIndex = Int32.Parse(SafeGetString(sdr, 9));
                            TextBoxPriority.Text = ListBoxPriority.SelectedItem.ToString();
                        }

                        if (String.IsNullOrEmpty(SafeGetString(sdr, 10)))
                            TextBoxImpact.Text = "";
                        else
                        {
                            ListBoxImpact.SelectedIndex = Int32.Parse(SafeGetString(sdr, 10));
                            TextBoxImpact.Text = ListBoxImpact.SelectedItem.ToString();
                        }

                        TextBoxLastUpdatedStatus.Text = SafeGetString(sdr, 11);

                    }

                    sdr.Close();
                }

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

                using (SqlCommand cmd3 = new SqlCommand(String.Format("SELECT Name FROM tblResources WHERE AssociatedDecision={0} AND UserID={1} AND ProjectID={2}",
                    Session["_CurrentDecisionID"], Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd3.ExecuteReader();

                    TextBoxDecisionMaker.Text = "";

                    while (sdr.Read())
                    {
                        TextBoxDecisionMaker.Text = SafeGetString(sdr, 0);
                    }

                    sdr.Close();
                }

                Disconnect(conn);
            }

            ButtonSave.Visible = true;
            ButtonDelete.Visible = true;

            this.GridViewListofDecisions.DataBind();

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

        protected void ButtonModalAddStatus_Click(object sender, EventArgs e)
        {
            ListItem li = new ListItem(TextBoxAddStatus.Text, ListBoxStatus.Items.Count.ToString());
            this.ListBoxStatus.Items.Add(li);
            this.ListBoxStatus.SelectedIndex = ListBoxStatus.Items.Count - 1;
        }

        protected void ButtonModalAddImpact_Click(object sender, EventArgs e)
        {
            ListItem li = new ListItem(TextBoxAddImpact.Text, ListBoxImpact.Items.Count.ToString());
            this.ListBoxImpact.Items.Add(li);
            this.ListBoxImpact.SelectedIndex = ListBoxImpact.Items.Count - 1;
        }

        protected void ButtonModalAddPriority_Click(object sender, EventArgs e)
        {
            ListItem li = new ListItem(TextBoxAddPriority.Text, ListBoxPriority.Items.Count.ToString());
            this.ListBoxPriority.Items.Add(li);
            this.ListBoxPriority.SelectedIndex = ListBoxPriority.Items.Count - 1;
        }

        private void SaveListBoxes()
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    string impactListBoxItem = this.HiddenFieldImpact.Value;
                    string[] arrImpactListBox = impactListBoxItem.Split('|');

                    string priorityListBoxItem = this.HiddenFieldPriority.Value;
                    string[] arrPriorityListBox = priorityListBoxItem.Split('|');

                    string statusListBoxItem = this.HiddenFieldStatus.Value;
                    string[] arrStatusListBox = statusListBoxItem.Split('|');

                    using (SqlCommand cmd = new SqlCommand(string.Format("delete from tblStatusDec where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        using (SqlCommand cmd2 = new SqlCommand(string.Format("delete from tblPriorityDec where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                        {
                            using (SqlCommand cmd3 = new SqlCommand(string.Format("delete from tblImpactDec where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
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
                        using (SqlCommand cmd4 = new SqlCommand("insert into tblStatusDec(UserID,ProjectID,StatusName,Sequence) values(@UserID, @ProjectID, @StatusName, @Sequence)", conn))
                        {
                            cmd4.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd4.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                            cmd4.Parameters.AddWithValue("@StatusName", statusListItem);
                            cmd4.Parameters.AddWithValue("@Sequence", count);
                            cmd4.ExecuteNonQuery();
                        }
                        count++;
                    }



                    count = 0;
                    foreach (string priorityListItem in arrPriorityListBox)
                    {
                        using (SqlCommand cmd5 = new SqlCommand("insert into tblPriorityDec(UserID,ProjectID,PriorityName,Sequence) values(@UserID, @ProjectID, @PriorityName, @Sequence)", conn))
                        {
                            cmd5.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd5.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                            cmd5.Parameters.AddWithValue("@PriorityName", priorityListItem);
                            cmd5.Parameters.AddWithValue("@Sequence", count);
                            cmd5.ExecuteNonQuery();
                        }
                        count++;
                    }


                    count = 0;
                    foreach (string impactListItem in arrImpactListBox)
                    {
                        using (SqlCommand cmd6 = new SqlCommand("insert into tblImpactDec(UserID,ProjectID,ImpactName,Sequence) values(@UserID, @ProjectID, @ImpactName, @Sequence)", conn))
                        {
                            cmd6.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd6.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                            cmd6.Parameters.AddWithValue("@ImpactName", impactListItem);
                            cmd6.Parameters.AddWithValue("@Sequence", count);
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

            this.ListBoxStatus.DataBind();
            this.ListBoxPriority.DataBind();
            this.ListBoxImpact.DataBind();
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

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblStatusDec where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        statusRowCount = (int)cmdCount.ExecuteScalar();
                    }

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblPriorityDec where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        priorityRowCount = (int)cmdCount.ExecuteScalar();
                    }

                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblImpactDec where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        impactRowCount = (int)cmdCount.ExecuteScalar();
                    }

                    if (statusRowCount == 0)
                    {
                        for (int i = 0; i < arrDefaultStatuses.Length; i += 1)
                        {
                            using (SqlCommand cmd = new SqlCommand("insert into tblStatusDec(UserID,ProjectID,StatusName,Sequence)" +
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
                            using (SqlCommand cmd2 = new SqlCommand("insert into tblPriorityDec(UserID,ProjectID,PriorityName,Sequence)" +
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
                            using (SqlCommand cmd3 = new SqlCommand("insert into tblImpactDec(UserID,ProjectID,ImpactName,Sequence)" +
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
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Decision.');", true);
            }

            else if (TextBoxDateCreated.Text.Length == 0 || TextBoxDateNeeded.Text.Length == 0 || TextBoxExpCompletionDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please select a date for the Date Created, Date Needed, and Expected Completion Date fields.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    try
                    {
                        Connect(conn);

                        using (SqlCommand cmd = new SqlCommand("insert into tblDecisions" +
                            "(UserID,ProjectID,Name,Description,DateCreated,DateNeeded,ExpectedCompletionDate) " +
                            "values(@UserID, @ProjectID, @Name, @Description,@DateCreated,@DateNeeded,@ExpComp)", conn))
                        {


                            cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);

                            cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                            cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                            cmd.Parameters.AddWithValue("@DateCreated", TextBoxDateCreated.Text);
                            cmd.Parameters.AddWithValue("@DateNeeded", TextBoxDateNeeded.Text);
                            cmd.Parameters.AddWithValue("@ExpComp", TextBoxExpCompletionDate.Text);

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
                    Disconnect(conn);
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
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name of the Decision to delete.');", true);
            }

            else
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
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Decision.');", true);
            }

            else if (TextBoxDateCreated.Text.Length == 0 || TextBoxDateNeeded.Text.Length == 0 || TextBoxExpCompletionDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please select a date for the Date Created, Date Needed, and Expected Completion Date fields.');", true);
            }

            else if (TextBoxImpact.Text.Length == 0 || TextBoxPriority.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please select an impact and priority.');", true);
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

                        using (SqlCommand cmd = new SqlCommand("UPDATE tblDecisions SET Name=@Name, Description=@Description, DateCreated=@DateCreated," +
                            " DateNeeded=@DateNeeded, DateMade=@DateMade, ExpectedCompletionDate=@ExpDate, ActualCompletionDate=@ActComplDate," +
                            "Impact=@Impact, Priority=@Priority, Status=@Status, StatusDescription=@StatusDescr" +
                            " WHERE UserID=@UserID AND ProjectID=@ProjID AND DecisionID=@DecID", conn))
                        {


                            cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                            cmd.Parameters.AddWithValue("@DecID", Session["_CurrentDecisionID"]);

                            cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                            cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                            cmd.Parameters.AddWithValue("@DateCreated", TextBoxDateCreated.Text);
                            cmd.Parameters.AddWithValue("@DateNeeded", TextBoxDateNeeded.Text);
                            cmd.Parameters.AddWithValue("@DateMade", TextBoxDateMade.Text);
                            cmd.Parameters.AddWithValue("@ExpDate", TextBoxExpCompletionDate.Text);
                            cmd.Parameters.AddWithValue("@ActComplDate", string.IsNullOrEmpty(TextBoxActCompletionDate.Text) ? (object)DBNull.Value : TextBoxActCompletionDate.Text);

                            string prevSelectedStatus = ListBoxStatus.SelectedItem.ToString();
                            string prevSelectedImpact = ListBoxImpact.SelectedItem.ToString();
                            string prevSelectedPriority = ListBoxPriority.SelectedItem.ToString();

                            SaveListBoxes();

                            int updatedStatusIndex = 0;
                            for (int i = 0; i < ListBoxStatus.Items.Count; i++)
                            {
                                if (ListBoxStatus.Items[i].ToString().Equals(prevSelectedStatus))
                                    updatedStatusIndex = i;
                            }

                            int updatedImpactIndex = 0;
                            for (int i = 0; i < ListBoxImpact.Items.Count; i++)
                            {
                                if (ListBoxImpact.Items[i].ToString().Equals(prevSelectedImpact))
                                    updatedImpactIndex = i;
                            }

                            int updatedPriorityIndex = 0;
                            for (int i = 0; i < ListBoxPriority.Items.Count; i++)
                            {
                                if (ListBoxPriority.Items[i].ToString().Equals(prevSelectedPriority))
                                    updatedPriorityIndex = i;
                            }
                            cmd.Parameters.AddWithValue("@Priority", updatedPriorityIndex);
                            cmd.Parameters.AddWithValue("@Impact", updatedImpactIndex);
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


                this.GridViewListofDecisions.DataBind();

                this.DropDownListDecisionSelect.Items.Clear();
                this.DropDownListDecisionSelect.DataBind();
            }
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

        protected void TextBoxStatusDescription_TextChanged(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
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

                    using (SqlCommand cmd = new SqlCommand("UPDATE tblDecisions SET UpdateDate=@LastUpdated" +
                        " WHERE UserID=@UserID AND ProjectID=@ProjID AND DecisionID=@DecID", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@DecID", Session["_CurrentDecisionID"]);


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

                TextBoxLastUpdatedStatus.Text = DateTime.Today.ToShortDateString();
            }
        }
    }
}

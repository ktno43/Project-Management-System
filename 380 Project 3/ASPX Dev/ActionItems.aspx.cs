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
    public partial class ActionItems : System.Web.UI.Page
    {
        private string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            TextBoxDateAssigned.Attributes.Add("readonly", "readonly");
            TextBoxDateCreated.Attributes.Add("readonly", "readonly");
            TextBoxExpectedCompletionDate.Attributes.Add("readonly", "readonly");
            TextBoxActualCompletionDate.Attributes.Add("readonly", "readonly");
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
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblResources SET AssociatedActionItem=@AssocActItem WHERE UserID=@UserID AND ProjectID=@ProjID AND ResourceID=@RescID", conn))
                            {
                                cmd.Parameters.AddWithValue("@AssocActItem", Session["_CurrentActionItemID"]);
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@RescID", row.Cells[0].Text);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        else
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblResources SET AssociatedActionItem=NULL WHERE UserID=@UserID AND ProjectID=@ProjID AND ResourceID=@RescID", conn))
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
                using (SqlCommand cmd3 = new SqlCommand(String.Format("SELECT Name FROM tblResources WHERE AssociatedActionItem={0} AND UserID={1} AND ProjectID={2}",
                    Session["_CurrentActionItemID"], Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
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
                Session["_CurrentActionItemID"] = DropDownListActItemSelect.SelectedValue;
                this.ListBoxStatus.DataBind();

                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description, DateCreated, DateAssigned," +
                    "ExpectedCompletionDate, ActualCompletionDate, Status, StatusDescription, UpdateDate " +
                    "FROM tblActionItems WHERE ActionItemID={0} AND UserID={1} AND ProjectID={2}",
                    DropDownListActItemSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = SafeGetString(sdr, 0);
                        TextBoxDescription.Text = SafeGetString(sdr, 1);
                        TextBoxDateCreated.Text = SafeGetString(sdr, 2);
                        TextBoxDateAssigned.Text = SafeGetString(sdr, 3);
                        TextBoxExpectedCompletionDate.Text = SafeGetString(sdr, 4);
                        TextBoxActualCompletionDate.Text = SafeGetString(sdr, 5);

                        if (String.IsNullOrEmpty(SafeGetString(sdr, 6)))
                            TextBoxStatus.Text = "";
                        else
                        {
                            ListBoxStatus.SelectedIndex = Int32.Parse(SafeGetString(sdr, 6));
                            TextBoxStatus.Text = ListBoxStatus.SelectedItem.ToString();
                        }

                        TextBoxStatusDescription.Text = SafeGetString(sdr, 7);

                        TextBoxLastUpdated.Text = SafeGetString(sdr, 8);
                    }
                    sdr.Close();
                }

                using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT ActionItemID FROM tblActionItems WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                    TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd2.ExecuteReader();

                    while (sdr.Read())
                    {
                        Session["_CurrentActionItemID"] = sdr[0].ToString();

                    }
                    sdr.Close();
                }

                using (SqlCommand cmd3 = new SqlCommand(String.Format("SELECT Name FROM tblResources WHERE AssociatedActionItem={0} AND UserID={1} AND ProjectID={2}",
                    Session["_CurrentActionItemID"], Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
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

            TextBoxActualCompletionDate.Visible = true;
            LabelActComplDate.Visible = true;
            ImageButtonActualCompletionDate.Visible = true;
            ButtonDelete.Visible = true;
            ButtonSave.Visible = true;
            GridViewAssociateResource.DataBind();

            ImageButtonClearActCompl.Visible = true;
            ImageButtonClearResource.Visible = true;

            LabelResourceAssigned.Visible = true;
            TextBoxResourceAssigned.Visible = true;
            ButtonSelectResource.Visible = true;

            LabelStatus.Visible = true;
            TextBoxStatus.Visible = true;
            ButtonAddStatus.Visible = true;
            ButtonRemoveStatus.Visible = true;
            ListBoxStatus.Visible = true;
            ImageButtonStatusMoveUp.Visible = true;
            ImageButtonStatusMoveDown.Visible = true;

            LabelStatusDescr.Visible = true;
            TextBoxStatusDescription.Visible = true;


            LabelLastUpdated.Visible = true;
            TextBoxLastUpdated.Visible = true;
        }

        private void SaveListBoxes()
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    string statusListBoxItems = this.HiddenFieldListBox.Value;
                    string[] arrListItems = statusListBoxItems.Split('|');

                    using (SqlCommand cmd3 = new SqlCommand(String.Format("UPDATE tblActionItems SET Status = NULL WHERE ActionItemID={0}",
                          Session["_CurrentActionItemID"]), conn))
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

                    using (SqlCommand cmd = new SqlCommand(string.Format("delete from tblStatusActItem where UserID={0} and ProjectID={1} and AssociatedActionItem={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentActionItemID"]), conn))
                    {

                        cmd.ExecuteNonQuery();
                    }

                    int count = 0;
                    foreach (string listItem in arrListItems)
                    {
                        using (SqlCommand cmd2 = new SqlCommand("insert into tblStatusActItem(UserID,ProjectID,StatusName,Sequence,AssociatedActionItem) values(@UserID, @ProjectID, @StatusName, @Sequence,@AssocActItem)", conn))
                        {
                            cmd2.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd2.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                            cmd2.Parameters.AddWithValue("@StatusName", listItem);
                            cmd2.Parameters.AddWithValue("@Sequence", count);
                            cmd2.Parameters.AddWithValue("@AssocActItem", Session["_CurrentActionItemID"]);
                            cmd2.ExecuteNonQuery();
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
        }

        protected void ButtonModalAddStatus_Click(object sender, EventArgs e)
        {
            ListItem li = new ListItem(TextBoxAddStatus.Text, ListBoxStatus.Items.Count.ToString());
            this.ListBoxStatus.Items.Add(li);
            this.ListBoxStatus.SelectedIndex = ListBoxStatus.Items.Count - 1;
        }

        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Action Item.');", true);
            }

            else if (TextBoxDateCreated.Text.Length == 0 || TextBoxDateAssigned.Text.Length == 0 || TextBoxExpectedCompletionDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please select a date for the Date Created, Date Assigned, and Expected Completion Date fields.');", true);
            }


            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {

                    try
                    {
                        Connect(conn);

                        using (SqlCommand cmd = new SqlCommand("insert into tblACtionItems(UserID,ProjectID,Name,Description,DateCreated,DateAssigned,ExpectedCompletionDate)" +
                            " values(@UserID, @ProjectID, @Name, @Description,@DateCreated,@DateAssigned, @ExpCompletionDate)", conn))
                        {

                            cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                            cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                            cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);


                            cmd.Parameters.AddWithValue("@DateCreated", TextBoxDateCreated.Text);
                            cmd.Parameters.AddWithValue("@DateAssigned", TextBoxDateAssigned.Text);
                            cmd.Parameters.AddWithValue("@ExpCompletionDate", TextBoxExpectedCompletionDate.Text);

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
                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT ActionItemID FROM tblActionItems WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentActionItemID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }
                    Disconnect(conn);
                }

                DropDownListActItemSelect.Items.Clear();
                DropDownListActItemSelect.DataBind();
                GridViewActionItemsList.DataBind();
                GridViewAssociateResource.DataBind();

                ImageButtonClearActCompl.Visible = true;
                ImageButtonClearResource.Visible = true;

                TextBoxActualCompletionDate.Visible = true;
                LabelActComplDate.Visible = true;
                ImageButtonActualCompletionDate.Visible = true;

                ButtonDelete.Visible = true;
                ButtonSave.Visible = true;

                LabelResourceAssigned.Visible = true;
                TextBoxResourceAssigned.Visible = true;
                ButtonSelectResource.Visible = true;

                LabelStatus.Visible = true;
                TextBoxStatus.Visible = true;
                ButtonAddStatus.Visible = true;
                ButtonRemoveStatus.Visible = true;
                ListBoxStatus.Visible = true;
                ImageButtonStatusMoveUp.Visible = true;
                ImageButtonStatusMoveDown.Visible = true;

                LabelStatusDescr.Visible = true;
                TextBoxStatusDescription.Visible = true;


                LabelLastUpdated.Visible = true;
                TextBoxLastUpdated.Visible = true;
            }
        }


        private void LoadDefaultStatusListBox()
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    int rowCount = -1;

                    Connect(conn);

                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT ActionItemID FROM tblActionItems WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentActionItemID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }


                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblStatusActItem where UserID={0} and ProjectID={1} AND AssociatedActionItem={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentActionItemID"]), conn))
                    {
                        rowCount = (int)cmdCount.ExecuteScalar();
                    }

                    string[] arrDefaultStatuses = { "Open", "Closed", "In Progress", "Hold", "Complete" };

                    if (rowCount == 0)
                    {
                        for (int i = 0; i < arrDefaultStatuses.Length; i += 1)
                        {
                            using (SqlCommand cmd = new SqlCommand("insert into tblStatusActItem(UserID,ProjectID,StatusName,Sequence,AssociatedActionItem)" +
                                " values(@UserID, @ProjectID, @StatusName, @Sequence,@AssocActItem)", conn))
                            {
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@StatusName", arrDefaultStatuses[i]);
                                cmd.Parameters.AddWithValue("@Sequence", i);
                                cmd.Parameters.AddWithValue("@AssocActItem", Session["_CurrentActionItemID"]);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        this.ListBoxStatus.DataBind();
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

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name of the Action Item you want to delete.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    Connect(conn);

                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT ActionItemID FROM tblActionItems WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentActionItemID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }

                    using (SqlCommand cmd3 = new SqlCommand(String.Format("UPDATE tblResources SET AssociatedActionItem = NULL WHERE AssociatedActionItem={0}", Session["_CurrentActionItemID"]), conn))
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


                    using (SqlCommand cmd = new SqlCommand(string.Format("delete from tblStatusActItem where UserID={0} and ProjectID={1} and AssociatedActionItem={2}", Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentActionItemID"]), conn))
                    {
                        cmd.ExecuteNonQuery();
                    }

                    using (SqlCommand cmd = new SqlCommand(String.Format("delete from tblActionItems where UserID={0} and ProjectID={1} AND Name='{2}'",
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

                DropDownListActItemSelect.Items.Clear();
                DropDownListActItemSelect.DataBind();
                GridViewActionItemsList.DataBind();

            }
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Action Item.');", true);
            }

            else if (TextBoxDateCreated.Text.Length == 0 || TextBoxDateAssigned.Text.Length == 0 || TextBoxExpectedCompletionDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please select a date for the Date Created, Date Assigned, and Expected Completion Date fields.');", true);
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
                        using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT ActionItemID FROM tblActionItems WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                            TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                        {
                            SqlDataReader sdr = cmd2.ExecuteReader();

                            while (sdr.Read())
                            {
                                Session["_CurrentActionItemID"] = sdr[0].ToString();

                            }
                            sdr.Close();
                        }

                        using (SqlCommand cmd = new SqlCommand("UPDATE tblActionItems SET Name=@Name, Description=@Description, " +
                            "DateCreated=@DateCreated, DateAssigned=@DateAssigned, ExpectedCompletionDate=@ExpComplDate," +
                            "ActualCompletionDate=@ActComplDate, Status=@Status, StatusDescription=@StatusDescription" +
                            " WHERE UserID=@UserID AND ProjectID=@ProjID AND ActionItemID=@ActionID", conn))
                        {
                            cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                            cmd.Parameters.AddWithValue("@ActionID", Session["_CurrentActionItemID"]);

                            cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                            cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                            cmd.Parameters.AddWithValue("@DateCreated", TextBoxDateCreated.Text);
                            cmd.Parameters.AddWithValue("@DateAssigned", TextBoxDateAssigned.Text);
                            cmd.Parameters.AddWithValue("@ExpComplDate", TextBoxExpectedCompletionDate.Text);
                            cmd.Parameters.AddWithValue("@ActComplDate", string.IsNullOrEmpty(TextBoxActualCompletionDate.Text) ? (object)DBNull.Value : TextBoxActualCompletionDate.Text);

                            string prevSelectedVal = ListBoxStatus.SelectedItem.ToString();
                            SaveListBoxes();
                            int updatedIndex = 0;
                            for (int i = 0; i < ListBoxStatus.Items.Count; i++)
                            {
                                if (ListBoxStatus.Items[i].ToString().Equals(prevSelectedVal))
                                    updatedIndex = i;
                            }
                            cmd.Parameters.AddWithValue("@Status", updatedIndex);
                            cmd.Parameters.AddWithValue("@StatusDescription", TextBoxStatusDescription.Text);

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

                DropDownListActItemSelect.Items.Clear();
                DropDownListActItemSelect.DataBind();
                GridViewAssociateResource.DataBind();
                GridViewActionItemsList.DataBind();
            }
        }


        protected void ButtonAddResource_Click(object sender, EventArgs e)
        {
            Response.Redirect("Resources.aspx");
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
                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT ActionItemID FROM tblActionItems WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentActionItemID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }

                    using (SqlCommand cmd = new SqlCommand("UPDATE tblActionItems SET UpdateDate=@LastUpdated" +
                        " WHERE UserID=@UserID AND ProjectID=@ProjID AND ActionItemID=@ActionID", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@ActionID", Session["_CurrentActionItemID"]);


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

        protected void ImageButtonClearResource_Click(object sender, ImageClickEventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    using (SqlCommand cmd = new SqlCommand("UPDATE tblResources SET AssociatedActionItem=NULL WHERE UserID=@UserID AND ProjectID=@ProjID AND AssociatedActionItem=@ActItem", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@ActItem", Session["_CurrentActionItemID"]);
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

                GridViewAssociateResource.DataBind();
                TextBoxResourceAssigned.Text = "";
            }
        }

        protected void ImageButtonClearActCompl_Click(object sender, ImageClickEventArgs e)
        {
            TextBoxActualCompletionDate.Text = "";
        }
    }
}
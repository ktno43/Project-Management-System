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
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description, DateCreated, DateAssigned," +
                    "ExpectedCompletionDate, StatusDescription FROM tblActionItems WHERE ActionItemID={0} AND UserID={1} AND ProjectID={2}",
                    DropDownListActItemSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = sdr[0].ToString();
                        TextBoxDescription.Text = sdr[1].ToString();
                        TextBoxDateCreated.Text = sdr[2].ToString();
                        TextBoxDateAssigned.Text = sdr[3].ToString();
                        TextBoxExpectedCompletionDate.Text = sdr[4].ToString();
                        TextBoxStatusDescription.Text = sdr[5].ToString();

                    }
                    sdr.Close();
                }

                Disconnect(conn);
            }

        }

        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand("insert into tblACtionItems(UserID,ProjectID,Name,Description,DateCreated,DateAssigned,ExpectedCompletionDate, StatusDescription)" +
                    " values(@UserID, @ProjectID, @Name, @Description,@DateCreated,@DateAssigned, @ExpCompletionDate, @StatusDescription)", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                    cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                    cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                    cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                    cmd.Parameters.AddWithValue("@DateCreated", Convert.ToDateTime(TextBoxDateCreated.Text));
                    cmd.Parameters.AddWithValue("@DateAssigned", Convert.ToDateTime(TextBoxDateAssigned.Text));
                    cmd.Parameters.AddWithValue("@ExpCompletionDate", Convert.ToDateTime(TextBoxExpectedCompletionDate.Text));
                    cmd.Parameters.AddWithValue("@StatusDescription", TextBoxStatusDescription.Text);

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

            DropDownListActItemSelect.DataBind();
            GridViewActionItemsList.DataBind();
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);

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

            DropDownListActItemSelect.DataBind();
            GridViewActionItemsList.DataBind();
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
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

                using (SqlCommand cmd = new SqlCommand("UPDATE tblACtionItems SET Name=@Name, Description=@Description, " +
                    "DateCreated=@DateCreated, DateAssigned=@DateAssigned, ExpectedCompletionDate=@ExpComplDate," +
                    "ActualCompletionDate=@ActComplDate, StatusDescription=@StatusDescription" +
                    " WHERE UserID=@UserID AND ProjectID=@ProjID AND ActionItemID=@ActionID", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                    cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                    cmd.Parameters.AddWithValue("@ActionItemID", Session["_CurrentActionItemID"]);

                    cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                    cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                    cmd.Parameters.AddWithValue("@DateCreated", Convert.ToDateTime(TextBoxDateCreated.Text));
                    cmd.Parameters.AddWithValue("@DateAssigned", Convert.ToDateTime(TextBoxDateAssigned.Text));
                    cmd.Parameters.AddWithValue("@ExpComplDate", Convert.ToDateTime(TextBoxExpectedCompletionDate.Text));
                    cmd.Parameters.AddWithValue("@ActComplDate", Convert.ToDateTime(TextBoxActualCompletionDate.Text));
                    cmd.Parameters.AddWithValue("@StatusDescription", TextBoxStatusDescription.Text);

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

            DropDownListActItemSelect.DataBind();
            GridViewActionItemsList.DataBind();
        }

        protected void ButtonAddStatus_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonRemoveStatus_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonAddResource_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonMoveUp_Click(object sender, EventArgs e)
        {
            MoveItem(-1);
        }

        protected void ButtonMoveDown_Click(object sender, EventArgs e)
        {
            MoveItem(1);
        }

        private void MoveItem(int direction)
        {
            // Checking selected item
            if (this.ListBoxStatus.SelectedItem == null || ListBoxStatus.SelectedIndex < 0)
                return; // No selected item - nothing to do

            // Calculate new index using move direction
            int newIndex = ListBoxStatus.SelectedIndex + direction;

            // Checking bounds of the range
            if (newIndex < 0 || newIndex >= ListBoxStatus.Items.Count)
                return; // Index out of range - nothing to do

            ListItem selected = ListBoxStatus.SelectedItem;

            // Removing removable element
            ListBoxStatus.Items.Remove(selected);
            // Insert it in new position
            ListBoxStatus.Items.Insert(newIndex, selected);
            // Restore selection
            ListBoxStatus.SelectedIndex = newIndex;
        }
    }
}
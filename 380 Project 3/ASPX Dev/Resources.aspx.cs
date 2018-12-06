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
    public partial class Resources : System.Web.UI.Page
    {
        private string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            TextBoxStartDate.Attributes.Add("readonly", "readonly");
            TextBoxEndDate.Attributes.Add("readonly", "readonly");
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
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description, Title, PayRate, ListOfSkills, AvailableStartDate, AvailableEndDate FROM tblResources WHERE ResourceID={0} AND UserID={1} AND ProjectID={2}",
                    DropDownListResourceSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = SafeGetString(sdr, 0);
                        TextBoxDescription.Text = SafeGetString(sdr, 1);
                        TextBoxTitle.Text = SafeGetString(sdr, 2);
                        TextBoxPayRate.Text = SafeGetString(sdr, 3);
                        TextBoxSkillsDescription.Text = SafeGetString(sdr, 4);
                        TextBoxStartDate.Text = SafeGetString(sdr, 5);
                        TextBoxEndDate.Text = SafeGetString(sdr, 6);
                        if (!(string.IsNullOrEmpty(TextBoxStartDate.Text) || string.IsNullOrEmpty(TextBoxEndDate.Text)))
                            TextBoxAvailability.Text = TextBoxStartDate.Text + " to " + TextBoxEndDate.Text;
                    }
                    sdr.Close();
                }

                Disconnect(conn);
            }

            ButtonSave.Visible = true;
            ButtonDelete.Visible = true;
        }
        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0 || TextBoxTitle.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name, description, and title for the Resource.');", true);
            }

            else if (TextBoxSkillsDescription.Text.Length == 0 || TextBoxPayRate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a description of skills and pay rate for the Resource.');", true);
            }

            else if (TextBoxStartDate.Text.Length == 0 && TextBoxEndDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an available start and end date.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    Connect(conn);
                    using (SqlCommand cmd = new SqlCommand("insert into tblResources(UserID,ProjectID,Name,Description,Title,PayRate, AvailableStartDate, AvailableEndDate, ListOfSkills)" +
                        " values(@UserID, @ProjectID, @Name, @Description,@Title , @PayRate, @AvailStart, @AvailEnd, @ListOfSkills)", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@Title", TextBoxTitle.Text);
                        cmd.Parameters.AddWithValue("@PayRate", TextBoxPayRate.Text);
                        cmd.Parameters.AddWithValue("@AvailStart", TextBoxStartDate.Text);
                        cmd.Parameters.AddWithValue("@AvailEnd", TextBoxEndDate.Text);
                        cmd.Parameters.AddWithValue("ListOfSkills", TextBoxSkillsDescription.Text);

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
                        using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT ResourceID FROM tblResources WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                            TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                        {
                            SqlDataReader sdr = cmd2.ExecuteReader();

                            while (sdr.Read())
                            {
                                Session["_CurrentResourceID"] = sdr[0].ToString();

                            }
                            sdr.Close();
                        }
                        Disconnect(conn);
                    }
                }

                DropDownListResourceSelect.Items.Clear();
                DropDownListResourceSelect.DataBind();

                ButtonSave.Visible = true;
                ButtonDelete.Visible = true;
            }
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter the name of theResource to be deleted.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    Connect(conn);

                    using (SqlCommand cmd = new SqlCommand(String.Format("delete from tblResources where UserID={0} and ProjectID={1} AND Name='{2}'",
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

                DropDownListResourceSelect.Items.Clear();
                DropDownListResourceSelect.DataBind();
            }
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0 || TextBoxTitle.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name, description, and title for the Resource.');", true);
            }

            else if (TextBoxSkillsDescription.Text.Length == 0 || TextBoxPayRate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a description of skills and pay rate for the Resource.');", true);
            }

            else if (TextBoxAvailability.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter an available start and end date.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    Connect(conn);
                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT ResourceID FROM tblResources WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentResourceID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }

                    using (SqlCommand cmd = new SqlCommand("UPDATE tblResources SET Name=@Name, Description=@Description, " +
                        "Title=@Title, PayRate=@PayRate, AvailableStartDate=@AvailStart, AvailableEndDate=@AvailEnd, ListOfSkills=@ListOfSkills" +
                        " WHERE UserID=@UserID AND ProjectID=@ProjID AND ResourceID=@ResourceID", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@ResourceID", Session["_CurrentResourceID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@Title", TextBoxTitle.Text);
                        cmd.Parameters.AddWithValue("@PayRate", TextBoxPayRate.Text);
                        cmd.Parameters.AddWithValue("@AvailStart", TextBoxStartDate.Text);
                        cmd.Parameters.AddWithValue("@AvailEnd", TextBoxEndDate.Text);
                        cmd.Parameters.AddWithValue("@ListOfSkills", TextBoxSkillsDescription.Text);

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

                DropDownListResourceSelect.Items.Clear();
                DropDownListResourceSelect.DataBind();
            }
        }
    }
}
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

            TextBoxActualCompletionDate.Visible = true;
            LabelActComplDate.Visible = true;
            ImageButtonActualCompletionDate.Visible = true;
            ButtonDelete.Visible = true;
            ButtonSave.Visible = true;
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

                        cmd.ExecuteNonQuery();

                        for (int i = 0; i < ListBoxStatus.Items.Count; i += 1)
                        {
                            using (SqlCommand cmd2 = new SqlCommand("insert into tblStatus(UserID,ProjectID,StatusName,Sequence) values(@UserID, @ProjectID, @StatusName, @Sequence)", conn))
                            {
                                cmd2.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd2.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                                cmd2.Parameters.AddWithValue("@StatusName", ListBoxStatus.Items[i].ToString());
                                cmd2.Parameters.AddWithValue("@Sequence", i);
                                cmd2.ExecuteNonQuery();
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

        protected void ButtonModalAddStatus_Click(object sender, EventArgs e)
        {
            this.ListBoxStatus.Items.Add(TextBoxAddStatus.Text);
            this.ListBoxStatus.SelectedIndex = ListBoxStatus.Items.Count - 1;
        }

        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {

                try
                {
                    Connect(conn);

                    using (SqlCommand cmd = new SqlCommand("insert into tblACtionItems(UserID,ProjectID,Name,Description,DateCreated,DateAssigned,ExpectedCompletionDate, StatusDescription)" +
                        " values(@UserID, @ProjectID, @Name, @Description,@DateCreated,@DateAssigned, @ExpCompletionDate, @StatusDescription)", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@DateCreated", TextBoxDateCreated.Text);
                        cmd.Parameters.AddWithValue("@DateAssigned", TextBoxDateAssigned.Text);
                        cmd.Parameters.AddWithValue("@ExpCompletionDate", TextBoxExpectedCompletionDate.Text);
                        cmd.Parameters.AddWithValue("@StatusDescription", TextBoxStatusDescription.Text);


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

            DropDownListActItemSelect.Items.Clear();
            DropDownListActItemSelect.DataBind();
            GridViewActionItemsList.DataBind();

            TextBoxActualCompletionDate.Visible = true;
            LabelActComplDate.Visible = true;
            ImageButtonActualCompletionDate.Visible = true;

            ButtonDelete.Visible = true;
            ButtonSave.Visible = true;
        }


        private void LoadDefaultStatusListBox()
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    int rowCount = -1;

                    Connect(conn);


                    using (SqlCommand cmdCount = new SqlCommand(String.Format("select count(*) from tblStatus where UserID={0} and ProjectID={1}", Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        rowCount = (int)cmdCount.ExecuteScalar();
                    }

                    string[] arrDefaultStatuses = { "Open", "Closed", "In Progress", "Hold", "Complete" };

                    if (rowCount == 0)
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

            DropDownListActItemSelect.Items.Clear();
            DropDownListActItemSelect.DataBind();
            GridViewActionItemsList.DataBind();
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
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
                        cmd.Parameters.AddWithValue("@DateCreated", TextBoxDateCreated.Text);
                        cmd.Parameters.AddWithValue("@DateAssigned", TextBoxDateAssigned.Text);
                        cmd.Parameters.AddWithValue("@ExpComplDate", TextBoxExpectedCompletionDate.Text);
                        cmd.Parameters.AddWithValue("@ActComplDate", TextBoxActualCompletionDate.Text);
                        cmd.Parameters.AddWithValue("@StatusDescription", TextBoxStatusDescription.Text);


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

            DropDownListActItemSelect.Items.Clear();
            DropDownListActItemSelect.DataBind();
            GridViewActionItemsList.DataBind();
        }




        protected void ButtonAddResource_Click(object sender, EventArgs e)
        {
            Response.Redirect("Resources.aspx");
        }

        protected void ButtonRemoveStatus_Click(object sender, EventArgs e)
        {
            this.ListBoxStatus.Items.Remove(this.ListBoxStatus.SelectedItem.ToString());
        }
    }
}
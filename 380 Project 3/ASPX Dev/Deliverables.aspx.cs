using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace _380_Project_3
{
    public partial class Deliverables : System.Web.UI.Page
    {
        private string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            TextBoxStartDate.Attributes.Add("readonly", "readonly");
            TextBoxDueDate.Attributes.Add("readonly", "readonly");

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
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description, StartDate, DueDate FROM tblDeliverables WHERE DeliverableID={0} AND UserID={1} AND ProjectID={2}",
                    DropDownListDelivSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = SafeGetString(sdr, 0);
                        TextBoxDescription.Text = SafeGetString(sdr, 1);
                        TextBoxStartDate.Text = SafeGetString(sdr, 2);
                        TextBoxDueDate.Text = SafeGetString(sdr, 3);
                    }
                    sdr.Close();
                }

                Disconnect(conn);
            }

            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT DeliverableID FROM tblDeliverables WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                    TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd2.ExecuteReader();

                    while (sdr.Read())
                    {
                        Session["_CurrentDelivID"] = sdr[0].ToString();

                    }
                    sdr.Close();
                }
                Disconnect(conn);
            }

            this.id_GridviewScroll.Visible = true;
            GridViewAssociatedTasks.DataBind();
            ButtonSave.Visible = true;
            ButtonDel.Visible = true;
        }

        protected void ButtonModalAssociateTask_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                try
                {
                    Connect(conn);

                    foreach (GridViewRow row in this.GridViewAssociateTasks.Rows)
                    {
                        CheckBox checkRow = (row.Cells[0].FindControl("CheckBoxAssociateTask") as CheckBox);

                        if (checkRow.Checked)
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblTasks SET AssociatedDeliverable=@AssocDeliv WHERE UserID=@UserID AND ProjectID=@ProjID AND TaskID=@TaskID", conn))
                            {
                                cmd.Parameters.AddWithValue("@AssocDeliv", Session["_CurrentDelivID"]);
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@TaskID", row.Cells[0].Text);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        else
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE tblTasks SET AssociatedDeliverable=NULL WHERE UserID=@UserID AND ProjectID=@ProjID AND TaskID=@TaskID", conn))
                            {
                                cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                                cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                                cmd.Parameters.AddWithValue("@TaskID", row.Cells[0].Text);

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
                using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT DeliverableID FROM tblDeliverables WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                    TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd2.ExecuteReader();

                    while (sdr.Read())
                    {
                        Session["_CurrentDelivID"] = sdr[0].ToString();

                    }
                    sdr.Close();

                }
                Disconnect(conn);
            }
            GridViewAssociatedTasks.DataBind();
        }


        protected void Button_New_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Deliverable.');", true);
            }

            else if (TextBoxStartDate.Text.Length == 0 || TextBoxDueDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a start and due date for the deliverable.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    Connect(conn);
                    using (SqlCommand cmd = new SqlCommand("insert into tblDeliverables(UserID,ProjectID,Name,Description, StartDate, DueDate) " +
                        "values(@UserID, @ProjectID, @Name, @Description, @StartDate, @DueDate)", conn))
                    {
                        try
                        {
                            cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                            cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                            cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                            cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                            cmd.Parameters.AddWithValue("@StartDate", TextBoxStartDate.Text);
                            cmd.Parameters.AddWithValue("DueDate", TextBoxDueDate.Text);


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
                        using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT DeliverableID FROM tblDeliverables WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                            TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                        {
                            SqlDataReader sdr = cmd2.ExecuteReader();

                            while (sdr.Read())
                            {
                                Session["_CurrentDelivID"] = sdr[0].ToString();

                            }
                            sdr.Close();
                        }
                        Disconnect(conn);
                    }
                }

                DropDownListDelivSelect.Items.Clear();
                DropDownListDelivSelect.DataBind();
                GridViewListDeliverables.DataBind();
                ButtonSave.Visible = true;
                ButtonDel.Visible = true;
            }
        }

        protected void Button_Del_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name of the Deliverable to delete.');", true);
            }

            else
            {
                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    Connect(conn);

                    using (SqlCommand cmd = new SqlCommand(String.Format("delete from tblDeliverables where UserID={0} and ProjectID={1} AND Name='{2}'",
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

                DropDownListDelivSelect.Items.Clear();
                DropDownListDelivSelect.DataBind();
                GridViewListDeliverables.DataBind();
            }
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text.Length == 0 || TextBoxDescription.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a name and description for the Deliverable.');", true);
            }

            else if (TextBoxStartDate.Text.Length == 0 || TextBoxDueDate.Text.Length == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                    "alertMessage",
                    "alert('Please enter a start and due date for the deliverable.');", true);
            }

            else
            {

                using (SqlConnection conn = new SqlConnection(g_sqlConn))
                {
                    Connect(conn);
                    using (SqlCommand cmd2 = new SqlCommand(String.Format("SELECT DeliverableID FROM tblDeliverables WHERE Name='{0}' AND UserID={1} AND ProjectID={2}",
                        TextBoxName.Text, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                    {
                        SqlDataReader sdr = cmd2.ExecuteReader();

                        while (sdr.Read())
                        {
                            Session["_CurrentDelivID"] = sdr[0].ToString();

                        }
                        sdr.Close();
                    }

                    using (SqlCommand cmd = new SqlCommand("UPDATE tblDeliverables SET Name=@Name, Description=@Description, StartDate=@StartDate, DueDate=@DueDate WHERE UserID=@UserID AND ProjectID=@ProjID AND DeliverableID=@DelivID", conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@DelivID", Session["_CurrentDelivID"]);
                        cmd.Parameters.AddWithValue("@StartDate", TextBoxStartDate.Text);
                        cmd.Parameters.AddWithValue("@DueDate", TextBoxDueDate.Text);


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

                DropDownListDelivSelect.Items.Clear();
                DropDownListDelivSelect.DataBind();
                GridViewListDeliverables.DataBind();
            }
        }

        protected void ButtonAssociateTasks_Click(object sender, EventArgs e)
        {
            GridViewAssociateTask.DataBind();
        }
    }
}
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
                using (SqlCommand cmd = new SqlCommand(String.Format("SELECT Name, Description FROM tblDeliverables WHERE DeliverableID={0} AND UserID={1} AND ProjectID={2}",
                    DropDownListDelivSelect.SelectedValue, Session["_CurrentUserID"], Session["_CurrentProjID"]), conn))
                {
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        TextBoxName.Text = sdr[0].ToString();
                        TextBoxDescription.Text = sdr[1].ToString();
                    }
                    sdr.Close();
                }

                Disconnect(conn);
            }

            ButtonSave.Visible = true;
            ButtonDel.Visible = true;
        }

        protected void Button_New_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand("insert into tblDeliverables(UserID,ProjectID,Name,Description) values(@UserID, @ProjectID, @Name, @Description)", conn))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);


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

            DropDownListDelivSelect.DataBind();
            GridViewListDeliverables.DataBind();
            ButtonSave.Visible = true;
            ButtonDel.Visible = true;
        }

        protected void Button_Del_Click(object sender, EventArgs e)
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

            DropDownListDelivSelect.DataBind();
            GridViewListDeliverables.DataBind();
        }

        protected void Button_Save_Click(object sender, EventArgs e)
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

                using (SqlCommand cmd = new SqlCommand(String.Format("UPDATE tblDeliverables SET Name='{0}', Description='{1}' WHERE UserID={2} AND ProjectID={3} AND DeliverableID={4}",
                    TextBoxName.Text, TextBoxDescription.Text, Session["_CurrentUserID"], Session["_CurrentProjID"], Session["_CurrentDelivID"]), conn))
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

            DropDownListDelivSelect.DataBind();
            GridViewListDeliverables.DataBind();
        }

        protected void ButtonModalCreate_Click(object sender, EventArgs e)
        {

        }

        protected void ImageButtonStartDate_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarStart.Visible == false)
                CalendarStart.Visible = true;

            else
                CalendarStart.Visible = false;
        }

        protected void ImageButtonDueDate_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarDue.Visible == false)
                CalendarDue.Visible = true;

            else
                CalendarDue.Visible = false;
        }

        protected void CalendarStart_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxStartDate.Text = CalendarStart.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarStart.Visible = false;
        }

        protected void CalendarDue_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxDueDate.Text = CalendarDue.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarDue.Visible = false;
        }

    }
}
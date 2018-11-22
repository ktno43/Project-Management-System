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

        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(g_sqlConn))
            {
                Connect(conn);
                using (SqlCommand cmd = new SqlCommand("insert into tblDecisions(UserID,ProjectID,Name,Description,DateCreated,DateNeeded) values(@UserID, @ProjectID, @Name, @Description,@DateCreated,@DateNeeded)", conn))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["_CurrentUserID"]);
                        cmd.Parameters.AddWithValue("@ProjectID", Session["_CurrentProjID"]);
                        cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        cmd.Parameters.AddWithValue("@Description", TextBoxDescription.Text);
                        cmd.Parameters.AddWithValue("@DateCreated", Convert.ToDateTime(TextBoxDateCreated.Text));
                        cmd.Parameters.AddWithValue("@DateNeeded", Convert.ToDateTime(TextBoxDateNeeded.Text));


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
                    cmd.Parameters.AddWithValue("@DateCreated", Convert.ToDateTime(TextBoxDateCreated.Text));
                    cmd.Parameters.AddWithValue("@DateNeeded", Convert.ToDateTime(TextBoxDateNeeded.Text));
                    cmd.Parameters.AddWithValue("@DateMade", Convert.ToDateTime(TextBoxDateMade.Text));
                    cmd.Parameters.AddWithValue("@ActComplDate", Convert.ToDateTime(TextBoxActCompletionDate.Text));


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

            this.DropDownListDecisionSelect.DataBind();
        }

        protected void ImageButtonDateCreated_Click(object sender, ImageClickEventArgs e)
        {
            if (this.CalendarCreated.Visible == false)
                this.CalendarCreated.Visible = true;

            else
                CalendarCreated.Visible = false;
        }

        protected void ImageButtonDateNeeded_Click(object sender, ImageClickEventArgs e)
        {
            if (this.CalendarCreated.Visible == false)
                this.CalendarCreated.Visible = true;

            else
                CalendarCreated.Visible = false;
        }

        protected void ImageButtonExpCompletionDate_Click(object sender, ImageClickEventArgs e)
        {
            if (this.CalendarExpCompletionDate.Visible == false)
                this.CalendarExpCompletionDate.Visible = true;

            else
                CalendarExpCompletionDate.Visible = false;
        }

        protected void ImageButtonActCompletionDate_Click(object sender, ImageClickEventArgs e)
        {
            if (this.CalendarActCompletionDate.Visible == false)
                this.CalendarActCompletionDate.Visible = true;

            else
                CalendarActCompletionDate.Visible = false;
        }

        protected void ImageButtonDateMade_Click(object sender, ImageClickEventArgs e)
        {
            if (this.CalendarDateMade.Visible == false)
                this.CalendarDateMade.Visible = true;

            else
                CalendarDateMade.Visible = false;
        }

        protected void CalendarCreated_SelectionChanged(object sender, EventArgs e)
        {
            this.TextBoxDateCreated.Text = this.CalendarCreated.SelectedDate.ToString("dddd, dd MMMM yyyy");
            CalendarCreated.Visible = false;
        }

        protected void CalendarNeeded_SelectionChanged(object sender, EventArgs e)
        {
            this.TextBoxDateNeeded.Text = this.CalendarNeeded.SelectedDate.ToString("dddd, dd MMMM yyyy");
            this.CalendarNeeded.Visible = false;
        }

        protected void CalendarExpCompletionDate_SelectionChanged(object sender, EventArgs e)
        {
            this.TextBoxExpCompletionDate.Text = this.CalendarExpCompletionDate.SelectedDate.ToString("dddd, dd MMMM yyyy");
            this.CalendarExpCompletionDate.Visible = false;
        }

        protected void CalendarActCompletionDate_SelectionChanged(object sender, EventArgs e)
        {
            this.TextBoxActCompletionDate.Text = this.CalendarActCompletionDate.SelectedDate.ToString("dddd, dd MMMM yyyy");
            this.CalendarActCompletionDate.Visible = false;
        }

        protected void CalendarDateMade_SelectionChanged(object sender, EventArgs e)
        {
            this.TextBoxDateMade.Text = this.CalendarDateMade.SelectedDate.ToString("dddd, dd MMMM yyyy");
            this.CalendarDateMade.Visible = false;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _380_Project_3
{
    public partial class Deliverables : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
        {
            bool hasParent = e.Item.Parent != null;

            switch (hasParent)
            {
                case false:
                    switch (e.Item.Value)
                    {
                        case "Deliverables":
                            Response.Redirect("Deliverables.aspx");
                            break;

                        case "Tasks":
                            Response.Redirect("Tasks.aspx");
                            break;

                        case "Issues":
                            Response.Redirect("Issues.aspx");
                            break;

                        case "Action Items":
                            Response.Redirect("ActionItems.aspx");
                            break;

                        case "Decisions":
                            Response.Redirect("Decisions.aspx");
                            break;

                        case "Resources":
                            Response.Redirect("Resources.aspx");
                            break;

                        case "Risks":
                            Response.Redirect("Risks.aspx");
                            break;

                        case "Requirements":
                            Response.Redirect("Requirements.aspx");
                            break;

                        case "Changes":
                            Response.Redirect("Changes.aspx");
                            break;

                        case "Reference Documents":
                            Response.Redirect("ReferenceDocuments.aspx");
                            break;

                        case "Components":
                            Response.Redirect("Components.aspx");
                            break;

                        case "Defects":
                            Response.Redirect("Defects.aspx");
                            break;
                    }
                    break;

                case true:
                    switch (e.Item.Parent.Value)
                    {
                        case "Tasks":
                            switch (e.Item.Value)
                            {
                                case "Tasks":
                                    Response.Redirect("Tasks.aspx");
                                    break;

                                case "Summary Tasks":
                                    Response.Redirect("SummaryTasks.aspx");
                                    break;

                                case "Milestones":
                                    Response.Redirect("Milestones.aspx");
                                    break;
                            }
                            break;
                    }
                    break;
            }
        }


    }
}
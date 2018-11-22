<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Decisions.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Decisions" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <div class="container">
        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Search for Decisions</h4>
                    </div>

                    <div class="modal-body">
                        Decisions List:
                        <asp:DropDownList ID="DropDownListDecisionSelect" runat="server" DataSourceID="DropDownListDecisionDB" DataTextField="Name" DataValueField="DecisionID" Height="30px" Width="571px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListDecisionDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [DecisionID] FROM [tblDecisions] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Decision" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>

    </div>

    <table style="width: 100%;">
        <tr>
            <td colspan="1" class="auto-style8">Name<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="3" class="auto-style8"><span class="auto-style2">
                <asp:TextBox ID="TextBoxName" runat="server"></asp:TextBox>
            </span>&nbsp;</td>
            <td colspan="1" class="auto-style8"><span class="auto-style2">
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" />
            </span></td>
            <td colspan="1" class="auto-style8">Impact*:</td>
            <td colspan="2" class="auto-style8">
                <asp:DropDownList ID="DropDownListImpact" runat="server">
                    <asp:ListItem>Minor</asp:ListItem>
                    <asp:ListItem>Low</asp:ListItem>
                    <asp:ListItem>Medium</asp:ListItem>
                    <asp:ListItem>High</asp:ListItem>
                    <asp:ListItem>Critical</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td colspan="7" class="auto-style8">
                <asp:Button ID="ButtonAddImpact" runat="server" Text="Add Impact" />
            </td>
        </tr>
        <tr>
            <td colspan="6"></td>
            <td colspan="2"></td>
            <td colspan="3">
                <asp:Button ID="ButtonRemoveImpact" runat="server" Text="Remove Impact" />
            </td>
        </tr>
        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="5">&nbsp;</td>
            <td colspan="1">Priority*:</td>
            <td colspan="2">
                <asp:DropDownList ID="DropDownListPriority" runat="server">
                    <asp:ListItem>Low</asp:ListItem>
                    <asp:ListItem>Medium</asp:ListItem>
                    <asp:ListItem>High</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td colspan="7">
                <asp:Button ID="ButtonAddPriority" runat="server" Text="Add Priority" />
            </td>

        </tr>
        <tr>
            <td colspan="5"></td>
            <td colspan="1"></td>
            <td colspan="2"></td>
            <td colspan="7">
                <asp:Button ID="ButtonRemovePriority" runat="server" Text="Remove Priority" />
            </td>
        </tr>
        <tr>
            <td colspan="15"></td>
        </tr>
        <tr>
            <td colspan="1">Description<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="4"><span class="auto-style2">
                <asp:TextBox ID="TextBoxDescription" runat="server" MaxLength="1000" TextMode="MultiLine"></asp:TextBox>
            </span></td>
            <td colspan="1">Status<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="2">
                <asp:DropDownList ID="DropDownListStatus" runat="server">
                    <asp:ListItem>Open</asp:ListItem>
                    <asp:ListItem>Closed</asp:ListItem>
                    <asp:ListItem>In Progress</asp:ListItem>
                    <asp:ListItem>Hold</asp:ListItem>
                    <asp:ListItem>Complete</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td colspan="7">
                <asp:Button ID="ButtonAddStatus" runat="server" Text="Add Status" />
            </td>
        </tr>
        <tr>
            <td colspan="6"></td>
            <td colspan="2"></td>
            <td colspan="7">
                <asp:Button ID="ButtonRemoveStatus" runat="server" Text="Remove Status" />
            </td>
        </tr>
        <tr>
            <td colspan="15"></td>
        </tr>


        <tr>
            <td colspan="1" class="auto-style9">Date Created<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="3" class="auto-style9"><span class="auto-style2">
                <asp:TextBox ID="TextBoxDateCreated" runat="server"></asp:TextBox>
            </span></td>
            <td colspan="1" class="auto-style9"><span class="auto-style2">
                <asp:ImageButton ID="ImageButtonDateCreated" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" OnClick="ImageButtonDateCreated_Click" />
            </span></td>
            <td colspan="1">Status Description*:</td>
            <td colspan="9">
                <asp:TextBox ID="TextBoxStatusDescription" runat="server" MaxLength="1000" TextMode="MultiLine" Height="133px" Width="250px"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">
                <asp:Calendar ID="CalendarCreated" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" OnSelectionChanged="CalendarCreated_SelectionChanged" Width="350px" Visible="False">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            <td colspan="1"></td>
            <td colspan="1">Last Updated Status:</td>
            <td colspan="9">
                <asp:TextBox ID="TextBoxLastUpdatedStatus" runat="server"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style10">Date Needed<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="3" class="auto-style10"><span class="auto-style2">
                <asp:TextBox ID="TextBoxDateNeeded" runat="server"></asp:TextBox>
            </span></td>
            <td colspan="1" class="auto-style10"><span class="auto-style2">
                <asp:ImageButton ID="ImageButtonDateNeeded" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" OnClick="ImageButtonDateNeeded_Click" />
            </span></td>
            <td colspan="1" class="auto-style10">Associated Meetinng Note(s):</td>
            <td colspan="2"></td>
            <td colspan="7">
                <asp:Button ID="ButtonAssociateMeetingNOtes" runat="server" Text="Associate Meeting Notes" />
            </td>
        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">
                <asp:Calendar ID="CalendarNeeded" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" OnSelectionChanged="CalendarNeeded_SelectionChanged" Visible="False" Width="350px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            <td colspan="1"></td>
            <td colspan="1">Last Updated Note:</td>
            <td colspan="9">
                <asp:TextBox ID="TextBoxLastUpdatedNote" runat="server"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="1">Expected Completion Date<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="3">
                <asp:TextBox ID="TextBoxExpCompletionDate" runat="server"></asp:TextBox>
            </td>
            <td colspan="1">
                <span class="auto-style2">
                    <asp:ImageButton ID="ImageButtonExpCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" OnClick="ImageButtonExpCompletionDate_Click" />
                </span></td>
            <td colspan="1">Associated Reference Document(s):</td>
            <td colspan="9">
                <asp:Button ID="ButtonAssociateRefDocs" runat="server" Text="Associate Reference Documents" Width="249px" />
            </td>
        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">
                <asp:Calendar ID="CalendarExpCompletionDate" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" OnSelectionChanged="CalendarExpCompletionDate_SelectionChanged" Visible="False" Width="350px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            <td colspan="1"></td>
            <td colspan="10"></td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="1">
                <asp:Label ID="LabelActualCompletionDate" runat="server" Text="Actual Completion Date:"></asp:Label>
            </td>
            <td colspan="3">
                <asp:TextBox ID="TextBoxActCompletionDate" runat="server" Visible="False"></asp:TextBox>
            </td>
            <td colspan="11">
                <span class="auto-style2">
                    <asp:ImageButton ID="ImageButtonActCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" OnClick="ImageButtonActCompletionDate_Click" Visible="False" />
                </span></td>
        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">
                <asp:Calendar ID="CalendarActCompletionDate" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" OnSelectionChanged="CalendarActCompletionDate_SelectionChanged" Visible="False" Width="350px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            <td colspan="1"></td>
            <td colspan="10"></td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>


        <tr>
            <td colspan="1">
                <asp:Label ID="LabelDateMade" runat="server" Text="Date Made:" Visible="False"></asp:Label>
            </td>
            <td colspan="3">
                <asp:TextBox ID="TextBoxDateMade" runat="server" Visible="False"></asp:TextBox>
            </td>
            <td colspan="11">
                <span class="auto-style2">
                    <asp:ImageButton ID="ImageButtonDateMade" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" OnClick="ImageButtonDateMade_Click" />
                </span></td>

        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">
                <asp:Calendar ID="CalendarDateMade" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" OnSelectionChanged="CalendarDateMade_SelectionChanged" Visible="False" Width="350px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            <td colspan="11"></td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>


        <tr>
            <td colspan="1">
                <asp:Label ID="LabelDecisionMaker" runat="server" Text="Decision Maker:" Visible="False"></asp:Label>
            </td>
            <td colspan="3">
                <asp:TextBox ID="TextBoxDecisionMaker" runat="server" Visible="False"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonDecisionMaker" runat="server" Text="Select Resource" Visible="False" />
            </td>
            <td colspan="10"></td>
        </tr>


        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" Text="New" OnClick="ButtonNew_Click" />
            </td>
            <td colspan="4"></td>
            <td colspan="1">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" Visible="False" OnClick="ButtonDelete_Click" />
            </td>
            <td colspan="2">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" Visible="False" OnClick="ButtonSave_Click" />
            </td>
            <td colspan="7"></td>
        </tr>
    </table>


</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .auto-style1 {
            color: #FF0000;
        }

        .auto-style2 {
            color: #000000;
        }

        .auto-style8 {
            height: 20px;
        }

        .auto-style9 {
            height: 25px;
        }

        .auto-style10 {
            height: 26px;
        }
    </style>
</asp:Content>


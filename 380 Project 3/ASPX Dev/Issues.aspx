<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Issues.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Issues" %>

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
                        <h4 class="modal-title">Search for Issues</h4>
                    </div>

                    <div class="modal-body">
                        Issues List:
                        <asp:DropDownList ID="DropDownListIssuesSelect" runat="server" DataSourceID="DropDownListIssuesDB" DataTextField="Name" DataValueField="IssueID" Height="30px" Width="571px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListIssuesDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [IssueID] FROM [tblIssues] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Issue" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>

    </div>

    <div class="container2">
        <!-- Modal -->
        <div class="modal fade" id="myModal2" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Associate Action Items</h4>
                    </div>

                    <div class="modal-body">
                        Action Items List:
                                   <div style="overflow-y: scroll; height: 250px">
                                       <asp:GridView ID="GridViewAssociateActionItems" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewAssocActItem" ForeColor="#333333" GridLines="None" Width="472px" DataKeyNames="ActionItemID">
                                           <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                           <Columns>
                                               <asp:BoundField DataField="ActionItemID" HeaderText="ActionItemID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                               <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                               <asp:TemplateField>
                                                   <ItemTemplate>
                                                       <asp:CheckBox ID="CheckBoxAssociateActItems" runat="server" Checked='<%#Convert.ToBoolean(Eval("Checked")) %>' />
                                                   </ItemTemplate>
                                               </asp:TemplateField>
                                           </Columns>
                                           <EditRowStyle BackColor="#999999" />
                                           <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                           <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                           <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                           <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                           <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                           <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                           <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                           <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                           <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                       </asp:GridView>
                                   </div>
                        <asp:SqlDataSource ID="GridViewAssocActItem" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [ActionItemID], [Name],
                            CASE WHEN [AssociatedIssue] is NULL THEN 0 ELSE 1 END AS [Checked] FROM [tblActionItems] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) 
                            AND ([AssociatedIssue] = @AssocIssue OR [AssociatedIssue] IS NULL))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                <asp:SessionParameter Name="AssocIssue" SessionField="_CurrentIssueID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <asp:Button ID="ButtonModalAssocActItems" runat="server" Text="Associate Action Items" CssClass="btn btn-default" OnClick="ButtonModalAssocActItems_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="container3">
        <!-- Modal -->
        <div class="modal fade" id="myModal3" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Associate Decisions</h4>
                    </div>

                    <div class="modal-body">
                        Decisions List:
                                   <div style="overflow-y: scroll; height: 250px">
                                       <asp:GridView ID="GridViewAssociateDecisions" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewAssocDecisions" ForeColor="#333333" GridLines="None" Width="472px" DataKeyNames="DecisionID">
                                           <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                           <Columns>
                                               <asp:BoundField DataField="DecisionID" HeaderText="DecisionID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                               <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                               <asp:TemplateField>
                                                   <ItemTemplate>
                                                       <asp:CheckBox ID="CheckBoxAssociateDecisions" runat="server" Checked='<%#Convert.ToBoolean(Eval("Checked")) %>' />
                                                   </ItemTemplate>
                                               </asp:TemplateField>
                                           </Columns>
                                           <EditRowStyle BackColor="#999999" />
                                           <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                           <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                           <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                           <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                           <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                           <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                           <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                           <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                           <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                       </asp:GridView>
                                   </div>
                        <asp:SqlDataSource ID="GridViewAssocDecisions" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [DecisionID], [Name],
                            CASE WHEN [AssociatedIssue] is NULL THEN 0 ELSE 1 END AS [Checked] FROM [tblDecisions] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) 
                            AND ([AssociatedIssue] = @AssocIssue OR [AssociatedIssue] IS NULL))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                <asp:SessionParameter Name="AssocIssue" SessionField="_CurrentIssueID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <asp:Button ID="ButtonModalAssocDecisions" runat="server" Text="Associate Decisions" CssClass="btn btn-default" OnClick="ButtonModalAssocDecisions_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>


    <table style="width: 100%;">
        <tr>
            <td colspan="1">Name<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="3"><span class="auto-style3">
                <asp:TextBox ID="TextBoxName" runat="server"></asp:TextBox>
            </span></td>
            <td colspan="1"><span class="auto-style3">
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" />
            </span></td>
            <td colspan="1">Severity<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="2">
                <asp:DropDownList ID="DropDownListSeverity" runat="server">
                    <asp:ListItem>Minor</asp:ListItem>
                    <asp:ListItem>Low</asp:ListItem>
                    <asp:ListItem>Medium</asp:ListItem>
                    <asp:ListItem>High</asp:ListItem>
                    <asp:ListItem>Critical</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td colspan="7">
                <asp:Button ID="ButtonAddSeverity" runat="server" Text="Add Severity" />
            </td>


        </tr>

        <tr>
            <td colspan="6" class="auto-style10"></td>

            <td colspan="2"></td>
            <td colspan="7">
                <asp:Button ID="ButtonRemoveSeverity" runat="server" Text="Remove Severity" />
            </td>

        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style10">Description<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="4" class="auto-style10"><span class="auto-style3">
                <asp:TextBox ID="TextBoxDescription" runat="server" TextMode="MultiLine" Height="130px" Width="270px"></asp:TextBox>
            </span></td>
            <td colspan="1" class="auto-style10">Priority<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
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
            <td colspan="6">&nbsp;</td>
            <td colspan="2"></td>
            <td colspan="7">
                <asp:Button ID="ButtonRemovePriority" runat="server" Text="Remove Priority" />
            </td>

        </tr>
        <tr>
            <td colspan="15"></td>
        </tr>
        <tr>
            <td colspan="5"></td>
            <td colspan="1">Status<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="2">
                <asp:DropDownList ID="DropDownListStatus" runat="server">
                    <asp:ListItem>Open</asp:ListItem>
                    <asp:ListItem>Closed</asp:ListItem>
                    <asp:ListItem>In Progress</asp:ListItem>
                    <asp:ListItem>Hold</asp:ListItem>
                    <asp:ListItem>Complete</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td colspan="5">
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
            <td colspan="1">Expected Completion Date<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="3">
                <asp:TextBox ID="TextBoxExpectedCompletionDate" runat="server"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:ImageButton ID="ImageButtonExpCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" OnClick="ImageButtonExpCompletionDate_Click" />
            </td>

            <td colspan="1">Status Description*:</td>
            <td colspan="9" class="auto-style11">
                <span class="auto-style3">
                    <asp:TextBox ID="TextBoxStatusDescription" runat="server" TextMode="MultiLine" Height="105px" Width="249px"></asp:TextBox>
                </span>
            </td>

        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">
                <asp:Calendar ID="CalendarExpCompletionDate" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Visible="False" Width="350px" OnSelectionChanged="CalendarExpCompletionDate_SelectionChanged">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            <td colspan="1"></td>
            <td colspan="1">Last Updated:</td>
            <td colspan="9"><span class="auto-style3">
                <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
            </span></td>
        </tr>

        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1">Date Raised<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="3"><span class="auto-style3">
                <asp:TextBox ID="TextBoxDateRaised" runat="server"></asp:TextBox>
            </span></td>
            <td colspan="1"><span class="auto-style3">
                <asp:ImageButton ID="ImageButtonDateRaised" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" OnClick="ImageButtonDateRaised_Click" />
            </span></td>
            <td colspan="1">Associated Action Item(s):</td>
            <td colspan="9">
                <asp:Button ID="ButtonAssociateActionItems" runat="server" Text="Associate Action Items" data-toggle="modal" data-target="#myModal2" OnClientClick="return false;" />

            </td>


        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">
                <asp:Calendar ID="CalendarDateRaised" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Visible="False" Width="350px" OnSelectionChanged="CalendarDateRaised_SelectionChanged">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            <td colspan="1"></td>
            <td colspan="10">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="GridViewActionItemScroll" visible="false">
                    <asp:GridView ID="GridViewAssociatedTasks" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="AssociatedActionItems" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" SortExpression="DateCreated" />
                            <asp:BoundField DataField="DateAssigned" HeaderText="DateAssigned" SortExpression="DateAssigned" />
                            <asp:BoundField DataField="ExpectedCompletionDate" HeaderText="ExpectedCompletionDate" SortExpression="ExpectedCompletionDate" />
                            <asp:BoundField DataField="ActualCompletionDate" HeaderText="ActualCompletionDate" SortExpression="ActualCompletionDate" />
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="StatusDescription" HeaderText="StatusDescription" SortExpression="StatusDescription" />
                            <asp:BoundField DataField="UpdateDate" HeaderText="UpdateDate" SortExpression="UpdateDate" />
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                </div>
                <asp:SqlDataSource ID="AssociatedActionItems" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [DateCreated], [DateAssigned], [ExpectedCompletionDate], [ActualCompletionDate], [Status], [StatusDescription], [UpdateDate], [AssociatedIssue] FROM [tblActionItems] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) AND ([AssociatedIssue] = @AssocIssueID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                        <asp:SessionParameter Name="AssocIssueID" SessionField="_CurrentIssueID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="15" class="auto-style2"></td>
        </tr>

        <tr>
            <td colspan="1">Date Assigned<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="3"><span class="auto-style3">
                <asp:TextBox ID="TextBoxDateAssigned" runat="server"></asp:TextBox>
            </span></td>
            <td colspan="1"><span class="auto-style3">
                <asp:ImageButton ID="ImageButtonDateAssigned" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" OnClick="ImageButtonDateAssigned_Click" />
            </span></td>
            <td colspan="1">Associated Decision(s):&nbsp;</td>
            <td colspan="9">
                <asp:Button ID="ButtonAssociateDecisions" runat="server" Text="Associate Decisions" data-toggle="modal" data-target="#myModal3" OnClientClick="return false;" />
            </td>

        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">
                <asp:Calendar ID="CalendarDateAssigned" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Visible="False" Width="350px" OnSelectionChanged="CalendarDateAssigned_SelectionChanged">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            <td colspan="1"></td>
            <td colspan="10">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="GridViewDecisionScroll" visible="false">
                    <asp:GridView ID="GridViewAssociatedDecisions" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="AssociatedDecisions" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />
                            <asp:BoundField DataField="Impact" HeaderText="Impact" SortExpression="Impact" />
                            <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" SortExpression="DateCreated" />
                            <asp:BoundField DataField="DateNeeded" HeaderText="DateNeeded" SortExpression="DateNeeded" />
                            <asp:BoundField DataField="DateMade" HeaderText="DateMade" SortExpression="DateMade" />
                            <asp:BoundField DataField="DecisionMaker" HeaderText="DecisionMaker" SortExpression="DecisionMaker" />
                            <asp:BoundField DataField="ExpectedCompletionDate" HeaderText="ExpectedCompletionDate" SortExpression="ExpectedCompletionDate" />
                            <asp:BoundField DataField="ActualCompletionDate" HeaderText="ActualCompletionDate" SortExpression="ActualCompletionDate" />
                            <asp:BoundField DataField="NoteDate" HeaderText="NoteDate" SortExpression="NoteDate" />
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="StatusDescription" HeaderText="StatusDescription" SortExpression="StatusDescription" />
                            <asp:BoundField DataField="UpdateDate" HeaderText="UpdateDate" SortExpression="UpdateDate" />
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="AssociatedDecisions" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [Priority], [Impact], [DateCreated], [DateNeeded], [DateMade], [DecisionMaker], [ExpectedCompletionDate], [ActualCompletionDate], [NoteDate], [Status], [StatusDescription], [UpdateDate] FROM [tblDecisions] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) AND ([AssociatedIssue] = @AssociatedIssue))">
                        <SelectParameters>
                            <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                            <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            <asp:SessionParameter Name="AssociatedIssue" SessionField="_CurrentIssueID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </td>
        </tr>

        <tr>
            <td colspan="15">&nbsp;</td>

        </tr>

        <tr>
            <td colspan="1">
                <asp:Label ID="LabelActualCompletionDate" runat="server" Text="Actual Completion Date: " Visible="False"></asp:Label>

            <td colspan="3">
                <asp:TextBox ID="TextBoxActualCompletionDate" runat="server" Visible="False"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:ImageButton ID="ImageButtonActCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" />
            </td>
            <td colspan="10">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">
                <asp:Calendar ID="CalendarActCompletionDate" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Visible="False" Width="350px" OnSelectionChanged="CalendarActCompletionDate_SelectionChanged">
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
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" Text="New" OnClick="ButtonNew_Click" />
            </td>
            <td colspan="4"></td>
            <td colspan="1">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" OnClick="ButtonDelete_Click" />
            </td>
            <td colspan="9">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" OnClick="ButtonSave_Click" />
            </td>
        </tr>




    </table>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .hiddencol {
            display: none;
        }

        .auto-style1 {
            color: #FF0000;
        }

        .auto-style2 {
            height: 20px;
        }

        .auto-style3 {
            color: #000000;
        }

        .auto-style10 {
            height: 26px;
        }

        .auto-style11 {
            width: 268435456px;
        }
    </style>
</asp:Content>


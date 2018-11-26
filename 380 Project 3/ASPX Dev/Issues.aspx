<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Issues.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Issues" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <asp:ScriptManager ID="toolScriptManager" runat="server">
    </asp:ScriptManager>

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
                        <asp:DropDownList ID="DropDownListIssuesSelect" runat="server" DataSourceID="DropDownListIssuesDB" DataTextField="Name" DataValueField="IssueID" Height="30px" Width="571px" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />

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
            <td colspan="1">Name:*</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxName" runat="server"></asp:TextBox>


                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" /></td>

            <td colspan="1">Severity*:</td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxSeverity" runat="server"></asp:TextBox>
            </td>

            <td colspan="1">
                <asp:Button ID="ButtonAddSeverity" runat="server" Text="Add Severity" OnClick="ButtonAddSeverity_Click" />
                <br />
                <br />
                <asp:Button ID="ButtonRemoveSeverity" runat="server" Text="Remove Severity" OnClick="ButtonRemoveSeverity_Click1" /></td>

            <td colspan="2" rowspan="2">
                <asp:ListBox ID="ListBoxSeverity" ClientIDMode="Static" runat="server" Height="89px" Width="245px" onchange="SeverityTextBoxJS(this)" DataSourceID="ListBoxSeverityDB" DataTextField="SeverityName" DataValueField="Sequence">
                </asp:ListBox>
                <asp:SqlDataSource ID="ListBoxSeverityDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [SeverityName], [Sequence] FROM [tblSeverity] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID)) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>

            <td colspan="1">
                <asp:ImageButton ID="ImageSeverityMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxSeverity', 'up'); return false;" />
                <br />
                <br />
                <asp:ImageButton ID="ImageButtonSeverityMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxSeverity', 'down'); return false;" />

            </td>
        </tr>


        <tr>
            <td colspan="11">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="11" class="auto-style2"></td>
        </tr>

        <tr>
            <td colspan="1" style="vertical-align: text-top">Description*:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDescription" runat="server" TextMode="MultiLine" Height="130px" Width="270px"></asp:TextBox></td>
            <td colspan="1" class="auto-style15">Priority<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxPriority" runat="server"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonAddPriority" runat="server" Text="Add Priority" OnClick="ButtonAddPriority_Click" />
                <br />
                <br />
                <asp:Button ID="ButtonRemovePriority" runat="server" Text="Remove Priority" OnClick="ButtonRemovePriority_Click" />
            </td>
            <td colspan="2" rowspan="2">
                <asp:ListBox ID="ListBoxPriority" ClientIDMode="Static" runat="server" Height="138px" Width="205px" onchange="PriorityTextBoxJS(this)" DataSourceID="ListBoxPriorityDB" DataTextField="PriorityName" DataValueField="Sequence">
                </asp:ListBox>


                <asp:SqlDataSource ID="ListBoxPriorityDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [PriorityName], [Sequence] FROM [tblPriority] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID)) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>


            </td>

            <td colspan="1">
                <asp:ImageButton ID="ImageButtonPriorityMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxPriority', 'up'); return false;" />
                <br />
                <br />
                <asp:ImageButton ID="ImageButtonPriorityMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxPriority', 'down'); return false;" />
            </td>
        </tr>

        <tr>
            <td colspan="11">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="11" class="auto-style2"></td>
        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="1">Status*:</td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxStatus" runat="server"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonAddStatus" runat="server" Text="Add Status" OnClick="ButtonAddStatus_Click" />
                <br />
                <br />
                <asp:Button ID="ButtonRemoveStatus" runat="server" Text="Remove Status" OnClick="ButtonRemoveStatus_Click" />

            </td>

            <td colspan="2" rowspan="2">
                <asp:ListBox ID="ListBoxStatus" ClientIDMode="Static" runat="server" Width="204px" Height="139px" onchange="StatusTextBoxJS(this)" DataSourceID="ListBoxStatusDB" DataTextField="StatusName" DataValueField="Sequence">
                </asp:ListBox>
                <asp:SqlDataSource ID="ListBoxStatusDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [StatusName], [Sequence] FROM [tblStatus] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID)) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td colspan="1">
                <asp:ImageButton ID="ImageButtonStatusMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxStatus', 'up'); return false;" />

                <br />
                <br />
                <asp:ImageButton ID="ImageButtonStatusMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxStatus', 'down'); return false;" />

            </td>
        </tr>

        <tr>
            <td colspan="11"></td>
        </tr>

        <tr>
            <td colspan="11"></td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">Expected Completion Date*:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpectedCompletionDate" runat="server" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpComplDate" PopupButtonID="ImageButtonExpCompletionDate" runat="server" TargetControlID="TextBoxExpectedCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" /></td>
            <td colspan="1" class="text-right" style="vertical-align: text-top">Status Description*:</td>
            <td colspan="5"><span class="auto-style3">
                <asp:TextBox ID="TextBoxStatusDescription" runat="server" TextMode="MultiLine" Height="105px" Width="249px"></asp:TextBox>
            </span>
            </td>

        </tr>
        <tr>
            <td colspan="5" class="auto-style1"></td>
            <td colspan="1">Last Updated:</td>
            <td colspan="5" class="auto-style1">
                <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="11"></td>
        </tr>

        <tr>
            <td colspan="1">Date Raised*:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDateRaised" runat="server" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarDateRaised" PopupButtonID="ImageButtonDateRaised" runat="server" TargetControlID="TextBoxDateRaised" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateRaised" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" /></td>
            <td colspan="1">Associated Action Item(s):</td>
            <td colspan="4">
                <asp:Button ID="ButtonAssociateActionItems" runat="server" Text="Associate Action Items" data-toggle="modal" data-target="#myModal2" OnClientClick="return false;" /></td>
        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="6">
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
            <td colspan="11"></td>
        </tr>

        <tr>
            <td colspan="1">Date Assigned*:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDateAssigned" runat="server" ReadOnly="True"></asp:TextBox>

                <cc1:CalendarExtender ID="CalendarDateAssigned" PopupButtonID="ImageButtonDateAssigned" runat="server" TargetControlID="TextBoxDateAssigned" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateAssigned" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" /></td>

            <td colspan="1">Associated Decision(s):</td>
            <td colspan="4">
                <asp:Button ID="ButtonAssociateDecisions" runat="server" Text="Associate Decisions" data-toggle="modal" data-target="#myModal3" OnClientClick="return false;" />
            </td>
        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="6">
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
                    <asp:SqlDataSource ID="AssociatedDecisions" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [Priority], [Impact],
                        [DateCreated], [DateNeeded], [DateMade], [ExpectedCompletionDate], [ActualCompletionDate], [NoteDate], [Status], [StatusDescription], [UpdateDate] FROM [tblDecisions] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) AND ([AssociatedIssue] = @AssociatedIssue))">
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
            <td colspan="11"></td>
        </tr>

        <tr>
            <td colspan="1">
                <asp:Label ID="LabelActualCompletionDate" runat="server" Text="Actual Completion Date: " Visible="False"></asp:Label></td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualCompletionDate" runat="server" Visible="False" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarActComplDate" PopupButtonID="ImageButtonActCompletionDate" runat="server" TargetControlID="TextBoxActualCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" /></td>
            <td colspan="6"></td>
        </tr>

        <tr>
            <td colspan="11"></td>
        </tr>

        <tr>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" Text="New" OnClick="ButtonNew_Click" />
            </td>
            <td colspan="4">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" OnClick="ButtonDelete_Click" />
            </td>
            <td colspan="6">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" OnClick="ButtonSave_Click" />
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function StatusTextBoxJS(ddl) {
            var tbStatus = document.getElementById('<%= TextBoxStatus.ClientID %>');

            if (tbStatus != null) {
                tbStatus.value = ddl.value;
            }
        }

        function PriorityTextBoxJS(ddl) {
            var tbPriority = document.getElementById('<%= TextBoxPriority.ClientID %>');

            if (tbPriority != null) {
                tbPriority.value = ddl.value;
            }
        }

        function SeverityTextBoxJS(ddl) {
            var tbSeverity = document.getElementById('<%= TextBoxSeverity.ClientID %>');

            if (tbSeverity != null) {
                tbSeverity.value = ddl.value;
            }
        }

        function listBoxMove(listBoxID, direction) {
            var listBox = document.getElementById(listBoxID);
            var selIndex = listBox.selectedIndex;
            if (-1 == selIndex) {
                alert("Please select an option to move.");
                return;
            }
            var increment = -1;
            if (direction == 'up')
                increment = -1;
            else
                increment = 1;

            if ((selIndex + increment) < 0 ||
                (selIndex + increment) > (listBox.options.length - 1)) {
                return;
            }

            var selValue = listBox.options[selIndex].value;
            var selText = listBox.options[selIndex].text;

            listBox.options[selIndex].value = listBox.options[selIndex + increment].value
            listBox.options[selIndex].text = listBox.options[selIndex + increment].text
            listBox.options[selIndex + increment].value = selValue;
            listBox.options[selIndex + increment].text = selText;
            listBox.selectedIndex = selIndex + increment;
        }
    </script>


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

        .auto-style15 {
            height: 26px;
            text-align: right;
        }
    </style>
</asp:Content>


<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="SummaryTasks.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.SummaryTasks" %>

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
                        <h4 class="modal-title">Search for Summary Tasks</h4>
                    </div>

                    <div class="modal-body">
                        Summary Tasks List:
                        <asp:DropDownList ID="DropDownListSummTaskSelect" runat="server" DataSourceID="DropDownListSummTaskDB" DataTextField="Name" DataValueField="TaskID" Height="30px" Width="571px" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />

                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListSummTaskDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [TaskID] FROM [tblTasks] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID) AND ([TaskType] = 'Summary Task')">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Summary Task" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
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
                        <h4 class="modal-title">Associate Predecessor Task</h4>
                    </div>

                    <div class="modal-body">
                        Tasks List:
                        <asp:DropDownList ID="DropDownListSetPredTask" runat="server" DataSourceID="DropDownListSetPredTaskDB" DataTextField="Name" DataValueField="TaskID" Height="30px" Width="571px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListSetPredTaskDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [TaskID] 
                            FROM [tblTasks] a WHERE ((a.UserID = @UserID) AND 
                            (a.ProjectID = @ProjectID) AND (a.TaskID &lt;&gt; @TaskID) AND 
                            NOT EXISTS(
                            SELECT [PredecessorTask], [SuccessorTask] FROM [tblTasks] b
                            WHERE a.TaskID = b.PredecessorTask
                            OR a.TaskID = b.SuccessorTask))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                <asp:ControlParameter ControlID="DropDownListSummTaskSelect" Name="TaskID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <hr />
                        Predecessor Task Dependency:
                        <asp:DropDownList ID="DropDownListPredDependency" runat="server" Height="16px" Width="140px">
                            <asp:ListItem>Finish to Start</asp:ListItem>
                            <asp:ListItem>Start to Start</asp:ListItem>
                            <asp:ListItem>Finish to Finish</asp:ListItem>
                            <asp:ListItem>Start to Finish</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSetPredTask" runat="server" Text="Set Predecessor Task" CssClass="btn btn-default" OnClick="ButtonModalSetPredTask_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>

                </div>
            </div>
        </div>

    </div>

    <div class="container3">
        <!-- Modal -->
        <div class="modal fade" id="myModal4" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Associate Successor Task</h4>
                    </div>

                    <div class="modal-body">
                        Tasks List:
                        <asp:DropDownList ID="DropDownListSetSuccTask" runat="server" DataSourceID="DropDownListSetSuccTaskDB" DataTextField="Name" DataValueField="TaskID" Height="30px" Width="571px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListSetSuccTaskDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [TaskID] 
                            FROM [tblTasks] a WHERE ((a.UserID = @UserID) AND 
                            (a.ProjectID = @ProjectID) AND (a.TaskID &lt;&gt; @TaskID) AND 
                            NOT EXISTS(
                            SELECT [PredecessorTask], [SuccessorTask] FROM [tblTasks] b
                            WHERE a.TaskID = b.PredecessorTask
                            OR a.TaskID = b.SuccessorTask))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                <asp:ControlParameter ControlID="DropDownListSummTaskSelect" Name="TaskID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <hr />
                        Successor Task Dependency:
                        <asp:DropDownList ID="DropDownListSuccDependency" runat="server" Height="16px" Width="140px">
                            <asp:ListItem>Finish to Start</asp:ListItem>
                            <asp:ListItem>Start to Start</asp:ListItem>
                            <asp:ListItem>Finish to Finish</asp:ListItem>
                            <asp:ListItem>Start to Finish</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSetSuccTask" runat="server" Text="Set Successor Task" CssClass="btn btn-default" OnClick="ButtonModalSetSuccTask_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>

                </div>
            </div>
        </div>

    </div>

    <div class="container3">
        <!-- Modal -->
        <div class="modal fade" id="myModal5" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Change Task Type</h4>
                    </div>

                    <div class="modal-body">
                        Tasks List:
                        <asp:DropDownList ID="DropDownListChangeTaskType" runat="server" DataSourceID="ChangeTaskTypeDB" DataTextField="Name" DataValueField="TaskID" Height="30px" Width="571px" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="ChangeTaskTypeDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [TaskID], [TaskType] FROM [tblTasks] WHERE ([UserID] = @UserID) AND 
                            ([ProjectID] = @ProjectID) AND ([TaskType] = 'Summary Task')">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <asp:Button ID="ButtonModalChangeTaskType" runat="server" Text="Change Task" CssClass="btn btn-default" OnClick="ButtonModalChangeTaskType_Click" UseSubmitBehavior="false" data-dismiss="modal" />
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
                        <h4 class="modal-title">Associate Issues</h4>
                    </div>

                    <div class="modal-body">
                        Issues List:
                <div style="overflow-y: scroll; height: 250px">
                    <asp:GridView ID="GridViewAssociateIssues" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IssueID" DataSourceID="GridViewAssociateIssueDS" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="IssueID" HeaderStyle-CssClass="hiddencol" HeaderText="IssueID" InsertVisible="False" ItemStyle-CssClass="hiddencol" ReadOnly="True" SortExpression="IssueID" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBoxAssociateIssue" runat="server" Checked='<%#Convert.ToBoolean(Eval("Checked")) %>' />
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
                        <asp:SqlDataSource ID="GridViewAssociateIssueDS" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [IssueID], [Name], 
                            CASE WHEN [AssociatedTask] is NULL THEN 0 ELSE 1 END AS [Checked] FROM [tblIssues] WHERE (([UserID] = @UserID) AND 
                            ([ProjectID] = @ProjectID) AND ([AssociatedTask] = @AssocTask OR [AssociatedTask] IS NULL))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                <asp:SessionParameter Name="AssocTask" SessionField="_CurrentTaskID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <asp:Button ID="ButtonModalAssociateIssue" runat="server" Text="Associate Issues" CssClass="btn btn-default" OnClick="ButtonModalAssociateIssue_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                </div>
            </div>

        </div>
    </div>

    <table style="width: 100%;">
        <tr>
            <td colspan="1" class="text-right">Name*:</td>
            <td colspan="3">
                <asp:TextBox ID="TextBoxName" runat="server" Width="300px" Height="20px"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" />
            </td>
            <td colspan="1" class="text-right">Resource Assigned:</td>
            <td colspan="5">
                <asp:DropDownList ID="DropDownListResourceAssigned" runat="server" DataSourceID="DropDownListRescDB" DataTextField="Name" DataValueField="ResourceID" Height="20px" Width="300px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="DropDownListRescDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [ResourceID] FROM [tblResources] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td colspan="2">&nbsp;<asp:Button ID="ButtonAddResource" runat="server" Text="Add New Resource" OnClick="ButtonAddResource_Click" />
            </td>
            <td colspan="6" class="text-left">&nbsp;</td>
        </tr>


        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>


        <tr>
            <td colspan="1" class="text-right" style="vertical-align: text-top">
            Description*:
           
            <td colspan="4">
                <asp:TextBox ID="TextBoxDescription" runat="server" Height="150px" MaxLength="1000" TextMode="MultiLine" Width="300px"></asp:TextBox>
            </td>

            <td colspan="6">&nbsp;</td>
            <td colspan="1">&nbsp;</td>
            <td colspan="13">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
            Expected Start Date*:
           
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpectedStartDate" runat="server" ReadOnly="True" Height="20px" Width="80px"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpStartDate" PopupButtonID="ImageButtonExpectedStartDate" runat="server" TargetControlID="TextBoxExpectedStartDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpectedStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Style="position: relative; top: 5px" />
            </td>
            <td colspan="1" class="text-right">Expected Due Date*:</td>
            <td colspan="5" class="auto-style3">
                <asp:TextBox ID="TextBoxExpectedDueDate" runat="server" Width="202px" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpDueDate" PopupButtonID="ImageButtonExpectedDueDate" runat="server" TargetControlID="TextBoxExpectedDueDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpectedDueDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
            </td>
            <td colspan="1" class="text-right">Set Predecessor Task:</td>
            <td colspan="1" class="auto-style3">
                <asp:TextBox ID="TextBoxPredecessorTask" runat="server" ReadOnly="True"></asp:TextBox>
            </td>
            <td colspan="5" class="auto-style5">
                <asp:Button ID="ButtonPredecessorTask" runat="server" Text="Select Predecessor Task" data-toggle="modal" data-target="#myModal3" OnClientClick="return false;" />
            </td>
        </tr>

        <tr>
            <td colspan="18" class="auto-style4"></td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">ExpectExpected Duration:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpectedDuration" runat="server" Height="20px" Width="80px"></asp:TextBox>
            </td>
            <td colspan="6">&nbsp;</td>
            <td colspan="1" class="text-right">Set Successor Task:</td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxSuccessorTask" runat="server" ReadOnly="True"></asp:TextBox>
            </td>
            <td colspan="6" class="text-left">
                <asp:Button ID="ButtonSuccessorTask" runat="server" Text="Select Successor Task" data-toggle="modal" data-target="#myModal4" OnClientClick="return false;" />
            </td>
        </tr>

        <tr>
            <td colspan="18" class="auto-style6"></td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
            Expected Effort:
           
            <td colspan="17">
                <asp:TextBox ID="TextBoxExpectedEffort" runat="server" Height="20px" Width="80px"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">Percent Complete:</td>
            <td colspan="4">&nbsp;</td>
            <td colspan="13"></td>
        </tr>

        <tr>
            <td colspan="18" class="text-right"></td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelActualStartDate" runat="server" Text="Actual Start Date:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualStartDate" runat="server" Width="80px" Visible="False" ReadOnly="True" Height="20px"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarActStartDate" PopupButtonID="ImageButtonActualStartDate" runat="server" TargetControlID="TextBoxActualStartDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActualStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" />
            </td>
            <td colspan="1" class="text-right">Associate Issues:</td>
            <td colspan="5">
                <asp:Button ID="ButtonAssociateIssues" runat="server" Text="Associate Issues" data-toggle="modal" data-target="#myModal2" OnClientClick="return false;" OnClick="ButtonAssociateIssues_Click" />
            </td>

            <td colspan="1" class="text-right">&nbsp;</td>
            <td colspan="6" class="text-left">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelActualEndDate" runat="server" Text="Actual End Date:" Visible="False"></asp:Label>
            </td>
            <td colspan="4" class="auto-style3">
                <asp:TextBox ID="TextBoxActualEndDate" runat="server" Width="192px" Visible="False" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="Calendar1" PopupButtonID="ImageButtonActualEndDate" runat="server" TargetControlID="TextBoxActualEndDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActualEndDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" />
            </td>
            <td colspan="13" class="auto-style1">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="Div1">
                    <asp:GridView ID="GridViewAssociatedIssues" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewAssociatedIssuesDS" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />
                            <asp:BoundField DataField="Severity" HeaderText="Severity" SortExpression="Severity" />
                            <asp:BoundField DataField="DateRaised" HeaderText="DateRaised" SortExpression="DateRaised" />
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
                <asp:SqlDataSource ID="GridViewAssociatedIssuesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [Priority], [Severity], [DateRaised], [DateAssigned], [ExpectedCompletionDate], [ActualCompletionDate], [Status], [StatusDescription], [UpdateDate] FROM [tblIssues] WHERE (([AssociatedTask] = @AssociatedTask) AND ([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="AssociatedTask" SessionField="_CurrentTaskID" Type="Int32" />
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="GridViewAssociatedTaskDS" runat="server"></asp:SqlDataSource>
            </td>


        </tr>
        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelActualDuration" runat="server" Text="Actual Duration:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualDuration" runat="server" Visible="False" Height="20px" Width="80px"></asp:TextBox>
            </td>
            <td colspan="1" class="text-left">List of Task(s):</td>
            <td colspan="12"></td>
        </tr>

        <tr>
            <td colspan="5">&nbsp;</td>
            <td colspan="13">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="id_GridviewScroll">
                    <asp:GridView ID="GridViewTaskList" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataSourceID="GridTasks">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="TaskType" HeaderText="TaskType" SortExpression="TaskType" />
                            <asp:BoundField DataField="ExpectedStartDate" HeaderText="ExpectedStartDate" SortExpression="ExpectedStartDate" />
                            <asp:BoundField DataField="ExpectedDuration" HeaderText="ExpectedDuration" SortExpression="ExpectedDuration" />
                            <asp:BoundField DataField="ExpectedEffort" HeaderText="ExpectedEffort" SortExpression="ExpectedEffort" />
                            <asp:BoundField DataField="ActualStartDate" HeaderText="ActualStartDate" SortExpression="ActualStartDate" />
                            <asp:BoundField DataField="ActualEndDate" HeaderText="ActualEndDate" SortExpression="ActualEndDate" />
                            <asp:BoundField DataField="ActualDuration" HeaderText="ActualDuration" SortExpression="ActualDuration" />
                            <asp:BoundField DataField="EffortCompleted" HeaderText="EffortCompleted" SortExpression="EffortCompleted" />
                            <asp:BoundField DataField="ActualEffort" HeaderText="ActualEffort" SortExpression="ActualEffort" />
                            <asp:BoundField DataField="ExpectedEndDate" HeaderText="ExpectedEndDate" SortExpression="ExpectedEndDate" />
                            <asp:BoundField DataField="PredecessorTask" HeaderText="PredecessorTask" SortExpression="PredecessorTask" />
                            <asp:BoundField DataField="PredecessorDependency" HeaderText="PredecessorDependency" SortExpression="PredecessorDependency" />
                            <asp:BoundField DataField="SuccessorTask" HeaderText="SuccessorTask" SortExpression="SuccessorTask" />
                            <asp:BoundField DataField="SuccessorDependency" HeaderText="SuccessorDependency" SortExpression="SuccessorDependency" />
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
                <asp:SqlDataSource ID="GridTasks" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [TaskType], [ExpectedStartDate], [ExpectedDuration], [ExpectedEffort], [ActualStartDate], [ActualEndDate], [ActualDuration], [EffortCompleted], [ActualEffort], [ExpectedEndDate], [PredecessorTask], [PredecessorDependency], [SuccessorTask], [SuccessorDependency] FROM [tblTasks] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>


        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelActualEffort" runat="server" Text="Actual Effort:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualEffort" runat="server" Visible="False"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonChangeTaskType" runat="server" Text="Change Task Type" data-toggle="modal" data-target="#myModal5" OnClientClick="return false;" OnClick="ButtonChangeTaskType_Click" />
            </td>
            <td colspan="1" class="text-center">
                <asp:Button ID="ButtonGroupTasks" runat="server" Text="Group Tasks" />
            </td>
            <td colspan="11"></td>
        </tr>

        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="6">
                <asp:Button ID="ButtonNew" runat="server" Text="New" Width="101px" OnClick="ButtonNew_Click" />
            </td>
            <td colspan="3">
                <asp:Button ID="ButtonGantt" runat="server" Text="Gantt Chart" Visible="False" />
            </td>
            <td colspan="4">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" Width="96px" OnClick="ButtonDelete_Click" Visible="False" />

            </td>
            <td colspan="5" class="text-right">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="131px" OnClick="ButtonSave_Click" Visible="False" /></td>
        </tr>

    </table>

</asp:Content>


<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .auto-style1 {
            text-align: right;
            height: 40px;
        }

        .auto-style3 {
            text-align: left;
            height: 40px;
        }

        .auto-style4 {
            text-align: right;
            height: 11px;
        }

        .auto-style5 {
            text-align: left;
            height: 27px;
        }

        .auto-style6 {
            text-align: right;
            height: 20px;
        }
    </style>
</asp:Content>







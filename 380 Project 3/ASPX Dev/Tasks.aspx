<%@ Page Language="C#" MasterPageFile="siteMaster.Master" AutoEventWireup="true" CodeBehind="Tasks.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Tasks" %>

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
                        <h4 class="modal-title">Search for Tasks</h4>
                    </div>

                    <div class="modal-body">
                        Tasks List:
                        <asp:DropDownList ID="DropDownListTaskSelect" runat="server" DataSourceID="DropDownListTaskDB" DataTextField="Name" DataValueField="TaskID" Height="30px" Width="571px" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListTaskDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [TaskID] FROM [tblTasks] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID) AND ([TaskType] = 'Task')">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Task" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
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
                        <h4 class="modal-title">Search for Resource</h4>
                    </div>

                    <div class="modal-body">
                        Resource List:
                        <asp:DropDownList ID="DropDownListResourceSelect" runat="server" DataSourceID="DropDownListResourceDB" DataTextField="Name" DataValueField="ResourceID" Height="30px" Width="571px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListResourceDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [ResourceID] FROM [tblResources] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalAssignResrc" runat="server" Text="Assign Resource" CssClass="btn btn-default" OnClick="ButtonModalResource_Click" UseSubmitBehavior="false" data-dismiss="modal" />
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
                                <asp:ControlParameter ControlID="DropDownListTaskSelect" Name="TaskID" PropertyName="SelectedValue" Type="Int32" />
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
                                <asp:ControlParameter ControlID="DropDownListTaskSelect" Name="TaskID" PropertyName="SelectedValue" Type="Int32" />
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




    <table style="width: 100%;">
        <tr>
            <td colspan="1" class="text-right">Name*:</td>
            <td colspan="3">
                <asp:TextBox ID="TextBoxName" runat="server" Width="315px"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" />
            </td>
            <td colspan="6"></td>
            <td colspan="1">Resource Assigned:</td>
            <td colspan="1"></td>
            <td colspan="6" class="text-left">
                <asp:Button ID="ButtonAddResource" runat="server" data-toggle="modal" data-target="#myModal2" Text="Add New Resource" OnClientClick="return false;" />
            </td>
        </tr>


        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>


        <tr>
            <td colspan="1" class="text-right" style="vertical-align: text-top">Description*:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDescription" runat="server" Height="168px" MaxLength="1000" TextMode="MultiLine" Width="351px"></asp:TextBox>
            </td>

            <td colspan="6">&nbsp;</td>
            <td colspan="1">&nbsp;</td>
            <td colspan="13">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style3">
            Expected Start Date*:
           
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpectedStartDate" runat="server" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpStartDate" PopupButtonID="ImageButtonExpectedStartDate" runat="server" TargetControlID="TextBoxExpectedStartDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpectedStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Style="position: relative; top: 5px" />
            </td>
            <td colspan="1" class="auto-style4">Expected Due Date*:</td>
            <td colspan="5" class="auto-style3">
                <asp:TextBox ID="TextBoxExpectedDueDate" runat="server" Width="202px" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpDueDate" PopupButtonID="ImageButtonExpectedDueDate" runat="server" TargetControlID="TextBoxExpectedDueDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpectedDueDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
            </td>
            <td colspan="1" class="auto-style3">Set Predecessor Task:</td>
            <td colspan="1" class="auto-style3">
                <asp:TextBox ID="TextBoxPredecessorTask" runat="server" ReadOnly="True"></asp:TextBox>
            </td>
            <td colspan="5" class="auto-style5">
                <asp:Button ID="ButtonPredecessorTask" runat="server" Text="Select Predecessor Task" data-toggle="modal" data-target="#myModal3" OnClientClick="return false;" />
            </td>
        </tr>
        <tr>
            <td colspan="1" class="auto-style2"></td>
            <td colspan="3" class="auto-style2"></td>
            <td colspan="2" class="auto-style2"></td>
            <td colspan="12" class="auto-style2"></td>
        </tr>

        <tr>
            <td colspan="18" class="auto-style1"></td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">ExpectExpected Duration:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpectedDuration" runat="server"></asp:TextBox>
            </td>
            <td colspan="6">&nbsp;</td>
            <td colspan="1">Set Successor Task:</td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxSuccessorTask" runat="server" ReadOnly="True"></asp:TextBox>
            </td>
            <td colspan="6" class="text-left">
                <asp:Button ID="ButtonSuccessorTask" runat="server" Text="Select Successor Task" data-toggle="modal" data-target="#myModal4" OnClientClick="return false;" />
            </td>
        </tr>

        <tr>
            <td colspan="18" class="auto-style1"></td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
            Expected Effort:
           
            <td colspan="17">
                <asp:TextBox ID="TextBoxExpectedEffort" runat="server"></asp:TextBox>
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
            <td colspan="18">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelActualStartDate" runat="server" Text="Actual Start Date:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualStartDate" runat="server" Width="107px" Visible="False" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarActStartDate" PopupButtonID="ImageButtonActualStartDate" runat="server" TargetControlID="TextBoxActualStartDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActualStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" />
            </td>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelActualEndDate" runat="server" Text="Actual End Date:" Visible="False"></asp:Label>
            </td>
            <td colspan="5">
                <asp:TextBox ID="TextBoxActualEndDate" runat="server" Width="192px" Visible="False" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="Calendar1" PopupButtonID="ImageButtonActualEndDate" runat="server" TargetControlID="TextBoxActualEndDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActualEndDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" />
            </td>

            <td colspan="1">Associate Issues:</td>
            <td colspan="6" class="text-left">
                <asp:Button ID="ButtonAssociateIssues" runat="server" Text="Associate Issues" />
            </td>
        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">&nbsp;</td>
            <td colspan="2"></td>
            <td colspan="10">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelActualDuration" runat="server" Text="Actual Duration:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualDuration" runat="server" Visible="False"></asp:TextBox>
            </td>
            <td colspan="13">List of Task(s):</td>
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
                <asp:Button ID="ButtonChangeTaskType" runat="server" Text="Change Task Type" />
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
            height: 20px;
        }

        .auto-style2 {
            height: 19px;
        }

        .auto-style3 {
            height: 23px;
        }

        .auto-style4 {
            text-align: right;
            height: 23px;
        }

        .auto-style5 {
            text-align: left;
            height: 23px;
        }
    </style>
</asp:Content>



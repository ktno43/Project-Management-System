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
                        <asp:DropDownList ID="DropDownListChangeTaskType" runat="server" DataSourceID="DropDownListTaskDB" DataTextField="Name" DataValueField="TaskID" Height="30px" Width="571px" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="ChangeTaskTypeDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [TaskID], [TaskType] FROM [tblTasks] WHERE ([UserID] = @UserID) AND 
                            ([ProjectID] = @ProjectID) AND ([TaskType] = 'Task')">
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


    <div class="container2">
        <!-- Modal -->
        <div class="modal fade" id="myModal6" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Associate a Resource</h4>
                    </div>

                    <div class="modal-body">
                        Resources List:
                               <div style="overflow-y: scroll; height: 250px">
                                   <asp:GridView ID="GridViewAssociateResource" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSourceAssociateResource" ForeColor="#333333" GridLines="None" Width="472px" DataKeyNames="ResourceID">
                                       <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                       <Columns>
                                           <asp:BoundField DataField="ResourceID" HeaderText="ResourceID" InsertVisible="False" ReadOnly="True" SortExpression="ResourceID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                           <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                           <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                           <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                                           <asp:BoundField DataField="ListOfSkills" HeaderText="List Of Skills" SortExpression="ListOfSkills" />
                                           <asp:BoundField DataField="PayRate" HeaderText="Pay Rate" SortExpression="PayRate" />
                                           <asp:BoundField DataField="AvailableStartDate" HeaderText="Available Start Date" SortExpression="AvailableStartDate" />
                                           <asp:BoundField DataField="AvailableEndDate" HeaderText="Available End Date" SortExpression="AvailableEndDate" />
                                           <asp:TemplateField>
                                               <ItemTemplate>
                                                   <asp:RadioButton ID="RadioButtonResource" runat="server" OnClick="checkRadioBtn(this.id)" Checked='<%#Convert.ToBoolean(Eval("Checked")) %>' />
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
                        <asp:SqlDataSource ID="SqlDataSourceAssociateResource" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [ResourceID], [Name], 
                            [Description], [Title], [ListOfSkills], [PayRate], [AvailableStartDate], [AvailableEndDate], CASE WHEN [AssociatedTask] is NULL THEN 0 ELSE 1 END AS [Checked]
                            FROM [tblResources] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) AND ([AssociatedTask] = @AssociatedTask OR [AssociatedTask] IS NULL))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                <asp:SessionParameter Name="AssociatedTask" SessionField="_CurrentTaskID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalAssociateResource" runat="server" Text="Associate Resource" CssClass="btn btn-default" OnClick="ButtonModalAssociateResource_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>
            </div>

        </div>
    </div>





    <table style="width: 100%;">
        <tr>
            <td colspan="1" class="auto-style25">Name*:</td>
            <td colspan="3">
                <asp:TextBox ID="TextBoxName" runat="server" Width="300px" Height="20px" TabIndex="1"></asp:TextBox>
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" />
            </td>
            <td colspan="1" class="auto-style12">&nbsp;</td>
            <td colspan="1" class="auto-style13">Resource Assigned:</td>
            <td colspan="5" class="auto-style7">
                <asp:TextBox ID="TextBoxResourceAssigned" runat="server" Width="100px" ReadOnly="True"></asp:TextBox>
                <asp:Button ID="ButtonSelectResource" runat="server" Text="Select Resource" Width="125px" data-toggle="modal" data-target="#myModal6" OnClientClick="return false;" />
            </td>
            <td colspan="2">&nbsp;<asp:Button ID="ButtonAddResource" runat="server" Text="Add New Resource" OnClick="ButtonAddResource_Click" TabIndex="14" />
            </td>
            <td colspan="6" class="auto-style14">&nbsp;</td>
        </tr>


        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>


        <tr>
            <td colspan="1" class="auto-style25" style="vertical-align: text-top">
            Description*:
           
            <td colspan="4">
                <asp:TextBox ID="TextBoxDescription" runat="server" Height="150px" MaxLength="1000" TextMode="MultiLine" Width="300px" TabIndex="3"></asp:TextBox>
            </td>

            <td colspan="6"></td>
            <td colspan="1" class="auto-style15">&nbsp;</td>
            <td colspan="13">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style26">
            Expected Start Date*:
           
            <td colspan="4" class="auto-style27">
                <asp:TextBox ID="TextBoxExpectedStartDate" runat="server" Height="20px" Width="80px" onchange="fnOnDateChange()"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpStartDate" PopupButtonID="ImageButtonExpectedStartDate" runat="server" TargetControlID="TextBoxExpectedStartDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpectedStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Style="position: relative; top: 5px" TabIndex="4" />
            </td>
            <td colspan="1" class="auto-style16">Expected Due Date*:</td>
            <td colspan="5" class="auto-style8">
                <asp:TextBox ID="TextBoxExpectedDueDate" runat="server" Width="80px" onchange="fnOnDateChange()" Height="20px"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpDueDate" PopupButtonID="ImageButtonExpectedDueDate" runat="server" TargetControlID="TextBoxExpectedDueDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpectedDueDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="5" />
            </td>
            <td colspan="1" class="auto-style4">Set Predecessor Task:</td>
            <td colspan="1" class="auto-style3">
                <asp:TextBox ID="TextBoxPredecessorTask" runat="server" ReadOnly="True" Height="20px" Width="100px"></asp:TextBox>
            </td>
            <td colspan="5" class="auto-style5">
                <asp:Button ID="ButtonPredecessorTask" runat="server" Text="Select Predecessor Task" data-toggle="modal" data-target="#myModal3" OnClientClick="return false;" TabIndex="15" Width="175px" />
            </td>
        </tr>

        <tr>
            <td colspan="11" class="auto-style4"></td>
            <td colspan="1" class="text-right">Predecessor Dependency:
                
            </td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxPredDepend" runat="server" ReadOnly="True"></asp:TextBox></td>
            <td colspan="5">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="18" class="auto-style1">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style25">Expected Duration:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpectedDuration" runat="server" Height="20px" Width="80px" TabIndex="6"></asp:TextBox>
                &nbsp;days</td>
            <td colspan="6">&nbsp;</td>
            <td colspan="1" class="auto-style17">Set Successor Task:</td>
            <td colspan="1" class="auto-style18">
                <asp:TextBox ID="TextBoxSuccessorTask" runat="server" ReadOnly="True" Height="20px" Width="100px"></asp:TextBox>
            </td>
            <td colspan="6" class="auto-style14">
                <asp:Button ID="ButtonSuccessorTask" runat="server" Text="Select Successor Task" data-toggle="modal" data-target="#myModal4" OnClientClick="return false;" TabIndex="16" Width="175px" />
            </td>
        </tr>

        <tr>
            <td colspan="11" class="auto-style6"></td>
            <td colspan="1" class="text-right">Successor Dependency:</td>
            <td colspan="6">
                <asp:TextBox ID="TextBoxSuccDepend" runat="server" ReadOnly="True"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="18" class="auto-style1"></td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style25">
            Expected Effort:
           
            <td colspan="17">
                <asp:TextBox ID="TextBoxExpectedEffort" runat="server" Height="20px" Width="80px" TabIndex="7"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="18" class="auto-style1"></td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style25">Percent Complete:</td>
            <td colspan="4">&nbsp;</td>
            <td colspan="13"></td>
        </tr>

        <tr>
            <td colspan="18" class="auto-style1"></td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style25">
                <asp:Label ID="LabelActualStartDate" runat="server" Text="Actual Start Date:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualStartDate" runat="server" Width="80px" Visible="False" Height="20px" onchange="fnOnDateChangeAct()"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarActStartDate" PopupButtonID="ImageButtonActualStartDate" runat="server" TargetControlID="TextBoxActualStartDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActualStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" TabIndex="8" />
            </td>
            <td colspan="1" class="auto-style13">Associate Issues:</td>
            <td colspan="5" class="auto-style7">
                <asp:Button ID="ButtonAssociateIssues" runat="server" Text="Associate Issues" data-toggle="modal" data-target="#myModal2" OnClientClick="return false;" OnClick="ButtonAssociateIssues_Click" TabIndex="17" />
            </td>

            <td colspan="1" class="auto-style17">&nbsp;</td>
            <td colspan="6" class="text-left">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style25">
                <asp:Label ID="LabelActualEndDate" runat="server" Text="Actual End Date:" Visible="False"></asp:Label>
            </td>
            <td colspan="4" class="auto-style1">
                <asp:TextBox ID="TextBoxActualEndDate" runat="server" Width="80px" Visible="False" Height="20px" onchange="fnOnDateChangeAct()"></asp:TextBox>
                <cc1:CalendarExtender ID="Calendar1" PopupButtonID="ImageButtonActualEndDate" runat="server" TargetControlID="TextBoxActualEndDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActualEndDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" TabIndex="9" />
            </td>
            <td colspan="13" class="auto-style1">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="Div1">
                    <asp:GridView ID="GridViewAssociatedIssues" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewAssociatedIssuesDS" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="Pri" HeaderText="Priority" SortExpression="Priority" />
                            <asp:BoundField DataField="Sev" HeaderText="Severity" SortExpression="Severity" />
                            <asp:BoundField DataField="DateRaised" HeaderText="Date Raised" SortExpression="DateRaised" />
                            <asp:BoundField DataField="DateAssigned" HeaderText="Date Assigned" SortExpression="DateAssigned" />
                            <asp:BoundField DataField="ExpectedCompletionDate" HeaderText="Expected Completion Date" SortExpression="ExpectedCompletionDate" />
                            <asp:BoundField DataField="ActualCompletionDate" HeaderText="Actual Completion Date" SortExpression="ActualCompletionDate" />
                            <asp:BoundField DataField="Stat" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="StatusDescription" HeaderText="Status Description" SortExpression="StatusDescription" />
                            <asp:BoundField DataField="UpdateDate" HeaderText="Update Date" SortExpression="UpdateDate" />
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
                <asp:SqlDataSource ID="GridViewAssociatedIssuesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand=
                    "SELECT I.[Name], I.[Description], I.[DateRaised], I.[DateAssigned], I.[ExpectedCompletionDate], I.[ActualCompletionDate], 
                    I.[StatusDescription], I.[UpdateDate], P.[PriorityName] Pri, V.[SeverityName] Sev, S.[StatusName] Stat 
                    FROM [tblIssues] I
                    LEFT JOIN [tblPriority] P ON P.[Sequence] = I.[Priority]
                    LEFT JOIN [tblSeverity] V ON V.[Sequence] = I.[Severity]
                    LEFT JOIN [tblStatus] S ON S.[Sequence] = I.[Status]
                    WHERE ((I.[AssociatedTask] = @AssociatedTask) AND (I.[UserID] = @UserID) AND (I.[ProjectID] = @ProjectID))">
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
            <td colspan="1" class="auto-style25">
                <asp:Label ID="LabelActualDuration" runat="server" Text="Actual Duration:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualDuration" runat="server" Visible="False" Height="20px" Width="80px" TabIndex="10"></asp:TextBox>
                &nbsp;<asp:Label ID="LabelDays" runat="server" Text="days" Visible="False"></asp:Label>
            </td>
            <td colspan="1" class="auto-style19">List of Task(s):</td>
            <td colspan="12"></td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelEffortCompleted" runat="server" Text="Effort Completed:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxEffortCompleted" runat="server" Visible="False" Height="20px" Width="80px" TabIndex="10"></asp:TextBox>
            </td>
            <td colspan="13">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="id_GridviewScroll">
                    <asp:GridView ID="GridViewTaskList" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataSourceID="GridTasks">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="TaskType" HeaderText="Task Type" SortExpression="TaskType" />
                            <asp:BoundField DataField="ExpectedStartDate" HeaderText="Expected Start Date" SortExpression="ExpectedStartDate" />
                            <asp:BoundField DataField="ExpectedDuration" HeaderText="Expected Duration" SortExpression="ExpectedDuration" />
                            <asp:BoundField DataField="ExpectedEffort" HeaderText="Expected Effort" SortExpression="ExpectedEffort" />
                            <asp:BoundField DataField="ActualStartDate" HeaderText="Actual Start Date" SortExpression="ActualStartDate" />
                            <asp:BoundField DataField="ActualEndDate" HeaderText="Actual End Date" SortExpression="ActualEndDate" />
                            <asp:BoundField DataField="ActualDuration" HeaderText="Actual Duration" SortExpression="ActualDuration" />
                            <asp:BoundField DataField="EffortCompleted" HeaderText="Effort Completed" SortExpression="EffortCompleted" />
                            <asp:BoundField DataField="ActualEffort" HeaderText="Actual Effort" SortExpression="ActualEffort" />
                            <asp:BoundField DataField="ExpectedEndDate" HeaderText="Expected End Date" SortExpression="ExpectedEndDate" />
                            <asp:BoundField DataField="PredName" HeaderText="Predecessor Task" SortExpression="PredecessorTask" />
                            <asp:BoundField DataField="PredecessorDependency" HeaderText="Predecessor Dependency" SortExpression="PredecessorDependency" />
                            <asp:BoundField DataField="SuccName" HeaderText="Successor Task" SortExpression="SuccessorTask" />
                            <asp:BoundField DataField="SuccessorDependency" HeaderText="Successor Dependency" SortExpression="SuccessorDependency" />
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
                <asp:SqlDataSource ID="GridTasks" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand=
                    "SELECT T.[Name], T.[Description], T.[TaskType], T.[ExpectedStartDate], T.[ExpectedDuration], T.[ExpectedEffort], 
                    T.[ActualStartDate], T.[ActualEndDate], T.[ActualDuration], T.[EffortCompleted], T.[ActualEffort], T.[ExpectedEndDate], 
                    T.[PredecessorDependency], T.[SuccessorDependency], S.[Name] SuccName, P.[Name] PredName 
                    FROM [tblTasks] T
                    LEFT JOIN [tblTasks] S ON S.TaskID = T.SuccessorTask
                    LEFT JOIN [tblTasks] P ON P.TaskID = T.PredecessorTask
                    WHERE ((T.[UserID] = @UserID) AND (T.[ProjectID] = @ProjectID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>


        <tr>
            <td colspan="1" class="auto-style25">
                <asp:Label ID="LabelActualEffort" runat="server" Text="Actual Effort:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualEffort" runat="server" Visible="False" Height="20px" TabIndex="11" Width="80px"></asp:TextBox>
            </td>
            <td colspan="1" class="auto-style20">
                <asp:Button ID="ButtonChangeTaskType" runat="server" Text="Change Task Type" data-toggle="modal" data-target="#myModal5" OnClientClick="return false;" TabIndex="18" />
            </td>
            <td colspan="1" class="auto-style21">
                <asp:Button ID="ButtonGroupTasks" runat="server" Text="Group Tasks" TabIndex="19" />
            </td>
            <td colspan="11"></td>
        </tr>

        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="6">
                <asp:Button ID="ButtonNew" runat="server" Text="New" Width="101px" OnClick="ButtonNew_Click" TabIndex="12" />
            </td>
            <td colspan="3">
                <asp:Button ID="ButtonGantt" runat="server" Text="Gantt Chart" Visible="False" TabIndex="20" />
            </td>
            <td colspan="4">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" Width="96px" OnClick="ButtonDelete_Click" Visible="False" />

            </td>
            <td colspan="5" class="auto-style22">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="131px" OnClick="ButtonSave_Click" Visible="False" TabIndex="21" /></td>
        </tr>

    </table>
    <script type="text/javascript">
        function checkRadioBtn(id) {
            var radioBtn = document.getElementById(id);
            var grid = document.getElementById('<%= GridViewAssociateResource.ClientID %>')
            var List = grid.getElementsByTagName("input");

            for (i = 0; i < List.length; i++) {
                if (List[i].type == "radio" && List[i].id != radioBtn.id) {
                    List[i].checked = false;
                }
            }
        }

        function fnOnDateChange() {
            var sStartDate = document.getElementById('<%= TextBoxExpectedStartDate.ClientID %>').value;
            var sDueDate = document.getElementById('<%= TextBoxExpectedDueDate.ClientID %>').value;


            if (sStartDate != null && sDueDate != null && sStartDate != '' && sDueDate != '') {
                var startDate = new Date(sStartDate);
                var dueDate = new Date(sDueDate);
                var timeDiff = Math.abs(dueDate.getTime() - startDate.getTime());
                var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
                document.getElementById('<%= TextBoxExpectedDuration.ClientID %>').value = diffDays;
            }
        }


        function fnOnDateChangeAct() {
            var sStartDate = document.getElementById('<%= TextBoxActualStartDate.ClientID %>').value;
            var sDueDate = document.getElementById('<%= TextBoxActualEndDate.ClientID %>').value;


            if (sStartDate != null && sDueDate != null && sStartDate != '' && sDueDate != '') {
                var startDate = new Date(sStartDate);
                var dueDate = new Date(sDueDate);
                var timeDiff = Math.abs(dueDate.getTime() - startDate.getTime());
                var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
                document.getElementById('<%= TextBoxActualDuration.ClientID %>').value = diffDays;
            }
        }

    </script>
</asp:Content>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .hiddencol {
            display: none;
        }

        .auto-style1 {
            height: 20px;
        }

        .auto-style3 {
            height: 23px;
            width: 40px;
        }

        .auto-style4 {
            text-align: right;
            height: 23px;
            width: 8%;
        }

        .auto-style5 {
            text-align: left;
            height: 23px;
            width: 17%;
        }

        .auto-style7 {
            width: 268435456px;
        }

        .auto-style8 {
            height: 23px;
            width: 268435456px;
        }

        .auto-style12 {
            width: 4%;
        }

        .auto-style13 {
            text-align: right;
            width: 13%;
        }

        .auto-style14 {
            text-align: left;
            width: 17%;
        }

        .auto-style15 {
            width: 8%;
        }

        .auto-style16 {
            text-align: right;
            height: 23px;
            width: 13%;
        }

        .auto-style17 {
            text-align: right;
            width: 8%;
        }

        .auto-style18 {
            width: 9%;
        }

        .auto-style19 {
            text-align: left;
            width: 13%;
        }

        .auto-style20 {
            width: 13%;
        }

        .auto-style21 {
            text-align: center;
            width: 22%;
        }

        .auto-style22 {
            text-align: right;
            width: 17%;
        }

        .auto-style25 {
            text-align: right;
            width: 100px;
        }
        .auto-style26 {
            text-align: right;
            width: 100px;
            height: 23px;
        }
        .auto-style27 {
            height: 23px;
        }
    </style>
</asp:Content>



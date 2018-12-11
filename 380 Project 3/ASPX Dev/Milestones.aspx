<%@ Page Language="C#" MasterPageFile="siteMaster.Master" AutoEventWireup="true" CodeBehind="Milestones.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Milestones" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


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
                        <h4 class="modal-title">Search for Milestones</h4>
                    </div>

                    <div class="modal-body">
                        Milestones List:
                        <asp:DropDownList ID="DropDownListMilestoneSelect" runat="server" DataSourceID="DropDownListMilestoneDB" DataTextField="Name" DataValueField="TaskID" Height="30px" Width="571px" AppendDataBoundItems="true">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListMilestoneDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [TaskID] FROM [tblTasks] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID) AND ([TaskType] = 'Milestone')">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Milestone" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
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
                                <asp:ControlParameter ControlID="DropDownListMilestoneSelect" Name="TaskID" PropertyName="SelectedValue" Type="Int32" />
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
                                <asp:ControlParameter ControlID="DropDownListMilestoneSelect" Name="TaskID" PropertyName="SelectedValue" Type="Int32" />
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
            <td colspan="1" class="auto-style23">Name<span class="auto-style2">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4" class="auto-style24">
                <asp:TextBox ID="TextBoxName" runat="server" Width="240px" Height="20px" TabIndex="1"></asp:TextBox>
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" Width="60px" />
            </td>

            <td colspan="1" class="auto-style25">
                <asp:Label ID="LabelPredTask" runat="server" Text="Predecessor Task:" Visible="False"></asp:Label>
                &nbsp;&nbsp;&nbsp;
            </td>
            <td colspan="1" class="auto-style24">
                <asp:TextBox ID="TextBoxPredTask" runat="server" ReadOnly="True" BackColor="#CCCCCC" Height="20px" Width="150px" Visible="False"></asp:TextBox>
                <asp:ImageButton ID="ImageButtonClearPred" runat="server" ImageUrl="~/Images/x.png" OnClick="ImageButtonClearPred_Click" Visible="False" Width="25px" />
            </td>
            <td colspan="1" class="auto-style24">
                <asp:Button ID="ButtonPredecessorTask" runat="server" Text="Select Predecessor Task" data-toggle="modal" data-target="#myModal3" OnClientClick="return false;" TabIndex="9" Width="175px" Visible="False" />
            </td>
            <td colspan="5" class="auto-style24"></td>
        </tr>


        <tr>
            <td colspan="5">&nbsp;</td>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelPredTaskDep" runat="server" Text="Predecessor Dependency:" Visible="False"></asp:Label>
                &nbsp;&nbsp;&nbsp; </td>
            <td colspan="1" class="auto-style14">
                <asp:TextBox ID="TextBoxPredDepen" runat="server" ReadOnly="True" BackColor="#CCCCCC" Height="20px" Width="150px" Visible="False"></asp:TextBox>
            </td>
            <td colspan="6"></td>
        </tr>
        <tr>
            <td colspan="13"></td>
        </tr>
        <tr>
            <td colspan="1" class="auto-style13" style="vertical-align: top">Description<span class="auto-style2">*</span>:&nbsp;&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDescription" runat="server" Height="150px" MaxLength="1000" TextMode="MultiLine" Width="300px" TabIndex="3"></asp:TextBox>
            </td>
            <td colspan="8">&nbsp;</td>
        </tr>

        <tr style="vertical-align: top">
            <td colspan="5" class="auto-style24"></td>
            <td colspan="1" class="auto-style25">&nbsp;&nbsp;&nbsp;
                <asp:Label ID="LabelSuccTask" runat="server" Text="Successor Task:" Visible="False"></asp:Label>
            </td>
            <td colspan="1" class="auto-style26">
                <asp:TextBox ID="TextBoxSuccTask" runat="server" ReadOnly="True" BackColor="#CCCCCC" Height="20px" Width="150px" Visible="False"></asp:TextBox>
                <asp:ImageButton ID="ImageButtonClearSuc" runat="server" ImageUrl="~/Images/x.png" OnClick="ImageButtonClearSuc_Click" Visible="False" Width="25px" />
            </td>
            <td colspan="1" class="auto-style24">
                <asp:Button ID="ButtonSuccessorTask" runat="server" Text="Select Successor Task" data-toggle="modal" data-target="#myModal4" OnClientClick="return false;" TabIndex="10" Width="175px" Visible="False" />
            </td>
            <td colspan="5" class="auto-style24"></td>
        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelSuccDep" runat="server" Text="Successor Dependency:" Visible="False"></asp:Label>
                &nbsp;&nbsp;&nbsp; </td>
            <td colspan="7">
                <asp:TextBox ID="TextBoxSuccDepen" runat="server" ReadOnly="True" BackColor="#CCCCCC" Height="20px" Width="150px" Visible="False"></asp:TextBox>
            </td>

        </tr>
        <tr>
            <td colspan="13">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style7">Expected Due Date<span class="auto-style2">*</span>
            :&nbsp;&nbsp;&nbsp;&nbsp;
           
            <td colspan="4" class="auto-style8">
                <asp:ScriptManager ID="toolScriptManager" runat="server">
                </asp:ScriptManager>
                <asp:TextBox ID="TextBoxExpectedDueDate" runat="server" Width="80px" Height="20px" BackColor="#CCCCCC"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpDueDate" PopupButtonID="ImageButtonExpectedDueDate" runat="server" TargetControlID="TextBoxExpectedDueDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpectedDueDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="4" />
            </td>

            <td colspan="8" class="auto-style9"></td>
        </tr>
        <tr>
            <td colspan="13" class="auto-style17"></td>
        </tr>

        <tr>
            <td colspan="13">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style13">Expected Effort<span class="auto-style2">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpectedEffort" runat="server" Height="20px" Width="80px" TabIndex="5"></asp:TextBox>
            </td>
            <td colspan="1" class="auto-style18" style="vertical-align: top">
                <asp:Label ID="LabelAssocIssue" runat="server" Text="Associated Issue(s):" Visible="False"></asp:Label>
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="ButtonAssociateIssues" runat="server" Text="Associate Issues" data-toggle="modal" data-target="#myModal2" OnClientClick="return false;" OnClick="ButtonAssociateIssues_Click" TabIndex="11" Visible="False" />

            </td>
            <td colspan="7">

                <br />


            </td>

        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="8">
                <div id="GridViewAssocIssueScrollID" runat="server" style="overflow: scroll; height: 250px; width: 800px" visible="false">
                    <br />
                    <asp:GridView ID="GridViewAssociatedIssue" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewAssociatedIssues" ForeColor="#333333" GridLines="None" Height="50px" Width="1750px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                                <ItemStyle Width="300px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DateRaised" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date Raised" SortExpression="DateRaised" />
                            <asp:BoundField DataField="DateAssigned" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date Assigned" SortExpression="DateAssigned" />
                            <asp:BoundField DataField="ExpectedCompletionDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Expected Completion Date" SortExpression="ExpectedCompletionDate" />
                            <asp:BoundField DataField="ActualCompletionDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Actual Completion Date" SortExpression="ActualCompletionDate" />
                            <asp:BoundField DataField="Sev" HeaderText="Severity" SortExpression="Severity" />
                            <asp:BoundField DataField="Pri" HeaderText="Priority" SortExpression="Priority" />
                            <asp:BoundField DataField="Stat" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="StatusDescription" HeaderText="Status Description" SortExpression="StatusDescription">
                                <ItemStyle Width="300px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="UpdateDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Update Date" SortExpression="UpdateDate" />
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
                <asp:SqlDataSource ID="GridViewAssociatedIssues" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT I.[Name], I.[Description], I.[DateRaised], I.[DateAssigned], I.[ExpectedCompletionDate], I.[ActualCompletionDate], 
                    I.[StatusDescription], I.[UpdateDate], P.[PriorityName] Pri, V.[SeverityName] Sev, S.[StatusName] Stat 
                    FROM [tblIssues] I
                    LEFT JOIN [tblPriorityIssues] P ON P.[Sequence] = I.[Priority] AND P.[AssociatedIssue] = I.[IssueID]
                    LEFT JOIN [tblSeverityIssues] V ON V.[Sequence] = I.[Severity] AND V.[AssociatedIssue] = I.[IssueID]
                    LEFT JOIN [tblStatusIssues] S ON S.[Sequence] = I.[Status] AND S.[AssociatedIssue] = I.[IssueID]
                    WHERE ((I.[AssociatedTask] = @AssociatedTask) AND (I.[UserID] = @UserID) AND (I.[ProjectID] = @ProjectID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                        <asp:SessionParameter Name="AssociatedTask" SessionField="_CurrentTaskID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="GridViewAssociatedTask" runat="server"></asp:SqlDataSource>
            </td>
        </tr>

        <tr>
            <td colspan="13">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="13">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="1" class="auto-style13">Percent Complete:</td>
            <td colspan="4">&nbsp;</td>
            <td colspan="8"></td>
        </tr>

        <tr>
            <td colspan="13">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style13">
                <asp:Label ID="LabelActualEndDate" runat="server" Text="Actual End Date:" Visible="False"></asp:Label>
                &nbsp;&nbsp;&nbsp;
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualEndDate" runat="server" Width="80px" Visible="False" Height="20px" BackColor="#CCCCCC"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarActEndDate" PopupButtonID="ImageButtonActualEndDate" runat="server" TargetControlID="TextBoxActualEndDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActualEndDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" TabIndex="6" />
                <asp:ImageButton ID="ImageButtonClearActDate" runat="server" ImageUrl="~/Images/x.png" OnClick="ImageButtonClearActDate_Click" Visible="False" Width="25px" />
            </td>
            <td colspan="1" class="auto-style22" style="vertical-align: top">List of Task(s):</td>
            <td colspan="7"></td>
        </tr>
        <tr>
            <td colspan="5">&nbsp;</td>
            <td colspan="8">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="id_GridviewScroll">
                    <asp:GridView ID="GridViewTaskList" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataSourceID="GridTasks" Height="50px" Width="2500px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                                <ItemStyle Width="300px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TaskType" HeaderText="Task Type" SortExpression="TaskType" />
                            <asp:BoundField DataField="ExpectedStartDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Expected Start Date" SortExpression="ExpectedStartDate" />
                            <asp:BoundField DataField="ExpectedEndDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Expected End Date" SortExpression="ExpectedEndDate" />
                            <asp:BoundField DataField="ExpectedDuration" HeaderText="Expected Duration" SortExpression="ExpectedDuration" />
                            <asp:BoundField DataField="ExpectedEffort" HeaderText="Expected Effort" SortExpression="ExpectedEffort" />
                            <asp:BoundField DataField="ActualStartDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Actual Start Date" SortExpression="ActualStartDate" />
                            <asp:BoundField DataField="ActualEndDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Actual End Date" SortExpression="ActualEndDate" />
                            <asp:BoundField DataField="ActualDuration" HeaderText="Actual Duration" SortExpression="ActualDuration" />
                            <asp:BoundField DataField="EffortCompleted" HeaderText="Effort Completed" SortExpression="EffortCompleted" />
                            <asp:BoundField DataField="ActualEffort" HeaderText="Actual Effort" SortExpression="ActualEffort" />
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
                <asp:SqlDataSource ID="GridTasks" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT T.[Name], T.[Description], T.[TaskType], T.[ExpectedStartDate], T.[ExpectedDuration], T.[ExpectedEffort], 
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
            <td colspan="5"></td>
            <td colspan="8">
                <asp:Button ID="ButtonGroupTasks" runat="server" Text="Group Tasks" Width="100px" TabIndex="12" /></td>
        </tr>

        <tr>
            <td colspan="13">&nbsp;</td>
        </tr>


        <tr>
            <td colspan="1" class="auto-style13">
                <asp:Label ID="LabelEffortCompleted" runat="server" Text="Effort Completed:" Visible="False"></asp:Label>
                &nbsp;&nbsp;&nbsp;
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxEffortCompleted" runat="server" Visible="False" Height="20px" Width="80px" TabIndex="10"></asp:TextBox>
            </td>
            <td colspan="1" class="auto-style19"></td>
            <td colspan="1" class="auto-style14">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="8">&nbsp;</td>


        </tr>
        <tr>
            <td colspan="1" class="auto-style13">
                <asp:Label ID="LabelActualEffort" runat="server" Text="Actual Effort:" Visible="False"></asp:Label>
                &nbsp;&nbsp;&nbsp;
            </td>
            <td colspan="17">
                <asp:TextBox ID="TextBoxActualEffort" runat="server" Visible="False" Height="20px" Width="80px" TabIndex="7"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="13" class="auto-style28">&nbsp;</td>

        </tr>
        <tr>
            <td colspan="1" class="auto-style15"></td>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" Text="New" Width="100px" OnClick="ButtonNew_Click" TabIndex="8" />
            </td>
            <td colspan="1"></td>
            <td colspan="1">&nbsp;</td>
            <td colspan="1">
                <asp:Button ID="ButtonGantt" runat="server" Text="Gantt Chart" Visible="False" Width="85px" TabIndex="13" />
            </td>
            <td colspan="1" class="auto-style19">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" Width="75px" OnClick="ButtonDelete_Click" Visible="False" />

            </td>
            <td colspan="1" class="auto-style14">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="125px" OnClick="ButtonSave_Click" Visible="False" TabIndex="14" />

            </td>
            <td colspan="1" class="text-center">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
        </tr>

    </table>

</asp:Content>





<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .hiddencol {
            display: none;
        }

        .auto-style2 {
            color: #FF0000;
        }

        .auto-style7 {
            text-align: right;
            height: 60px;
            width: 200px;
        }

        .auto-style8 {
            height: 60px;
        }

        .auto-style9 {
            text-align: right;
            height: 52px;
        }

        .auto-style13 {
            text-align: right;
            width: 200px;
        }


        .auto-style15 {
            width: 200px;
        }
        .auto-style17 {
            height: 39px;
        }
        .auto-style18 {
            text-align: right;
            height: 39px;
        }
        .auto-style19 {
            height: 35px;
        }
        .auto-style22 {
            text-align: left;
            height: 39px;
        }
        .auto-style23 {
            text-align: right;
            width: 200px;
            height: 40px;
        }
        .auto-style24 {
            height: 40px;
        }
        .auto-style25 {
            text-align: right;
            height: 40px;
        }
        .auto-style26 {
            text-align: left;
            height: 40px;
        }

    </style>
</asp:Content>







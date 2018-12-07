<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Deliverables.aspx.cs" Inherits="_380_Project_3.Deliverables" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <asp:ScriptManager ID="toolScriptManager" runat="server">
    </asp:ScriptManager>

    <style type="text/css">
        .hiddencol {
            display: none;
        }

        .auto-style8 {
            height: 60px;
        }

        .auto-style11 {
            height: 60px;
            text-align: left;
        }

        .auto-style14 {
            text-align: right;
            height: 30px;
            width: 200px;
        }

        .auto-style15 {
            height: 30px;
        }

        .auto-style17 {
            color: #FF0000;
        }

        .auto-style18 {
            height: 273px;
        }

        .auto-style19 {
            height: 60px;
            text-align: right;
            width: 200px;
        }

        .auto-style20 {
            text-align: right;
            width: 200px;
        }

        .auto-style22 {
            width: 200px;
        }
    </style>

    <div class="container">
        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Search for Deliverables</h4>
                    </div>

                    <div class="modal-body">
                        Deliverables List:
                        <asp:DropDownList ID="DropDownListDelivSelect" runat="server" DataSourceID="DropDownListDelivDB" DataTextField="Name" DataValueField="DeliverableID" Height="30px" Width="571px" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />
                        </asp:DropDownList>

                        <asp:SqlDataSource ID="DropDownListDelivDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [DeliverableID] FROM [tblDeliverables] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Deliverable" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
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
                        <h4 class="modal-title">Associate Tasks</h4>
                    </div>

                    <div class="modal-body">
                        Tasks List:
                                   <div style="overflow-y: scroll; height: 250px">
                                       <asp:GridView ID="GridViewAssociateTasks" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewAssociateTask" ForeColor="#333333" GridLines="None" Width="472px" DataKeyNames="TaskID">
                                           <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                           <Columns>
                                               <asp:BoundField DataField="TaskID" HeaderText="TaskID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                               <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                               <asp:BoundField DataField="TaskType" HeaderText="Task Type" SortExpression="TaskType" />
                                               <asp:TemplateField>
                                                   <ItemTemplate>
                                                       <asp:CheckBox ID="CheckBoxAssociateTask" runat="server" Checked='<%#Convert.ToBoolean(Eval("Checked")) %>' />
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
                        <asp:SqlDataSource ID="GridViewAssociateTask" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [TaskID], [Name], [TaskType], 
                            CASE WHEN [AssociatedDeliverable] is NULL THEN 0 ELSE 1 END AS [Checked] FROM [tblTasks] WHERE (([UserID] = @UserID) AND 
                            ([ProjectID] = @ProjectID) AND ([AssociatedDeliverable] = @AssocDeliv OR [AssociatedDeliverable] IS NULL))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                <asp:SessionParameter Name="AssocDeliv" SessionField="_CurrentDelivID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <asp:Button ID="Button1" runat="server" Text="Associate Tasks" CssClass="btn btn-default" OnClick="ButtonModalAssociateTask_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                </div>
            </div>

        </div>
    </div>

    <table style="width: 100%">
        <tr>
            <td colspan="1" class="auto-style19">Name<span class="auto-style17">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4" class="auto-style8">
                <asp:TextBox ID="TextBoxName" runat="server" Width="240px" Height="20px" TabIndex="1"></asp:TextBox>
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" CssClass="col-xs-offset-0" Width="60px" /></td>
            <td colspan="2" class="auto-style11">Associated Requirement(s):&nbsp;&nbsp;&nbsp; <asp:Button ID="ButtonReqs" runat="server" Text="Associate Requirements" Width="165px" TabIndex="7" />
            </td>

            <td colspan="7" class="auto-style8">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="14">&nbsp;</td>
        </tr>

        <tr style="vertical-align: top">
            <td colspan="1" class="auto-style20">Description<span class="auto-style17">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDescription" runat="server" Height="150px" MaxLength="1000" TextMode="MultiLine" Width="300px" TabIndex="3"></asp:TextBox>
            </td>
            <td colspan="2" class="text-right">&nbsp;</td>
            <td colspan="7" rowspan="2" class="text-left">
                <br />
                <br />

            </td>
        </tr>
        <tr>
            <td colspan="14">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="1" class="auto-style14">Start Date<span class="auto-style17">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4" class="auto-style15">

                <asp:TextBox ID="TextBoxStartDate" runat="server" Width="80px" Height="20px" BackColor="#CCCCCC"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarStartDate" PopupButtonID="ImageButtonStartDate" runat="server" TargetControlID="TextBoxStartDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="4" />
            </td>

            <td colspan="2" class="text-left">Associated Task(s):&nbsp;&nbsp;&nbsp; <asp:Button ID="ButtonAssociateTasks" runat="server" data-toggle="modal" data-target="#myModal2" Text="Associate Tasks" OnClientClick="return false;" OnClick="ButtonAssociateTasks_Click" Width="115px" TabIndex="8" />
            </td>
            <td colspan="7"></td>
        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="9">
                <div id="id_GridviewScroll" runat="server" style="overflow: scroll; height: 250px; width: 800px" visible="false">
                    <br />
                    <asp:GridView ID="GridViewAssociatedTasks" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridAssociatedTasks" ForeColor="#333333" GridLines="None" Height="121px" Width="100%">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
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
                <asp:SqlDataSource ID="GridAssociatedTasks" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT T.[Name], T.[Description], T.[TaskType], T.[ExpectedStartDate], T.[ExpectedDuration], T.[ExpectedEffort], 
                    T.[ActualStartDate], T.[ActualEndDate], T.[ActualDuration], T.[EffortCompleted], T.[ActualEffort], T.[ExpectedEndDate], 
                    T.[PredecessorDependency], T.[SuccessorDependency], S.[Name] SuccName, P.[Name] PredName 
                    FROM [tblTasks] T
                    LEFT JOIN [tblTasks] S ON S.TaskID = T.SuccessorTask
                    LEFT JOIN [tblTasks] P ON P.TaskID = T.PredecessorTask
                    WHERE ((T.[UserID] = @UserID) AND (T.[ProjectID] = @ProjectID) AND (T.[AssociatedDeliverable] IS NOT NULL) 
                    AND (T.[AssociatedDeliverable] = @AssociatedDeliverable))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                        <asp:SessionParameter Name="AssociatedDeliverable" SessionField="_CurrentDelivID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="14">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style20">Due Date<span class="auto-style17">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDueDate" runat="server" Width="80px" Height="20px" BackColor="#CCCCCC"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarDueDate" PopupButtonID="ImageButtonDueDate" runat="server" TargetControlID="TextBoxDueDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDueDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="5" />
            </td>
            <td colspan="1">List of Deliverable(s):</td>
            <td colspan="8"></td>
        </tr>


        <tr>
            <td colspan="5"></td>

            <td colspan="9" class="auto-style18">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="DelivList_Scrollbar">
                    <asp:GridView ID="GridViewListDeliverables" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridDeliverables" ForeColor="#333333" GridLines="None" AllowSorting="True" Width="830px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="StartDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="StartDate" SortExpression="StartDate" />
                            <asp:BoundField DataField="DueDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="DueDate" SortExpression="DueDate" />
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
                <asp:SqlDataSource ID="GridDeliverables" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [StartDate], [DueDate] FROM [tblDeliverables] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>

        <tr>
            <td colspan="14">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style22"></td>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" Text="New" Width="100px" OnClick="Button_New_Click" TabIndex="6" /></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1" class="text-left">
                <asp:Button ID="ButtonDel" runat="server" Text="Delete" Width="75px" OnClick="Button_Del_Click" Visible="False" /></td>
            <td colspan="1" class="text-center">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="125px" OnClick="Button_Save_Click" Visible="False" /></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1">&nbsp;</td>
            <td colspan="1" class="text-right">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td colspan="1"></td>

        </tr>
    </table>





</asp:Content>



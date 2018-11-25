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

        .auto-style9 {
            width: 2%;
            height: 60px;
        }

        .auto-style10 {
            height: 20px;
        }

        .auto-style11 {
            height: 60px;
            text-align: right;
        }

        .auto-style14 {
            text-align: right;
            height: 30px;
        }

        .auto-style15 {
            height: 30px;
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
                        <asp:SqlDataSource ID="GridViewAssociateTask" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [TaskID], [Name], [TaskType], CASE WHEN [AssociatedDeliverable] is NULL THEN 0 ELSE 1 END AS [Checked] FROM [tblTasks] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) AND ([AssociatedDeliverable] = @AssocDeliv OR [AssociatedDeliverable] IS NULL))">
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
            <td colspan="1" class="auto-style11">Name*:</td>
            <td colspan="3" class="auto-style8">
                <asp:TextBox ID="TextBoxName" runat="server" Width="315px"></asp:TextBox></td>
            <td colspan="1" class="auto-style9">
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" CssClass="col-xs-offset-0" /></td>
            <td colspan="2" class="auto-style11">Associated Requirement(s):</td>

            <td colspan="7" class="auto-style8">
                <asp:Button ID="ButtonReqs" runat="server" Text="Associate Requirements" />
            </td>
        </tr>

        <tr>
            <td colspan="14">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">Description*:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDescription" runat="server" Height="168px" MaxLength="1000" TextMode="MultiLine" Width="351px"></asp:TextBox>
            </td>
            <td colspan="2" class="text-right">Associated Task(s):</td>
            <td colspan="7" class="text-left">
                <asp:Button ID="ButtonAssociateTasks" runat="server" data-toggle="modal" data-target="#myModal2" Text="Associate Tasks" OnClientClick="return false;" OnClick="ButtonAssociateTasks_Click" />
            </td>
        </tr>

        <tr>
            <td colspan="7"></td>
            <td colspan="7">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="id_GridviewScroll" visible="false">
                    <asp:GridView ID="GridViewAssociatedTasks" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridAssociatedTasks" ForeColor="#333333" GridLines="None" AllowSorting="True" Width="100%" Height="121px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="TaskType" HeaderText="TaskType" SortExpression="TaskType" />
                            <asp:BoundField DataField="ExpectedStartDate" HeaderText="ExpectedStartDate" SortExpression="ExpectedStartDate" />
                            <asp:BoundField DataField="ExpectedEndDate" HeaderText="ExpectedEndDate" SortExpression="ExpectedEndDate" />
                            <asp:BoundField DataField="ExpectedDuration" HeaderText="ExpectedDuration" SortExpression="ExpectedDuration" />
                            <asp:BoundField DataField="ExpectedEffort" HeaderText="ExpectedEffort" SortExpression="ExpectedEffort" />
                            <asp:BoundField DataField="ActualStartDate" HeaderText="ActualStartDate" SortExpression="ActualStartDate" />
                            <asp:BoundField DataField="ActualEndDate" HeaderText="ActualEndDate" SortExpression="ActualEndDate" />
                            <asp:BoundField DataField="ActualDuration" HeaderText="ActualDuration" SortExpression="ActualDuration" />
                            <asp:BoundField DataField="EffortCompleted" HeaderText="EffortCompleted" SortExpression="EffortCompleted" />
                            <asp:BoundField DataField="ActualEffort" HeaderText="ActualEffort" SortExpression="ActualEffort" />
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
                <asp:SqlDataSource ID="GridAssociatedTasks" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [TaskType], [ExpectedStartDate], [ExpectedEndDate], [ExpectedDuration], [ExpectedEffort], [ActualStartDate], [ActualEndDate], [ActualDuration], [EffortCompleted], [ActualEffort], [PredecessorTask], [PredecessorDependency], [SuccessorTask], [SuccessorDependency] FROM [tblTasks] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) AND ([AssociatedDeliverable] IS NOT NULL) AND ([AssociatedDeliverable] = @AssociatedDeliverable))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                        <asp:SessionParameter Name="AssociatedDeliverable" SessionField="_CurrentDelivID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>

        <tr>
            <td colspan="14" class="auto-style10"></td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style14">Start Date:</td>
            <td colspan="6" class="auto-style15">

                <asp:TextBox ID="TextBoxStartDate" runat="server" Width="203px" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarStartDate" PopupButtonID="ImageButtonStartDate" runat="server" TargetControlID="TextBoxStartDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
            </td>
            <td colspan="7" class="auto-style15"></td>
        </tr>

        <tr>
            <td colspan="1">&nbsp;</td>
            <td colspan="4">&nbsp;</td>

            <td colspan="2" class="text-right">List of Deliverable(s):</td>
            <td colspan="7">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="DelivList_Scrollbar">
                    <asp:GridView ID="GridViewListDeliverables" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridDeliverables" ForeColor="#333333" GridLines="None" AllowSorting="True" Width="830px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="StartDate" HeaderText="StartDate" SortExpression="StartDate" />
                            <asp:BoundField DataField="DueDate" HeaderText="DueDate" SortExpression="DueDate" />
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
            <td colspan="14" class="auto-style10"></td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">Due Date:</td>
            <td colspan="6">
                <asp:TextBox ID="TextBoxDueDate" runat="server" Width="203px" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarDueDate" PopupButtonID="ImageButtonDueDate" runat="server" TargetControlID="TextBoxDueDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDueDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
            </td>
            <td colspan="7"></td>
        </tr>

        <tr>
            <td colspan="14"></td>
        </tr>

        <tr>
            <td colspan="14"></td>
        </tr>

        <tr>
            <td colspan="5" class="text-left">
                <asp:Button ID="ButtonNew" runat="server" Text="New" Width="101px" OnClick="Button_New_Click" />
            </td>
            <td colspan="2" class="text-left">
                <asp:Button ID="ButtonDel" runat="server" Text="Delete" Width="96px" OnClick="Button_Del_Click" Visible="False" />
            </td>
            <td colspan="7" class="text-left">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="131px" OnClick="Button_Save_Click" Visible="False" />
            </td>
        </tr>
    </table>





</asp:Content>



<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Deliverables.aspx.cs" Inherits="_380_Project_3.Deliverables" %>

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
                        <h4 class="modal-title">Search for Deliverables</h4>
                    </div>

                    <div class="modal-body">
                        Deliverables List:
                        <asp:DropDownList ID="DropDownListDelivSelect" runat="server" DataSourceID="DropDownListDelivDB" DataTextField="Name" DataValueField="DeliverableID" Height="30px" Width="571px">
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
                        <h4 class="modal-title">Search for Tasks</h4>
                    </div>

                    <div class="modal-body">
                        Tasks List:
                    <div style="overflow-y: scroll; height: 250px">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewAssociateTask" ForeColor="#333333" GridLines="None" Width="472px">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                <asp:BoundField DataField="TaskType" HeaderText="TaskType" SortExpression="TaskType" />
                                <asp:TemplateField HeaderText="Associated">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server" />
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
                        <asp:SqlDataSource ID="GridViewAssociateTask" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [TaskType] FROM [tblTasks] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
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

    </div>

    <table class="auto-style34">
        <tr>
            <td class="auto-style12">
                <table class="auto-style10">
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>Name<span class="auto-style1">*</span><span class="auto-style6">:</span></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td class="auto-style20">
                <table style="width: 100%;">
                    <tr>
                        <td class="auto-style42">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style42">
                            <asp:TextBox ID="TextBoxName" runat="server" Width="315px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style42">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td class="auto-style11">
                <table style="width: 100%;">
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Associated Requirement(s):</td>
                        <td>&nbsp;</td>
                        <td class="auto-style44">
                            <asp:Button ID="ButtonReqs" runat="server" Text="Associate Requirements" />
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="auto-style16">
                <table class="auto-style19">
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>Description<span class="auto-style1">*</span><span class="auto-style6">:</span></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td class="auto-style14">
                <asp:TextBox ID="TextBoxDescription" runat="server" Height="168px" MaxLength="1000" TextMode="MultiLine" Width="351px"></asp:TextBox>
            </td>
            <td class="auto-style17"></td>
        </tr>
        <tr>
            <td class="auto-style18">
                <table class="auto-style21">
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>Start Date:<br />
                            <br />
                            <br />
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td class="auto-style7">
                <br />
                <table style="width: 100%;">
                    <tr>
                        <td class="auto-style36">
                            <asp:TextBox ID="TextBoxStartDate" runat="server" Width="203px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButtonStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" OnClick="ImageButtonStartDate_Click" Width="30px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style40">
                            <asp:Calendar ID="CalendarStart" runat="server" OnSelectionChanged="CalendarStart_SelectionChanged" Visible="False" BackColor="White" BorderColor="White" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="125px">
                                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                                <TodayDayStyle BackColor="#CCCCCC" />
                            </asp:Calendar>
                        </td>
                        <td class="auto-style41"></td>
                        <td class="auto-style41"></td>
                    </tr>
                    <tr>
                        <td class="auto-style38"></td>
                        <td class="auto-style28"></td>
                        <td class="auto-style28"></td>
                    </tr>
                </table>
            </td>
            <td class="auto-style8">
                <br />
                <table style="width: 100%;">
                    <tr>
                        <td class="auto-style3">Associated Task(s):</td>
                        <td class="auto-style3"></td>
                        <td class="auto-style43">
                            <asp:Button ID="ButtonTask" runat="server" data-toggle="modal" data-target="#myModal2" Text="Associate Tasks" OnClientClick="return false;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="GridViewAssociatedTasks" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridAssociatedTasks" ForeColor="#333333" GridLines="None" AllowSorting="True">
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
                            <asp:SqlDataSource ID="GridAssociatedTasks" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [TaskType], [ExpectedStartDate], [ExpectedEndDate], [ExpectedDuration], [ExpectedEffort], [ActualStartDate], [ActualEndDate], [ActualDuration], [EffortCompleted], [ActualEffort], [PredecessorTask], [PredecessorDependency], [SuccessorTask], [SuccessorDependency] FROM [tblTasks] WHERE (([AssociatedDeliverable] = @AssociatedDeliverable) AND ([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                                <SelectParameters>
                                    <asp:SessionParameter Name="AssociatedDeliverable" SessionField="_CurrentDelivID" Type="Int32" />
                                    <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                    <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="auto-style31">
                <table class="auto-style21">
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>Due Date:</td>
                    </tr>
                    <tr>
                        <td class="auto-style39"></td>
                        <td class="auto-style39"></td>
                        <td class="auto-style39"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td class="auto-style9">
                <br />
                <table style="width: 100%;">
                    <tr>
                        <td class="auto-style36">
                            <asp:TextBox ID="TextBoxDueDate" runat="server" Width="203px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButtonDueDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" OnClick="ImageButtonDueDate_Click" Width="30px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style36">
                            <asp:Calendar ID="CalendarDue" runat="server" OnSelectionChanged="CalendarDue_SelectionChanged" Visible="False" BackColor="White" BorderColor="White" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="121px">
                                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                                <TodayDayStyle BackColor="#CCCCCC" />
                            </asp:Calendar>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style36">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td class="auto-style32">
                <table style="width: 100%;">
                    <tr>
                        <td class="auto-style28">List of Deliverable(s):</td>
                        <td class="auto-style28"></td>
                        <td class="auto-style28"></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
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
                            <asp:SqlDataSource ID="GridDeliverables" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [StartDate], [DueDate] FROM [tblDeliverables] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                                <SelectParameters>
                                    <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                    <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td class="auto-style1"></td>
                        <td class="auto-style1"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="auto-style24"></td>
            <td class="auto-style22"></td>
            <td class="auto-style23">
                <table style="width: 100%;">
                    <tr>
                        <td class="text-left">
                            <asp:Button ID="ButtonNew" runat="server" Text="New" Width="101px" OnClick="Button_New_Click" />
                        </td>
                        <td class="text-right">
                            <asp:Button ID="ButtonDel" runat="server" Text="Delete" Width="96px" OnClick="Button_Del_Click" Visible="False" />
                        </td>
                        <td class="text-right">
                            <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="131px" OnClick="Button_Save_Click" Visible="False" />
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="auto-style29"></td>
            <td class="auto-style27"></td>
            <td class="auto-style28"></td>
        </tr>
        <tr>
            <td class="auto-style29"></td>
            <td class="auto-style27"></td>
            <td class="auto-style28"></td>
        </tr>
        <tr>
            <td class="auto-style29"></td>
            <td class="auto-style27"></td>
            <td class="auto-style28"></td>
        </tr>
    </table>

</asp:Content>



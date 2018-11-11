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
                        <asp:DropDownList ID="DropDownListDelivSelect" runat="server" DataSourceID="ProjectSelectDB" DataTextField="Name" DataValueField="DeliverableID" Height="30px" Width="571px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="ProjectSelectDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [DeliverableID] FROM [tblDeliverables] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Project" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
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
                <table style="width:100%;">
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
                <table style="width:100%;">
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
                            <asp:Button ID="ButtonTask" runat="server" Text="Associate Tasks" />
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
                <table style="width:100%;">
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
                        <td>List of Deliverable(s):</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <asp:GridView ID="GridViewListDeliverables" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridDeliverables" ForeColor="#333333" GridLines="None" AllowSorting="True" Width="830px">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                    <asp:BoundField DataField="StartDate" HeaderText="Start Date" SortExpression="StartDate" />
                                    <asp:BoundField DataField="DueDate" HeaderText="Due Date" SortExpression="DueDate" />
                                    <asp:BoundField DataField="Requirements" HeaderText="Requirements" SortExpression="Requirements" />
                                    <asp:BoundField DataField="Tasks" HeaderText="Tasks" SortExpression="Tasks" />
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
                            <asp:SqlDataSource ID="GridDeliverables" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [StartDate], [DueDate], [Requirements], [Tasks] FROM [tblDeliverables] WHERE (([ProjectID] = @ProjectID) AND ([UserID] = @UserID))">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                    <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
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
                <table style="width:100%;">
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
            <td class="auto-style28">
            </td>
        </tr>
        <tr>
            <td class="auto-style29"></td>
            <td class="auto-style27"></td>
            <td class="auto-style28"></td>
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

        .auto-style3 {
            height: 30px;
        }
        .auto-style6 {
            text-align: right;
            height: 185px;
        }
        .auto-style7 {
            text-align: left;
            height: 230px;
            width: 102%;
        }
        .auto-style8 {
            height: 230px;
        }
        .auto-style9 {
            width: 102%;
            height: 166px;
        }
        .auto-style10 {
            width: 100%;
            height: 140px;
        }
        .auto-style11 {
            color: #FF0000;
            height: 140px;
        }
        .auto-style12 {
            text-align: right;
            height: 140px;
        }
        .auto-style14 {
            width: 102%;
            height: 174px;
        }
        .auto-style16 {
            text-align: right;
            height: 174px;
        }
        .auto-style17 {
            height: 174px;
        }
        .auto-style18 {
            text-align: right;
            height: 230px;
        }
        .auto-style19 {
            width: 100%;
            height: 165px;
        }
        .auto-style20 {
            width: 102%;
            height: 140px;
        }
        .auto-style21 {
            width: 100%;
            height: 201px;
        }
        .auto-style22 {
            width: 102%;
            height: 60px;
        }
        .auto-style23 {
            height: 60px;
        }
        .auto-style24 {
            color: #000000;
            width: 439px;
            height: 60px;
        }
        .auto-style27 {
            width: 102%;
            height: 20px;
        }
        .auto-style28 {
            height: 20px;
        }
        .auto-style29 {
            color: #000000;
            width: 439px;
            height: 20px;
        }
        .auto-style31 {
            text-align: right;
            height: 166px;
        }
        .auto-style32 {
            height: 166px;
        }
        .auto-style34 {
            color: #000000;
            height: 871px;
        }
        .auto-style36 {
            width: 184px;
        }
        .auto-style38 {
            height: 20px;
            width: 184px;
        }
        .auto-style39 {
            height: 67px;
        }
        .auto-style40 {
            width: 184px;
            height: 162px;
        }
        .auto-style41 {
            height: 162px;
        }
        .auto-style42 {
            width: 348px;
        }
        .auto-style43 {
            height: 30px;
            text-align: right;
        }
        .auto-style44 {
            color: #000000;
            text-align: right;
        }
    </style>
</asp:Content>


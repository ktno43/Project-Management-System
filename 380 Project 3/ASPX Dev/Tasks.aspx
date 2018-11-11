<%@ Page Language="C#" MasterPageFile="siteMaster.Master" AutoEventWireup="true" CodeBehind="Tasks.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Tasks" %>

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
    <div>
        <table style="width: 100%;">
            <tr>
                <td class="auto-style39">
                    <table style="width: 100%;">
                        <tr>
                            <td class="auto-style3"></td>
                            <td class="auto-style3"></td>
                            <td class="auto-style3"></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td class="auto-style4">Name<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td class="auto-style5">
                    <table>
                        <tr>
                            <td class="auto-style24"></td>
                            <td class="auto-style25"></td>
                            <td class="auto-style9">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style8">
                                <asp:TextBox ID="TextBoxName" runat="server" Width="315px"></asp:TextBox>
                            </td>
                            <td class="auto-style26">
                                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style8">&nbsp;</td>
                            <td class="auto-style26">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td class="auto-style6">
                    <table class="nav-justified">
                        <tr>
                            <td class="auto-style45">Resource Assigned:</td>
                            <td class="auto-style47"></td>
                            <td class="auto-style46">
                                <asp:Button ID="ButtonAddResource" runat="server" CssClass="auto-style50" Text="Add New Resource" OnClick="ButtonAddResource_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style44">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style44">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="auto-style40">
                    <table style="width: 100%;">
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td class="auto-style4">Description<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td class="auto-style27">
                    <table class="auto-style36">
                        <tr>
                            <td class="auto-style32">&nbsp;</td>
                            <td class="auto-style34">&nbsp;</td>
                            <td class="auto-style34">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style32">
                                <asp:TextBox ID="TextBoxDescription" runat="server" Height="168px" MaxLength="1000" TextMode="MultiLine" Width="351px"></asp:TextBox>
                            </td>
                            <td class="auto-style34">&nbsp;</td>
                            <td class="auto-style34">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style32">&nbsp;</td>
                            <td class="auto-style34">&nbsp;</td>
                            <td class="auto-style34">&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td class="auto-style3">
                    <table style="width: 100%;">
                        <tr>
                            <td class="auto-style51">Associate Predecessor Task:</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style51">
                                <asp:DropDownList ID="DropDownListPre" runat="server" Height="16px" Width="140px">
                                    <asp:ListItem>Finish to Start</asp:ListItem>
                                    <asp:ListItem>Start to Start</asp:ListItem>
                                    <asp:ListItem>Finish to Finish</asp:ListItem>
                                    <asp:ListItem>Start to Finish</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style51">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style54"></td>
                            <td class="auto-style9"></td>
                            <td class="auto-style9"></td>
                        </tr>
                        <tr>
                            <td class="auto-style51">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style51">Associate Sucessor Task:</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style51">
                                <asp:DropDownList ID="DropDownListSuc" runat="server" Width="140px">
                                    <asp:ListItem>Finish to Start</asp:ListItem>
                                    <asp:ListItem>Start to Start</asp:ListItem>
                                    <asp:ListItem>Finish to Finish</asp:ListItem>
                                    <asp:ListItem>Start to Finish</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style51">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style54"></td>
                            <td class="auto-style9"></td>
                            <td class="auto-style9"></td>
                        </tr>
                        <tr>
                            <td class="auto-style51">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style51">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="auto-style41">
                    <table style="width: 100%;">
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td class="text-right">Expected Start Date<span class="auto-style1">*</span>:</td>
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
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td class="auto-style28">
                    <table style="width: 100%;">
                        <tr>
                            <td class="auto-style77">&nbsp;</td>
                            <td class="auto-style78">&nbsp;</td>
                            <td class="auto-style76">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style71">
                    <asp:TextBox ID="TextBoxExpectedStartDate" runat="server"></asp:TextBox>
                                <asp:ImageButton ID="ImageButtonExpectedStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" OnClick="ImageButtonExpectedStartDate_Click" Width="30px" />
                            </td>
                            <td class="auto-style15">Expected Due Date<span class="auto-style1">*</span>:</td>
                            <td class="auto-style75">
                    <asp:TextBox ID="TextBoxExpectedDueDate" runat="server"></asp:TextBox>
                                <asp:ImageButton ID="ImageButtonExpectedDueDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" OnClick="ImageButtonExpectedDueDate_Click" Width="30px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style71">
                <asp:Calendar ID="CalendarExpectedStart" runat="server" OnSelectionChanged="CalendarExpectedStart_SelectionChanged" Visible="False" BackColor="White" BorderColor="White" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="75px" NextPrevFormat="FullMonth" Width="16px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                            </asp:Calendar>
                            </td>
                            <td class="auto-style22"></td>
                            <td class="auto-style75">
                <asp:Calendar ID="CalendarExpectedDue" runat="server" OnSelectionChanged="CalendarExpectedDue_SelectionChanged" Visible="False" BackColor="White" BorderColor="White" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="75px" NextPrevFormat="FullMonth" Width="16px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                            </asp:Calendar>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table style="width: 100%;">
                        <tr>
                            <td class="auto-style53">&nbsp;</td>
                            <td class="auto-style64">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style53">List of Task(s) and Summary Task(s):</td>
                            <td class="auto-style64">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style53">&nbsp;</td>
                            <td class="auto-style63">
                                <asp:Button ID="ButtonChangeTaskType" runat="server" Text="Change Task Type" />
                            </td>
                            <td class="text-right">
                                <asp:Button ID="ButtonGroupTasks" runat="server" Text="Group Tasks" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="auto-style10">Expected Duration:</td>
                <td class="auto-style29">
                    <asp:TextBox ID="TextBoxExpectedDuration" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style9"></td>
            </tr>
            <tr>
                <td class="auto-style10">Expected Effort:</td>
                <td class="auto-style29">
                    <asp:TextBox ID="TextBoxExpectedEffort" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style9"></td>
            </tr>
            <tr>
                <td class="auto-style12">Percent Complete:</td>
                <td class="auto-style30"></td>
                <td class="auto-style11"></td>
            </tr>
            <tr>
                <td class="auto-style41">&nbsp;</td>
                <td class="auto-style28">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style42">
                    <table style="width: 100%;">
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td class="text-right">Actual Start Date:</td>
                        </tr>
                        <tr>
                            <td class="auto-style9"></td>
                            <td class="auto-style9"></td>
                            <td class="auto-style9"></td>
                        </tr>
                        <tr>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                            <td class="auto-style9">&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td class="auto-style28">
                    <table class="nav-justified">
                        <tr>
                            <td class="auto-style71"></td>
                            <td class="auto-style79"></td>
                            <td class="auto-style9"></td>
                        </tr>
                        <tr>
                            <td class="auto-style81">
                    <asp:TextBox ID="TextBoxActualStartDate" runat="server" Width="107px"></asp:TextBox>
                                <asp:ImageButton ID="ImageButtonActualStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" OnClick="ImageButtonActualStartDate_Click" Width="30px" />
                            </td>
                            <td class="auto-style18">Actual End Date:</td>
                            <td class="auto-style82">
                    <asp:TextBox ID="TextBoxActualEndDate" runat="server" Width="105px"></asp:TextBox>
                                <asp:ImageButton ID="ImageButtonActualEndDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" OnClick="ImageButtonActualEndDate_Click" Width="30px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style77">
                <asp:Calendar ID="CalendarActualStart" runat="server" OnSelectionChanged="CalendarActualStart_SelectionChanged" Visible="False" BackColor="White" BorderColor="White" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="75px" NextPrevFormat="FullMonth" Width="30px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                            </asp:Calendar>
                            </td>
                            <td class="auto-style80">&nbsp;</td>
                            <td>
                <asp:Calendar ID="CalendarActualEnd" runat="server" OnSelectionChanged="CalendarActualEnd_SelectionChanged" Visible="False" BackColor="White" BorderColor="White" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="75px" NextPrevFormat="FullMonth" Width="30px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                            </asp:Calendar>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table style="width: 100%;">
                        <tr>
                            <td class="auto-style61"></td>
                            <td class="auto-style9"></td>
                            <td class="auto-style9"></td>
                        </tr>
                        <tr>
                            <td class="auto-style61">Associate Issue(s):</td>
                            <td class="auto-style9"></td>
                            <td class="auto-style58">
                                <asp:Button ID="ButtonAssociateIssues" runat="server" Text="Associate Issues" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style60">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="auto-style55">Actual Duration:</td>
                <td class="auto-style56">
                    <asp:TextBox ID="TextBoxActualDuration" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style57"></td>
            </tr>
            <tr>
                <td class="auto-style42">Actual Effort:</td>
                <td class="auto-style28">
                    <asp:TextBox ID="TextBoxActualEffort" runat="server"></asp:TextBox>
                </td>
                <td>
                    <table style="width: 100%;">
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="text-left">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style9">
                                            <asp:Button ID="ButtonNew" runat="server" Text="New" Width="101px" OnClick="ButtonNew_Click" />
                                        </td>
                                        <td class="auto-style9"></td>
                                        <td class="auto-style58">
                                            <asp:Button ID="ButtonGantt" runat="server" Text="Gantt Chart" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                            <td class="text-right">
                                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" Width="96px" OnClick="ButtonDelete_Click" />
                            </td>
                            <td class="text-right">
                                <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="131px" OnClick="ButtonSave_Click" />
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
        </table>
    </div>
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
            height: 23px;
        }

        .auto-style4 {
            text-align: right;
        }

        .auto-style5 {
            text-align: left;
            height: 77px;
            width: 447px;
        }

        .auto-style6 {
            height: 77px;
        }

        .auto-style8 {
            width: 323px;
        }

        .auto-style9 {
            height: 20px;
        }

        .auto-style10 {
            height: 20px;
            text-align: right;
            width: 161px;
        }

        .auto-style11 {
            height: 19px;
        }

        .auto-style12 {
            height: 19px;
            text-align: right;
            width: 161px;
        }

        .auto-style15 {
            height: 20px;
            text-align: right;
            width: 130px;
        }

        .auto-style18 {
            text-align: right;
            width: 267px;
            height: 60px;
        }

        .auto-style22 {
            width: 130px;
            height: 20px;
        }

        .auto-style24 {
            width: 323px;
            height: 20px;
        }

        .auto-style25 {
            width: 67px;
            height: 20px;
        }

        .auto-style26 {
            width: 67px;
        }

        .auto-style27 {
            height: 23px;
            width: 447px;
        }

        .auto-style28 {
            width: 447px;
        }

        .auto-style29 {
            height: 20px;
            width: 447px;
        }

        .auto-style30 {
            height: 19px;
            width: 447px;
        }

        .auto-style32 {
            width: 357px;
        }

        .auto-style34 {
            width: 4px;
        }

        .auto-style36 {
            width: 365px;
        }

        .auto-style39 {
            height: 77px;
            width: 161px;
        }

        .auto-style40 {
            height: 23px;
            width: 161px;
        }

        .auto-style41 {
            width: 161px;
        }

        .auto-style42 {
            text-align: right;
            width: 161px;
        }

        .auto-style44 {
            width: 136px;
        }

        .auto-style45 {
            width: 136px;
            height: 26px;
        }

        .auto-style46 {
            height: 26px;
            text-align: right;
        }

        .auto-style47 {
            height: 26px;
        }

        .auto-style50 {
            margin-left: 304px;
        }

        .auto-style51 {
            width: 184px;
        }

        .auto-style53 {
            width: 237px;
        }

        .auto-style54 {
            width: 184px;
            height: 20px;
        }

        .auto-style55 {
            text-align: right;
            width: 161px;
            height: 22px;
        }

        .auto-style56 {
            width: 447px;
            height: 22px;
        }

        .auto-style57 {
            height: 22px;
        }

        .auto-style58 {
            height: 20px;
            text-align: right;
        }

        .auto-style60 {
            width: 119px;
        }

        .auto-style61 {
            width: 119px;
            height: 20px;
        }

        .auto-style63 {
            text-align: left;
            width: 183px;
        }

        .auto-style64 {
            width: 183px;
        }
        .auto-style71 {
            width: 158px;
            height: 20px;
        }
        .auto-style75 {
            height: 20px;
            width: 159px;
        }
        .auto-style76 {
            width: 159px;
        }
        .auto-style77 {
            width: 158px;
        }
        .auto-style78 {
            width: 130px;
        }
        .auto-style79 {
            width: 267px;
            height: 20px;
        }
        .auto-style80 {
            width: 267px;
        }
        .auto-style81 {
            width: 158px;
            height: 60px;
        }
        .auto-style82 {
            height: 60px;
        }
    </style>
</asp:Content>


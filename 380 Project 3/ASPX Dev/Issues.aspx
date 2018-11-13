<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Issues.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Issues" %>

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
                        Tasks List:
                        <asp:DropDownList ID="DropDownListTaskSelect" runat="server" DataSourceID="DropDownListTaskDB" DataTextField="Name" DataValueField="TaskID" Height="30px" Width="571px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListTaskDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [TaskID] FROM [tblTasks] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
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

        <table style="width:100%;">
            <tr>
                <td class="auto-style4">Name<span class="auto-style1">*</span><span class="auto-style3">:<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    <asp:Button ID="ButtonSearch" runat="server" Text="Search" />
                    </span></td>
                <td class="auto-style2">
                    <table style="width:100%;">
                        <tr>
                            <td>Status<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
                            <td>
                                <asp:Button ID="ButtonAddStatus" runat="server" Text="Add Status" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="ButtonRemoveStatus" runat="server" Text="Remove Status" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td class="auto-style2">
                    <table style="width:100%;">
                        <tr>
                            <td>Severity<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
                            <td>
                                <asp:Button ID="ButtonAddSeverity" runat="server" Text="Add Severity" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="ButtonRemoveSeverity" runat="server" Text="Remove Severity" />
                            </td>
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
                <td class="auto-style6">Description<span class="auto-style1">*</span><span class="auto-style3">:<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    </span></td>
                <td>Status Description<span class="auto-style1">*</span><span class="auto-style3">:<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                    </span></td>
                <td>
                    <table style="width:100%;">
                        <tr>
                            <td>Priority<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
                            <td>
                                <asp:Button ID="ButtonAddPriority" runat="server" Text="Add Priority" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="ButtonRemovePriority" runat="server" Text="Remove Priority" />
                            </td>
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
                <td class="auto-style6">Expected Completion Date<span class="auto-style1">*</span><span class="auto-style3">:</span><asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                    <asp:ImageButton ID="ImageButtonExpCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" />
                </td>
                <td class="auto-style3">Last Updated:<asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style8">
                    <asp:Calendar ID="CalendarExpCompletionDate" runat="server"></asp:Calendar>
                </td>
                <td class="auto-style9">Associated Action Item(s):</td>
                <td class="auto-style9">
                    <asp:Button ID="ButtonASsociateActionItems" runat="server" Text="Associate Action Items" />
                </td>
            </tr>
            <tr>
                <td class="auto-style4">Date Raised<span class="auto-style1">*</span><span class="auto-style3">:<asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                    <asp:ImageButton ID="ImageButtonDateRaised" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" />
                    </span></td>
                <td class="auto-style2"></td>
                <td class="auto-style2"></td>
            </tr>
            <tr>
                <td class="auto-style6">
                    <asp:Calendar ID="CalendarDateRaised" runat="server"></asp:Calendar>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style6">Date Assigned<span class="auto-style1">*</span><span class="auto-style3">:<asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                    <asp:ImageButton ID="ImageButtonDateAssigned" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" />
                    </span></td>
                <td>Associated Decision(s):</td>
                <td>
                    <asp:Button ID="ButtonAssociateDecisions" runat="server" Text="Associate Decisions" />
                </td>
            </tr>
            <tr>
                <td class="auto-style6">
                    <asp:Calendar ID="CalendarDateAssigned" runat="server"></asp:Calendar>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style6">Actual Completion Date:<asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                    <asp:ImageButton ID="ImageButtonActCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style7">
                    <asp:Calendar ID="CalendarActCompletionDate" runat="server"></asp:Calendar>
                </td>
                <td class="text-right">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style7">
                    <asp:Button ID="ButtonNew" runat="server" Text="New" />
                </td>
                <td class="text-right">
                    <asp:Button ID="ButtonDelete" runat="server" Text="Delete" />
                </td>
                <td class="text-right">
                    <asp:Button ID="ButtonSave" runat="server" Text="Save" />
                </td>
            </tr>
        </table>

    </div>

    <div>
    </div>
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style1 {
            color: #FF0000;
        }
        .auto-style2 {
            height: 20px;
        }
        .auto-style3 {
            color: #000000;
        }
        .auto-style4 {
            height: 20px;
            width: 176px;
        }
        .auto-style6 {
            width: 176px;
        }
        .auto-style7 {
            width: 176px;
            text-align: right;
        }
        .auto-style8 {
            height: 18px;
            width: 176px;
        }
        .auto-style9 {
            height: 18px;
        }
    </style>
</asp:Content>


<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Decisions.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Decisions" %>

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
                        <h4 class="modal-title">Search for Decisions</h4>
                    </div>

                    <div class="modal-body">
                        Decisions List:
                        <asp:DropDownList ID="DropDownListDecisionSelect" runat="server" DataSourceID="DropDownListDecisionDB" DataTextField="Name" DataValueField="DecisionID" Height="30px" Width="571px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListDecisionDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [DecisionID] FROM [tblDecisions] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Decision" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>

    </div>

    <div>
        <table style="width:100%;">
            <tr>
                <td class="auto-style5">Name<span class="auto-style1">*</span><span class="auto-style2">:<asp:TextBox ID="TextBoxName" runat="server"></asp:TextBox>
 <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" />
                    </span></td>
                <td>
                    <table style="width:100%;">
                        <tr>
                            <td>Status<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
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
                <td>
                    <table style="width:100%;">
                        <tr>
                            <td>Impact<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
                            <td>
                                <asp:Button ID="ButtonAddImpact" runat="server" Text="Add Impact" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="ButtonRemoveImpact" runat="server" Text="Remove Impact" />
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
                <td class="auto-style5">Description<span class="auto-style1">*</span><span class="auto-style2">:<asp:TextBox ID="TextBoxDescription" runat="server" MaxLength="1000" TextMode="MultiLine"></asp:TextBox>
                    </span></td>
                <td>&nbsp;</td>
                <td>
                    <table style="width:100%;">
                        <tr>
                            <td>Priority<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
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
                <td class="auto-style5">Date Created<span class="auto-style1">*</span><span class="auto-style2">:<asp:TextBox ID="TextBoxDateCreated" runat="server"></asp:TextBox>
                    <asp:ImageButton ID="ImageButtonDateCreated" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" />
                    </span></td>
                <td>Associated Meetinng Note(s):</td>
                <td>Associated Reference Document(s):</td>
            </tr>
            <tr>
                <td class="auto-style5">
                    <asp:Calendar ID="CalendarCreated" runat="server"></asp:Calendar>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style5">Date Needed<span class="auto-style1">*</span><span class="auto-style2">:<asp:TextBox ID="TextBoxDateNeeded" runat="server"></asp:TextBox>
                    <asp:ImageButton ID="ImageButtonDateNeeded" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" />
                    </span></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style5">
                    <asp:Calendar ID="CalendarNeeded" runat="server"></asp:Calendar>
                </td>
                <td>
                    <asp:Button ID="ButtonAssociateMeetingNOtes" runat="server" Text="Associate Meeting Notes" />
                </td>
                <td>
                    <asp:Button ID="ButtonAssociateRefDocs" runat="server" Text="Associate Reference Documents" />
                </td>
            </tr>
            <tr>
                <td class="auto-style5">Expected Completion Date<span class="auto-style1">*</span><span class="auto-style2">:</span><asp:TextBox ID="TextBoxExpCompletionDate" runat="server"></asp:TextBox>
                    <span class="auto-style2">
                    <asp:ImageButton ID="ImageButtonExpCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" />
                    </span></td>
                <td>Associated Decision(s):</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style5">
                    <asp:Calendar ID="CalendarExpCompletionDate" runat="server"></asp:Calendar>
                </td>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="ButtonAssociateDecisions" runat="server" Text="Associate Decisions" />
                </td>
            </tr>
            <tr>
                <td class="auto-style5">Actual Completion Date:<asp:TextBox ID="TextBoxActCompletionDate" runat="server"></asp:TextBox>
                    <span class="auto-style2">
                    <asp:ImageButton ID="ImageButtonActCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" />
                    </span></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style5">
                    <asp:Calendar ID="CalendarActCompletionDate" runat="server"></asp:Calendar>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style5">Date Made:<asp:TextBox ID="TextBoxDateMade" runat="server"></asp:TextBox>
                    <span class="auto-style2">
                    <asp:ImageButton ID="ImageButtonDateMade" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Width="30px" />
                    </span></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style5">
                    <asp:Calendar ID="CalendarDateMade" runat="server"></asp:Calendar>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style5">Decision Maker:<asp:TextBox ID="TextBoxDecisionMaker" runat="server"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style6">
                    <asp:Button ID="ButtonNew" runat="server" Text="New" OnClick="ButtonNew_Click" />
                </td>
                <td class="auto-style7">
                    <asp:Button ID="ButtonDelete" runat="server" Text="Delete" />
                </td>
                <td class="auto-style7">
                    <asp:Button ID="ButtonSave" runat="server" Text="Save" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style1 {
            color: #FF0000;
        }
        .auto-style2 {
            color: #000000;
        }
        .auto-style5 {
            width: 303px;
        }
        .auto-style6 {
            width: 303px;
            text-align: right;
        }
        .auto-style7 {
            text-align: right;
        }
    </style>
</asp:Content>


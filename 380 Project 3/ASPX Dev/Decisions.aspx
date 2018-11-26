<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Decisions.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Decisions" %>

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
                        <h4 class="modal-title">Search for Decisions</h4>
                    </div>

                    <div class="modal-body">
                        Decisions List:
                        <asp:DropDownList ID="DropDownListDecisionSelect" runat="server" DataSourceID="DropDownListDecisionDB" DataTextField="Name" DataValueField="DecisionID" Height="30px" Width="571px" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />

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

    <div class="container">
        <!-- Modal -->
        <div class="modal fade" id="myModal2" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Status</h4>
                    </div>

                    <div class="modal-body">
                        Status Name:
                    <br />
                        <asp:TextBox ID="TextBoxAddStatus" autofocus="" runat="server"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalAddStatus" runat="server" Text="Add New Status" CssClass="btn btn-default" OnClick="ButtonModalAddStatus_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="container">
        <!-- Modal -->
        <div class="modal fade" id="myModal3" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Impact</h4>
                    </div>

                    <div class="modal-body">
                        Impact Name:
                    <br />
                        <asp:TextBox ID="TextBoxAddImpact" autofocus="" runat="server"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalAddImpact" runat="server" Text="Add New Status" CssClass="btn btn-default" OnClick="ButtonModalAddImpact_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="container">
        <!-- Modal -->
        <div class="modal fade" id="myModal4" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Priority</h4>
                    </div>

                    <div class="modal-body">
                        Priority Name:
                    <br />
                        <asp:TextBox ID="TextBoxAddPriority" autofocus="" runat="server"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalAddPriority" runat="server" Text="Add New Status" CssClass="btn btn-default" OnClick="ButtonModalAddPriority_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <table style="width: 100%;">
        <tr>
            <td colspan="1" class="auto-style11">Name<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="3" class="auto-style8"><span class="auto-style2">
                <asp:TextBox ID="TextBoxName" runat="server" Height="20px" Width="300px"></asp:TextBox>
            </span>&nbsp;<span class="auto-style2"><asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" Width="60px" />
            </span></td>
            <td colspan="1" class="auto-style8">&nbsp;</td>
            <td colspan="1" class="auto-style14">Impact*:</td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxImpact" ClientIDMode="Static" runat="server" Height="20px" Width="150px"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonAddImpact" runat="server" Text="Add Impact" data-toggle="modal" data-target="#myModal3" OnClientClick="return false;" Width="85px" />
            </td>

            <td colspan="2" rowspan="2">
                <asp:ListBox ID="ListBoxImpact" ClientIDMode="Static" runat="server" Width="185px" onchange="ImpactTextBoxJS(this)" DataSourceID="ListBoxImpactDB" DataTextField="ImpactName" DataValueField="Sequence" Height="150px"></asp:ListBox>
                <asp:SqlDataSource ID="ListBoxImpactDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [ImpactName], [Sequence] FROM [tblImpact] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID)) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td colspan="5" class="auto-style8">
                <asp:ImageButton ID="ImageButtonImpactMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxImpact', 'up'); return false;" />

            </td>
        </tr>
        <tr>
            <td colspan="6"></td>
            <td colspan="1"></td>
            <td colspan="1">
                <asp:Button ID="ButtonRemoveImpact" runat="server" Text="Remove Impact" Width="110px" OnClick="ButtonRemoveImpact_Click" />
            </td>
            <td colspan="7">
                <asp:ImageButton ID="ImageButtonImpactMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxImpact', 'down'); return false;" />

            </td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">Description<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="4"><span class="auto-style2">
                <asp:TextBox ID="TextBoxDescription" runat="server" MaxLength="1000" TextMode="MultiLine" Height="150px" Width="300px"></asp:TextBox>
            </span></td>
            <td colspan="1" class="text-right">Priority*:</td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxPriority" ClientIDMode="Static" runat="server" Height="20px" Width="150px"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonAddPriority" runat="server" Text="Add Priority" data-toggle="modal" data-target="#myModal4" OnClientClick="return false;" Width="85px" /></td>
            <td colspan="2" rowspan="2">
                <asp:ListBox ID="ListBoxPriority" ClientIDMode="Static" runat="server" Height="150px" Width="185px" onchange="PriorityTextBoxJS(this)" DataSourceID="ListBoxPriorityDB" DataTextField="PriorityName" DataValueField="Sequence"></asp:ListBox>
                <asp:SqlDataSource ID="ListBoxPriorityDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [PriorityName], [Sequence] FROM [tblPriority] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID)) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td colspan="5">
                <asp:ImageButton ID="ImageButtonPriorityMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxPriority','up');return false;" />
            </td>

        </tr>
        <tr>
            <td colspan="5"></td>
            <td colspan="2"></td>
            <td colspan="1">
                <asp:Button ID="ButtonRemovePriority" runat="server" Text="Remove Priority" Width="110px" OnClick="ButtonRemovePriority_Click" /></td>
            <td colspan="7">
                <asp:ImageButton ID="ImageButtonPriorityMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxPriority','down');return false;" />


            </td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="1" class="auto-style12">Date Created<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="4" class="auto-style9"><span class="auto-style2">
                <asp:TextBox ID="TextBoxDateCreated" runat="server" ReadOnly="True" Height="20px" Width="80px"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarDateCreated" PopupButtonID="ImageButtonDateCreated" runat="server" TargetControlID="TextBoxDateCreated" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateCreated" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
            </span>
            </td>

            <td colspan="1" class="text-right">Status<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxStatus" ClientIDMode="Static" runat="server" Height="20px" Width="150px"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonAddStatus" runat="server" Text="Add Status" data-toggle="modal" data-target="#myModal2" OnClientClick="return false;" Width="85px" /></td>
            <td colspan="2" rowspan="2">

                <asp:ListBox ID="ListBoxStatus" ClientIDMode="Static" runat="server" Width="185px" Height="150px" onchange="StatusTextBoxJS(this)" DataSourceID="ListBoxStatusDB" DataTextField="StatusName" DataValueField="Sequence"></asp:ListBox>

                <asp:SqlDataSource ID="ListBoxStatusDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [StatusName], [Sequence] FROM [tblStatus] WHERE (([ProjectID] = @ProjectID) AND ([ProjectID] = @ProjectID2)) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID2" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </td>
            <td colspan="5">
                <asp:ImageButton ID="ImageButtonStatusMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxStatus','up');return false;" />

            </td>
        </tr>
        <tr>

            <td colspan="6"></td>
            <td colspan="1"></td>
            <td colspan="1">
                <asp:Button ID="ButtonRemoveStatus" runat="server" Text="Remove Status" Width="110px" OnClick="ButtonRemoveStatus_Click" /></td>
            <td colspan="2">

                <asp:ImageButton ID="ImageButtonStatusMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxStatus','down');return false;" />


            </td>
            <td colspan="5"></td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>


        <tr>
            <td colspan="1" class="auto-style13">Date Needed<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="4" class="auto-style10"><span class="auto-style2">
                <asp:TextBox ID="TextBoxDateNeeded" runat="server" ReadOnly="True" Height="20px" Width="80px"></asp:TextBox>

                <cc1:CalendarExtender ID="CalendarDateNeeded" PopupButtonID="ImageButtonDateNeeded" runat="server" TargetControlID="TextBoxDateNeeded" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateNeeded" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
            </span></td>
            <td colspan="1" class="text-right">Status Description*:</td>
            <td colspan="9">
                <asp:TextBox ID="TextBoxStatusDescription" runat="server" MaxLength="1000" TextMode="MultiLine" Height="150px" Width="300px"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">Expected Completion Date<span class="auto-style1">*</span><span class="auto-style2">:</span></td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpCompletionDate" runat="server" ReadOnly="True" Height="20px" Width="80px"></asp:TextBox>
                <span class="auto-style2">

                    <cc1:CalendarExtender ID="CalendarExpComplDate" PopupButtonID="ImageButtonExpCompletionDate" runat="server" TargetControlID="TextBoxExpCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                    <asp:ImageButton ID="ImageButtonExpCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
                </span>
            </td>
            <td colspan="1"></td>
            <td colspan="1">Last Updated Status:

                <asp:TextBox ID="TextBoxLastUpdatedStatus" runat="server" Height="20px" Width="80px"></asp:TextBox></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

        </tr>

        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelActualCompletionDate" runat="server" Text="Actual Completion Date:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActCompletionDate" runat="server" Visible="False" ReadOnly="True" Height="20px" Width="80px"></asp:TextBox>
                <span class="auto-style2">
                    <cc1:CalendarExtender ID="CalendarActComplDate" PopupButtonID="ImageButtonActCompletionDate" runat="server" TargetControlID="TextBoxActCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                    <asp:ImageButton ID="ImageButtonActCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" />
                </span>
            </td>
            <td colspan="1" class="auto-style13">Associated Meetinng Note(s):</td>

            <td colspan="9">
                <asp:Button ID="ButtonAssociateMeetingNOtes" runat="server" Text="Associate Meeting Notes" />
            </td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="5"></td>
            <td colspan="1" class="text-right">Last Updated Note:</td>
            <td colspan="9">
                <asp:TextBox ID="TextBoxLastUpdatedNote" runat="server"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelDateMade" runat="server" Text="Date Made:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDateMade" runat="server" Visible="False" ReadOnly="True" Height="20px" Width="80px"></asp:TextBox>
                <span class="auto-style2">
                    <cc1:CalendarExtender ID="Calendar1" PopupButtonID="ImageButtonDateMade" runat="server" TargetControlID="TextBoxDateMade" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                    <asp:ImageButton ID="ImageButtonDateMade" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" />
                </span>
            </td>
            <td colspan="1" class="text-right">Associated Reference Document(s):</td>
            <td colspan="9">
                <asp:Button ID="ButtonAssociateRefDocs" runat="server" Text="Associate Reference Documents" Width="249px" />
            </td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelDecisionMaker" runat="server" Text="Decision Maker:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDecisionMaker" runat="server" Visible="False" Width="150px"></asp:TextBox>
                <asp:Button ID="ButtonDecisionMaker" runat="server" Text="Select Resource" Visible="False" Width="115px" />
            </td>
            <td colspan="10"></td>
        </tr>

        <tr>

            <td colspan="15">&nbsp;</td>

        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" Text="New" OnClick="ButtonNew_Click" Style="height: 26px" />
            </td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>


            <td colspan="1">&nbsp;</td>
            <td colspan="1">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" Visible="False" OnClick="ButtonDelete_Click" Width="61px" />
            </td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" Visible="False" OnClick="ButtonSave_Click" />
            </td>

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
        .auto-style1 {
            color: #FF0000;
        }

        .auto-style2 {
            color: #000000;
        }

        .auto-style8 {
            height: 20px;
        }

        .auto-style9 {
            height: 25px;
        }

        .auto-style10 {
            height: 26px;
        }

        .auto-style11 {
            height: 20px;
            text-align: right;
        }

        .auto-style12 {
            height: 25px;
            text-align: right;
        }

        .auto-style13 {
            height: 26px;
            text-align: right;
        }
        .auto-style14 {
            height: 20px;
            text-align: left;
        }
    </style>

    <script type="text/javascript">
        function StatusTextBoxJS(ddl) {
            var tbStatus = document.getElementById('<%= TextBoxStatus.ClientID %>');

            if (tbStatus != null) {
                tbStatus.value = ddl.value;
            }
        }

        function PriorityTextBoxJS(ddl) {
            var tbPriority = document.getElementById('<%= TextBoxPriority.ClientID %>');

            if (tbPriority != null) {
                tbPriority.value = ddl.value;
            }
        }

        function ImpactTextBoxJS(ddl) {
            var tbImpact = document.getElementById('<%= TextBoxImpact.ClientID %>');

            if (tbImpact != null) {
                tbImpact.value = ddl.value;
            }
        }

        function listBoxMove(listBoxID, direction) {
            var listBox = document.getElementById(listBoxID);
            var selIndex = listBox.selectedIndex;

            if (-1 == selIndex) {
                alert("Please select an option to move.");
                return;
            }

            var increment = -1;
            if (direction == 'up')
                increment = -1;
            else
                increment = 1;

            if ((selIndex + increment) < 0 ||
                (selIndex + increment) > (listBox.options.length - 1)) {
                return;
            }

            var selValue = listBox.options[selIndex].value;
            var selText = listBox.options[selIndex].text;

            listBox.options[selIndex].value = listBox.options[selIndex + increment].value
            listBox.options[selIndex].text = listBox.options[selIndex + increment].text
            listBox.options[selIndex + increment].value = selValue;
            listBox.options[selIndex + increment].text = selText;
            listBox.selectedIndex = selIndex + increment;
        }
    </script>


</asp:Content>


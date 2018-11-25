<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="ActionItems.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.ActionItems" %>

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
                        <h4 class="modal-title">Search for Action Items</h4>
                    </div>

                    <div class="modal-body">
                        Action Items List:
                        <asp:DropDownList ID="DropDownListActItemSelect" runat="server" DataSourceID="DropDownListActItemDB" DataTextField="Name" DataValueField="ActionItemID" Height="30px" Width="571px" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />

                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListActItemDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [ActionItemID] FROM [tblActionItems] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Action Item" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <table style="width: 100%;">
        <tr>
            <td colspan="1">Name<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="3"><span class="auto-style3">
                <asp:TextBox ID="TextBoxName" runat="server"></asp:TextBox>
            </span></td>
            <td colspan="1"><span class="auto-style3">
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" />
            </span></td>
            <td colspan="1">Resource Assigned:</td>
            <td colspan="2"></td>
            <td colspan="7">
                <asp:Button ID="ButtonAddResource" runat="server" OnClick="ButtonAddResource_Click" Text="Add New Resource" />
            </td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>

        </tr>
        <tr>
            <td colspan="1">Description*:</td>
            <td colspan="4"><span class="auto-style3">
                <asp:TextBox ID="TextBoxDescription" runat="server" MaxLength="1000" TextMode="MultiLine"></asp:TextBox>
            </span></td>
            <td colspan="1">Status*:</td>
            <td colspan="2">
                <asp:TextBox ID="TextBoxAddStatus" runat="server"></asp:TextBox>
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonAddStatus" runat="server" OnClick="ButtonAddStatus_Click" Text="Add Status" /></td>
            <td colspan="2" rowspan="2">

                <asp:ListBox ID="ListBoxStatus" runat="server" Height="113px" Width="166px" onchange="StatusTextBoxJS(this)">
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem>Open</asp:ListItem>
                    <asp:ListItem>Closed</asp:ListItem>
                    <asp:ListItem>In Progress</asp:ListItem>
                    <asp:ListItem>Hold</asp:ListItem>
                    <asp:ListItem>Complete</asp:ListItem>
                </asp:ListBox>
            </td>
            <td colspan="5">
                <asp:Button ID="ButtonMoveUp" runat="server" Text="Move Up" OnClick="ButtonMoveUp_Click" />
            </td>

        </tr>

        <tr>
            <td colspan="6"></td>
            <td colspan="2"></td>
            <td colspan="1">
                <asp:Button ID="ButtonRemoveStatus" runat="server" OnClick="ButtonRemoveStatus_Click" Text="Remove Status" />
            </td>
            <td colspan="6">
                <asp:Button ID="ButtonMoveDown" runat="server" Text="Move Down" OnClick="ButtonMoveDown_Click" />
            </td>

        </tr>
        <tr>
            <td colspan="15" class="auto-style14"></td>
        </tr>
        <tr>
            <td colspan="1">Date Created<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="4"><span class="auto-style3">

                <asp:TextBox ID="TextBoxDateCreated" runat="server" Width="128px" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarDateCreated" PopupButtonID="ImageButtonDateCreated" runat="server" TargetControlID="TextBoxDateCreated" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateCreated" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
            </span></td>
            <td colspan="1">Status Description*:</td>
            <td colspan="8" class="auto-style13"><span class="auto-style3">
                <asp:TextBox ID="TextBoxStatusDescription" runat="server" Height="104px" MaxLength="1000" TextMode="MultiLine" Width="290px"></asp:TextBox>
            </span></td>
        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="1">Last Updated:</td>
            <td colspan="10">
                <asp:TextBox ID="TextBoxLastUpdated" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1">Date Assigned<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="4"><span class="auto-style3">
                <asp:TextBox ID="TextBoxDateAssigned" runat="server" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarDateAssigned" PopupButtonID="ImageButtonDateAssigned" runat="server" TargetControlID="TextBoxDateAssigned" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateAssigned" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
            </span></td>
            <td colspan="1">List of Available Action Items:</td>
            <td colspan="10"></td>
        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="3">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="10">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="DelivList_Scrollbar">
                    <asp:GridView ID="GridViewActionItemsList" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridActionItems" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" SortExpression="DateCreated" />
                            <asp:BoundField DataField="DateAssigned" HeaderText="DateAssigned" SortExpression="DateAssigned" />
                            <asp:BoundField DataField="ExpectedCompletionDate" HeaderText="ExpectedCompletionDate" SortExpression="ExpectedCompletionDate" />
                            <asp:BoundField DataField="ActualCompletionDate" HeaderText="ActualCompletionDate" SortExpression="ActualCompletionDate" />
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="StatusDescription" HeaderText="StatusDescription" SortExpression="StatusDescription" />
                            <asp:BoundField DataField="UpdateDate" HeaderText="UpdateDate" SortExpression="UpdateDate" />
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
                <asp:SqlDataSource ID="GridActionItems" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [DateCreated], [DateAssigned], [ExpectedCompletionDate], [ActualCompletionDate], [Status], [StatusDescription], [UpdateDate] FROM [tblActionItems] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="1">Expected Completion Date:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpectedCompletionDate" runat="server" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpComplDate" PopupButtonID="ImageButtonExpectedCompletionDate" runat="server" TargetControlID="TextBoxExpectedCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpectedCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
            </td>
            <td colspan="10"></td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>
        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="1">Actual Completion Date:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualCompletionDate" runat="server" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarActComplDate" PopupButtonID="ImageButtonActualCompletionDate" runat="server" TargetControlID="TextBoxActualCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActualCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
            </td>

            <td colspan="10"></td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" OnClick="ButtonNew_Click" Text="New" />
            </td>
            <td colspan="4"></td>
            <td colspan="1">
                <asp:Button ID="ButtonDelete" runat="server" OnClick="ButtonDelete_Click" Text="Delete" />
            </td>
            <td colspan="4"></td>
            <td colspan="1">
                <asp:Button ID="ButtonSave" runat="server" OnClick="ButtonSave_Click" Text="Save" />
            </td>
            <td colspan="4"></td>
        </tr>
    </table>

    <script type="text/javascript">
        function StatusTextBoxJS(ddl) {
            var tbStatus = document.getElementById('<%= TextBoxAddStatus.ClientID %>');

            if (tbStatus != null)
            {
                tbStatus.value = ddl.value;
            }

        }
    </script>
</asp:Content>


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
                        <asp:TextBox ID="TextBoxAddStatus" runat="server" autofocus=""></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalAddStatus" runat="server" Text="Add New Status" CssClass="btn btn-default" OnClick="ButtonModalAddStatus_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <table style="width: 100%;">
        <tr>
            <td colspan="1" class="text-right">Name*:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxName" runat="server" Width="300px" Height="20px"></asp:TextBox>
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" Width="60px" />
            </td>

            <td colspan="4">
                Resource Assigned:<asp:DropDownList ID="DropDownListResourceSelect" runat="server" DataSourceID="DropDownListRescDB" DataTextField="Name" DataValueField="ResourceID" Height="20px" Width="300px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="DropDownListRescDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [ResourceID] FROM [tblResources] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>

            <td colspan="1">
                <asp:Button ID="ButtonAddResource" runat="server" OnClick="ButtonAddResource_Click" Text="Add New Resource" Width="135px" /></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1" class="auto-style12"></td>
            <td colspan="1"></td>
        </tr>

        <tr>
            <td colspan="1">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1" class="auto-style12"></td>
        </tr>

        <tr style="vertical-align: top">
            <td colspan="1" class="text-right">Description*:</td>
            <td colspan="4" rowspan="2">
                <asp:TextBox ID="TextBoxDescription" runat="server" MaxLength="1000" TextMode="MultiLine" Height="150px" Width="300px"></asp:TextBox></td>
            <td colspan="2">
                Status*:<asp:TextBox ID="TextBoxStatus" runat="server" Height="20px" Width="150px"></asp:TextBox></td>
            <td colspan="2" rowspan="2">
                <asp:Button ID="ButtonAddStatus" runat="server" Text="Add Status" data-toggle="modal" data-target="#myModal2" OnClientClick="return false;" Width="85px" />


                <br />
                <br />


                <asp:Button ID="ButtonRemoveStatus" runat="server" Text="Remove Status" Width="110px" OnClick="ButtonRemoveStatus_Click" />


            </td>

            <td colspan="1" rowspan="2">
                <asp:ListBox ID="ListBoxStatus" ClientIDMode="Static" runat="server" Height="150px" Width="185px" onchange="StatusTextBoxJS(this)" DataSourceID="ListBoxStatusDB" DataTextField="StatusName" DataValueField="Sequence"></asp:ListBox>
                <asp:SqlDataSource ID="ListBoxStatusDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [StatusName], [Sequence] FROM [tblStatus] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID)) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td colspan="1">
                <asp:ImageButton ID="ImageButtonStatusMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxStatus', 'up'); return false;" />
                <br />
                <br />
                <asp:ImageButton ID="ImageButtonStatusMoveDown" runat="server" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxStatus' , 'down'); return false;" Height="30px" /></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

        </tr>

        <tr>
            <td colspan="1">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
        </tr>
        <tr>
            <td colspan="1">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1" class="auto-style12"></td>
        </tr>

        <tr style="vertical-align: top">
            <td colspan="1" class="auto-style5">
            Date Created*:
           
            <td colspan="4" class="auto-style4">
                <asp:TextBox ID="TextBoxDateCreated" runat="server" Width="80px" ReadOnly="True" Height="20px"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarDateCreated" PopupButtonID="ImageButtonDateCreated" runat="server" TargetControlID="TextBoxDateCreated" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateCreated" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" /></td>


            <td colspan="5" class="auto-style4">
                Status Description*:<asp:TextBox ID="TextBoxStatusDescription" runat="server" Height="150px" MaxLength="1000" TextMode="MultiLine" Width="300px"></asp:TextBox>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Last Updated:<asp:TextBox ID="TextBoxLastUpdated" runat="server" Height="20px" Width="80px"></asp:TextBox>
            </td>


            <td colspan="1" class="auto-style4"></td>
            <td colspan="1" class="auto-style4"></td>
            <td colspan="1" class="auto-style4"></td>
            <td colspan="1" class="auto-style4"></td>
            <td colspan="1" class="auto-style13"></td>
        </tr>

        <tr>
            <td colspan="1">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1" class="auto-style12"></td>
        </tr>

        <tr>
            <td colspan="1" class="text-right">Date Assigned<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDateAssigned" runat="server" ReadOnly="True" Width="80px" Height="20px"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarDateAssigned" PopupButtonID="ImageButtonDateAssigned" runat="server" TargetControlID="TextBoxDateAssigned" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateAssigned" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" /></td>


            <td colspan="1" class="text-left">List of Available Action Items:</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1" class="auto-style12"></td>
        </tr>

        <tr>
            <td colspan="1">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="10">
                <div runat="server" id="DelivList_Scrollbar" class="auto-style5">
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
                <asp:SqlDataSource ID="GridActionItems" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [Description], [DateCreated], [DateAssigned], [ExpectedCompletionDate], [ActualCompletionDate], [Status], [StatusDescription], [UpdateDate] FROM [tblActionItems] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                </div>
            </td>

        </tr>

        <tr>
            <td colspan="1" class="text-right">Expected Completion Date:</td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpectedCompletionDate" runat="server" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpComplDate" PopupButtonID="ImageButtonExpectedCompletionDate" runat="server" TargetControlID="TextBoxExpectedCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpectedCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" /></td>

        </tr>

        <tr>
            <td colspan="1">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>


        </tr>

        <tr>
            <td colspan="1" class="text-right">
                <asp:Label ID="LabelActComplDate" runat="server" Text="Actual Completion Date:" Visible="False"></asp:Label>
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxActualCompletionDate" runat="server" ReadOnly="True" Visible="False"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarActComplDate" PopupButtonID="ImageButtonActualCompletionDate" runat="server" TargetControlID="TextBoxActualCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActualCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" /></td>

        </tr>

        <tr>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1" class="auto-style12"></td>
        </tr>

        <tr>
            <td colspan="1">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1" class="auto-style12"></td>
        </tr>

        <tr>
            <td colspan="1">&nbsp;</td>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" OnClick="ButtonNew_Click" Text="New" Width="100px" />
            </td>
            <td colspan="1"></td>
            <td colspan="1">&nbsp;</td>
            <td colspan="1"></td>

            <td colspan="1" class="text-right">
                <asp:Button ID="ButtonDelete" runat="server" OnClick="ButtonDelete_Click" Text="Delete" Visible="False" Width="75px" />
            </td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1">&nbsp;</td>
            <td colspan="1" class="text-right">
                <asp:Button ID="ButtonSave" runat="server" OnClick="ButtonSave_Click" Text="Save" Visible="False" Width="125px" />
            </td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1" class="auto-style12"></td>
        </tr>
    </table>
    <script type="text/javascript">
        function StatusTextBoxJS(ddl) {
            var tbStatus = document.getElementById('<%= TextBoxStatus.ClientID %>');

            if (tbStatus != null) {
                tbStatus.value = ddl.value;
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

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .auto-style1 {
            height: 20px;
        }

        .auto-style3 {
            height: 32px;
        }

        .auto-style4 {
            height: 26px;
        }

        .auto-style5 {
            height: 26px;
            text-align: right;
        }

        .auto-style12 {
            width: 12px;
        }

        .auto-style13 {
            height: 26px;
            width: 12px;
        }
    </style>
</asp:Content>



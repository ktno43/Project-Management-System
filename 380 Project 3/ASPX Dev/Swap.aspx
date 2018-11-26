<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Swap.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Swap" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 20px;
        }

        * {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box
        }

        *, :after, :before {
            color: #000 !important;
            text-shadow: none !important;
            background: 0 0 !important;
            -webkit-box-shadow: none !important;
            box-shadow: none !important
        }

        .auto-style3 {
            height: 32px;
        }

        .auto-style4 {
            height: 160px;
        }

        .auto-style5 {
            overflow: scroll;
            height: 250px;
            width: 868px;
        }
    </style>

</head>
<body>
    <asp:ScriptManager ID="toolScriptManager" runat="server">
    </asp:ScriptManager>
    <form id="form1" runat="server">



        <table style="width: 100%;">
            <tr>
                <td colspan="1">Name*:</td>
                <td colspan="4">
                    <asp:TextBox ID="TextBoxName" runat="server" Width="300px" Height="20px"></asp:TextBox>
                    <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" Width="60px" />
                </td>

                <td colspan="1">Resource Assigned:</td>
                <td colspan="4">
                    <asp:DropDownList ID="DropDownListResources" runat="server" DataSourceID="DropDownListRescDB" DataTextField="Name" DataValueField="ResourceID" Width="300px">
                    </asp:DropDownList>
                    <asp:Button ID="ButtonAddResource" runat="server" OnClick="ButtonAddResource_Click" Text="Add New Resource" Width="135px" />
                    <asp:SqlDataSource ID="DropDownListRescDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [ResourceID] FROM [tblResources] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID))">
                        <SelectParameters>
                            <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                            <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>

                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
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
                <td colspan="1"></td>
            </tr>

            <tr>
                <td colspan="1">Description*:</td>
                <td colspan="4">
                    <asp:TextBox ID="TextBoxDescription" runat="server" MaxLength="1000" TextMode="MultiLine" Height="150px" Width="300px"></asp:TextBox></td>


                <td colspan="1">Status*:</td>
                <td colspan="3">
                    <asp:TextBox ID="TextBoxStatus" runat="server" Height="20px" Width="150px"></asp:TextBox></td>

                <td colspan="1">
                    <asp:Button ID="ButtonAddStatus" runat="server" Text="Add Status" data-toggle="modal" data-target="#myModal2" OnClientClick="return false;" Width="85px" />


                    <asp:Button ID="ButtonRemoveStatus" runat="server" Text="Remove Status" Width="110px" /></td>

                <td colspan="2">
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
                <td colspan="1"></td>
            </tr>

            <tr>
                <td colspan="1" class="auto-style4">Date Created*:</td>
                <td colspan="4" class="auto-style4">
                    <asp:TextBox ID="TextBoxDateCreated" runat="server" Width="80px" ReadOnly="True" Height="20px"></asp:TextBox>
                    <cc1:CalendarExtender ID="CalendarDateCreated" PopupButtonID="ImageButtonDateCreated" runat="server" TargetControlID="TextBoxDateCreated" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                    <asp:ImageButton ID="ImageButtonDateCreated" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" /></td>


                <td colspan="1" class="auto-style4">Status Description*:</td>
                <td colspan="4" class="auto-style4">
                    <asp:TextBox ID="TextBoxStatusDescription" runat="server" Height="150px" MaxLength="1000" TextMode="MultiLine" Width="300px"></asp:TextBox>
                    <br />
                    Last Updated:<asp:TextBox ID="TextBoxLastUpdated" runat="server" Height="20px" Width="80px"></asp:TextBox>
                </td>


                <td colspan="1" class="auto-style4"></td>
                <td colspan="1" class="auto-style4"></td>
                <td colspan="1" class="auto-style4"></td>
                <td colspan="1" class="auto-style4"></td>
                <td colspan="1" class="auto-style4"></td>
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
                <td colspan="1"></td>
            </tr>

            <tr>
                <td colspan="1">Date Assigned<span class="auto-style1">*</span><span class="auto-style3">:</span></td>
                <td colspan="4">
                    <asp:TextBox ID="TextBoxDateAssigned" runat="server" ReadOnly="True" Width="80px" Height="20px"></asp:TextBox>
                    <cc1:CalendarExtender ID="CalendarDateAssigned" PopupButtonID="ImageButtonDateAssigned" runat="server" TargetControlID="TextBoxDateAssigned" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                    <asp:ImageButton ID="ImageButtonDateAssigned" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" /></td>


                <td colspan="1">List of Available Action Items:</td>
                <td colspan="1"></td>
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
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>

                <td colspan="10" rowspan="4">
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
                <td colspan="1">Expected Completion Date:</td>
                <td colspan="4">
                    <asp:TextBox ID="TextBoxExpectedCompletionDate" runat="server" ReadOnly="True"></asp:TextBox>
                    <cc1:CalendarExtender ID="CalendarExpComplDate" PopupButtonID="ImageButtonExpectedCompletionDate" runat="server" TargetControlID="TextBoxExpectedCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                    <asp:ImageButton ID="ImageButtonExpectedCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" /></td>

            </tr>

            <tr>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>


            </tr>

            <tr>
                <td colspan="1">
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
                <td colspan="1"></td>
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
                <td colspan="1"></td>
            </tr>

            <tr>
                <td colspan="1">
                    <asp:Button ID="ButtonNew" runat="server" OnClick="ButtonNew_Click" Text="New" Width="100px" />
                </td>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1">
                    <asp:Button ID="ButtonDelete" runat="server" OnClick="ButtonDelete_Click" Text="Delete" Visible="False" Width="75px" />
                </td>
                <td colspan="1"></td>

                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1">&nbsp;</td>
                <td colspan="1">
                    <asp:Button ID="ButtonSave" runat="server" OnClick="ButtonSave_Click" Text="Save" Visible="False" Width="125px" />
                </td>

                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
                <td colspan="1"></td>
            </tr>
        </table>







    </form>
</body>
</html>

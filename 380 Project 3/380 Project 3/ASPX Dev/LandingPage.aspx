<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.LandingPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Menu ID="Menu1" runat="server" BackColor="#E3EAEB" DynamicHorizontalOffset="2" Font-Names="Verdana" Font-Size="1.6em" ForeColor="#666666" Height="108px" OnMenuItemClick="Menu1_MenuItemClick" Orientation="Horizontal" StaticSubMenuIndent="10px" Width="100%">
                <DynamicHoverStyle BackColor="#666666" ForeColor="White" />
                <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px"/>
                <DynamicMenuStyle BackColor="#E3EAEB" />
                <DynamicSelectedStyle BackColor="#1C5E55" />
                <Items>
                    <asp:MenuItem Text="Deliverables" Value="Deliverables"></asp:MenuItem>
                    <asp:MenuItem Text="Tasks" Value="Tasks">
                        <asp:MenuItem Text="Tasks" Value="Tasks"></asp:MenuItem>
                        <asp:MenuItem Text="Summary Tasks" Value="Summary Tasks"></asp:MenuItem>
                        <asp:MenuItem Text="Milestones" Value="Milestones"></asp:MenuItem>
                    </asp:MenuItem>
                    <asp:MenuItem Text="Action Items" Value="Action Items"></asp:MenuItem>
                    <asp:MenuItem Text="Decisions" Value="Decisions"></asp:MenuItem>
                    <asp:MenuItem Text="Resources" Value="Resources"></asp:MenuItem>
                    <asp:MenuItem Text="Rsisks" Value="Rsisks"></asp:MenuItem>
                    <asp:MenuItem Text="Requirements" Value="Requirements"></asp:MenuItem>
                    <asp:MenuItem Text="Changes" Value="Changes"></asp:MenuItem>
                    <asp:MenuItem Text="Reference Documents" Value="Reference Documents"></asp:MenuItem>
                    <asp:MenuItem Text="Components" Value="Components"></asp:MenuItem>
                    <asp:MenuItem Text="Defects" Value="Defects"></asp:MenuItem>
                </Items>
                <StaticHoverStyle BackColor="#666666" ForeColor="White" />
                <StaticMenuItemStyle HorizontalPadding="15px" VerticalPadding="2px" />
                <StaticSelectedStyle BackColor="#1C5E55" />
            </asp:Menu>
            <table style="width:100%;">
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
        </div>
    </form>
</body>
</html>

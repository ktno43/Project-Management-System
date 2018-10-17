<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Deliverables.aspx.cs" Inherits="_380_Project_3.Deliverables" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }
        .auto-style2 {
            width: 100%;
        }
        .auto-style3 {
            height: 23px;
            width: 35px;
            text-align: right;
        }
        .auto-style4 {
            width: 35px;
        }
        .auto-style5 {
            color: #FF0000;
        }
        .auto-style6 {
            color: #000000;
        }
        .auto-style7 {
            width: 35px;
            text-align: right;
        }
        .auto-style8 {
            height: 23px;
            width: 507px;
        }
        .auto-style9 {
            width: 507px;
        }
        .auto-style10 {
            width: 500px;
            height: 250px;
        }
        .auto-style11 {
            height: 422px;
        }
        .auto-style12 {
            width: 35px;
            height: 192px;
        }
        .auto-style13 {
            width: 507px;
            height: 192px;
        }
        .auto-style14 {
            height: 192px;
        }
        .auto-style15 {
            text-align: right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="auto-style11">
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
        </div>
        <table class="auto-style2">
            <tr>
                <td class="auto-style3">Name<span class="auto-style5">*</span><span class="auto-style6">:</span></td>
                <td class="auto-style8">
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    <asp:Button ID="Button1" runat="server" Text="Search" />
                </td>
                <td class="auto-style1">
                    <table style="width:100%;">
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>Associated Requirement(s):</td>
                            <td>&nbsp;</td>
                            <td class="auto-style15">
                                <asp:Button ID="Button5" runat="server" Text="Associate Requirements" />
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
                <td class="auto-style7">Description<span class="auto-style5">*</span><span class="auto-style6">:</span></td>
                <td class="auto-style9">
                    <textarea id="TextArea1" class="auto-style10" name="S1"></textarea></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style12">Start Date:<br />
                    <br />
                    <br />
                    <br />
                    <br />
                </td>
                <td class="auto-style13">
                    <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                </td>
                <td class="auto-style14">
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td>Associated Task(s):</td>
                            <td>&nbsp;</td>
                            <td class="auto-style15">
                                <asp:Button ID="Button7" runat="server" Text="Associate Tasks" />
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
                <td class="auto-style4">Due Date:</td>
                <td class="auto-style9">
                    <asp:Calendar ID="Calendar2" runat="server"></asp:Calendar>
                </td>
                <td>
                    <table style="width:100%;">
                        <tr>
                            <td>List of Deliverable(s):</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style1"></td>
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
                <td class="auto-style4">&nbsp;</td>
                <td class="auto-style9">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style4">&nbsp;</td>
                <td class="auto-style9">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style4">&nbsp;</td>
                <td class="auto-style9">&nbsp;</td>
                <td>
                    <table style="width:100%;">
                        <tr>
                            <td>
                                <asp:Button ID="Button2" runat="server" Text="New" Width="77px" />
                            </td>
                            <td class="auto-style15">
                                <asp:Button ID="Button3" runat="server" Text="Delete" Width="96px" />
                            </td>
                            <td class="auto-style15">
                                <asp:Button ID="Button4" runat="server" Text="Save" Width="131px" />
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
                <td class="auto-style4">&nbsp;</td>
                <td class="auto-style9">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>

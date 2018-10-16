<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectSelection.aspx.cs" Inherits="_380_Project_3.ProjectSelection" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 95%;
            height: 94%;
        }
        .auto-style2 {
            width: 431px;
        }
        .auto-style3 {
            width: 431px;
            text-align: right;
        }
        .auto-style4 {
            width: 531px;
        }
        .auto-style5 {
            text-align: center;
        }
    </style>
</head>
<body style="height: 170px; width: 1214px;">
    <form id="form1" runat="server">
        <div>
            <h1 class="auto-style5">Welcome to the Project Management System</h1>
        </div>
    <table class="auto-style1">
        <tr>
            <td class="auto-style3">Select Project:</td>
            <td class="auto-style4">
                <asp:DropDownList ID="DropDownList1" runat="server" Height="18px" Width="615px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style2">&nbsp;</td>
            <td class="auto-style4">
                <asp:Button ID="Button1" runat="server" Text="Delete Project" Width="151px" OnClick="Button1_Click" />
            </td>
            <td>
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="New Project" Width="136px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style3">Project Name:</td>
            <td class="auto-style4">
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="Button3" runat="server" Text="Export Reports" />
            </td>
        </tr>
    </table>
    </form>
    </body>
</html>

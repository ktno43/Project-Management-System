<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="_380_Project_3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style2 {
            text-align: center;
        }
        .auto-style3 {
            height: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style2">
            <h1>Welcome to the Project Management System</h1>
        </div>
        <div>
            <table align="center">
                <tr>
                    <td>Username:</td>
                    <td>
                        <asp:TextBox ID="TextBoxUsername" runat="server" TabIndex="1"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td>
                        <asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password" TabIndex="2"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Label" runat="server" Text="[Label 1]" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3"></td>
                    <td class="auto-style3">
                        <asp:Button ID="ButtonLogin" runat="server" OnClick="Button_Login_Click" Text="Login" Width="69px" TabIndex="3" />
                    </td>
                    <td class="auto-style3"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>

﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="_380_Project_3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 516px;
        }
        .auto-style2 {
            text-align: center;
        }
        .auto-style3 {
            width: 516px;
            text-align: right;
        }
        .auto-style4 {
            text-align: left;
            width: 168px;
            margin-left: 40px;
        }
        .auto-style5 {
            width: 168px;
        }
        .auto-style6 {
            width: 100%;
            height: 101px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style2">
            <h1>Welcome to the Project Management System</h1>
        </div>
    <table class="auto-style6">
        <tr>
            <td class="auto-style3">Username:</td>
            <td class="auto-style4">
                <asp:TextBox ID="TextBoxUsername" runat="server" TabIndex="1"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style3">Password:</td>
            <td class="auto-style5">
                <asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password" TabIndex="2"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="Label" runat="server" Text="[Label 1]" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                &nbsp;</td>
            <td class="auto-style5">
        <asp:Button ID="ButtonLogin" runat="server" OnClick="Button_Login_Click" Text="Login" Width="69px" TabIndex="3" />
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
    </form>
    </body>
</html>

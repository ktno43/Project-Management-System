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
        .auto-style6 {
            width: 100%;
        }
        .auto-style7 {
            text-align: right;
            height: 30px;
        }
        .auto-style8 {
            height: 30px;
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
                <asp:DropDownList ID="DropDownList1" runat="server" Height="18px" Width="615px" AutoPostBack="True" DataSourceID="ProjectDropDownList" DataTextField="ProjectName" DataValueField="ProjectID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="ProjectDropDownList" runat="server" ConnectionString="<%$ ConnectionStrings:Project DBConnectionString %>" SelectCommand="SELECT [ProjectName], [ProjectID] FROM [tblProjSelect] WHERE ([UserID] = @UserID) ORDER BY [ProjectName]">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:Button ID="ButtonOpen" runat="server" OnClick="Button_Open_Click" Text="Open Project" Width="137px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style2">&nbsp;</td>
            <td class="auto-style4">
                <asp:Button ID="ButtonDel" runat="server" Text="Delete Project" Width="151px" OnClick="Button_Del_Click" />
            </td>
            <td>
                <asp:Button ID="ButtonNew" runat="server" OnClick="Button_New_Click" Text="New Project" Width="139px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style3">&nbsp;</td>
            <td class="auto-style4">
                &nbsp;</td>
            <td>
                <asp:Button ID="ButtonExport" runat="server" Text="Export Reports" Width="138px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style3">&nbsp;</td>
            <td class="auto-style4">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:Label ID="LabelProjectName" runat="server" Text="Project Name" Visible="False"></asp:Label>
            </td>
            <td class="auto-style4">
                <table class="auto-style6">
                    <tr>
                        <td class="auto-style8">
                            <asp:TextBox ID="TextBoxProjectName" runat="server" Visible="False" Width="447px"></asp:TextBox>
                        </td>
                        <td class="auto-style7">
                            <asp:Button ID="ButtonCreate" runat="server" OnClick="ButtonCreate_Click" Text="Create Project" Visible="False" Width="142px" />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    </form>
    <p>
        &nbsp;</p>
    </body>
</html>

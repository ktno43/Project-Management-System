<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Testing.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Testing" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="toolScriptManager" runat="server">
        </asp:ScriptManager>

        <asp:TextBox ID="TextBoxStartDate" runat="server"></asp:TextBox>
        <cc1:CalendarExtender ID="Calendar1" PopupButtonID="ImageButtonCalendar" runat="server" TargetControlID="TextBoxStartDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
        <asp:ImageButton ID="ImageButtonCalendar" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" />
    </form>
</body>
</html>

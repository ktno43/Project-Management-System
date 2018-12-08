<%@ Page Language="C#" MasterPageFile="siteMaster.Master" AutoEventWireup="true" CodeBehind="Resources.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Resources" %>

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
                        <h4 class="modal-title">Search for Resources</h4>
                    </div>

                    <div class="modal-body">
                        Resource List:
                        <asp:DropDownList ID="DropDownListResourceSelect" runat="server" DataSourceID="DropDownListResourceDB" DataTextField="Name" DataValueField="ResourceID" Height="30px" Width="571px" AppendDataBoundItems="true">


                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListResourceDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [ResourceID] FROM [tblResources] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Resource" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>

    </div>

    <table style="width: 100%;">
        <tr>
            <td colspan="1" class="auto-style11">Name<span class="auto-style2">*</span><span class="auto-style3">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="3"><span class="auto-style3">
                <asp:TextBox ID="TextBoxName" runat="server" TabIndex="1" Height="20px" Width="240px"></asp:TextBox>
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" Width="60px" />
            </span></td>
            <td colspan="1">&nbsp;</td>
            <td colspan="10">Availability Calendar:&nbsp;&nbsp;&nbsp; <asp:TextBox ID="TextBoxAvailability" runat="server" ReadOnly="True" BackColor="#CCCCCC" Height="20px" Width="240px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="15" class="auto-style10"></td>
        </tr>
        <tr>
            <td colspan="1" class="auto-style11">Title<span class="auto-style2">*</span><span class="auto-style3">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="5"><span class="auto-style3">
                <asp:TextBox ID="TextBoxTitle" runat="server" TabIndex="2" Height="20px" Width="100px"></asp:TextBox>
            </span></td>
            <td colspan="1">Available Start Date<span class="auto-style2">*</span>:&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="TextBoxStartDate" runat="server" Width="80px" Height="20px" onchange="fnOnDateChange()" BackColor="#CCCCCC"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarStartDate" PopupButtonID="ImageButtonStartDate" runat="server" TargetControlID="TextBoxStartDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonStartDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="6" />
            </td>
            <td colspan="8">Available End Date<span class="auto-style2">*</span>:&nbsp;&nbsp;&nbsp;&nbsp; 
                                <asp:TextBox ID="TextBoxEndDate" runat="server" Width="80px" Height="20px" onchange="fnOnDateChange()" BackColor="#CCCCCC"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarEndDate" PopupButtonID="ImageButtonEndDate" runat="server" TargetControlID="TextBoxEndDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonEndDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="7" />
            </td>
        </tr>

        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="1" class="auto-style11" style="vertical-align: top">Description<span class="auto-style2">*</span><span class="auto-style3">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="14"><span class="auto-style3">
                <asp:TextBox ID="TextBoxDescription" runat="server" Height="150px" MaxLength="1000" TextMode="MultiLine" Width="300px" TabIndex="3"></asp:TextBox>
            </span></td>
        </tr>
        <tr>
            <td colspan="15" class="auto-style10"></td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style11" style="vertical-align: top">List of Skills<span class="auto-style2">*</span><span class="auto-style3">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="14"><span class="auto-style3">
                <asp:TextBox ID="TextBoxSkillsDescription" runat="server" Height="150px" MaxLength="1000" TextMode="MultiLine" Width="300px" TabIndex="4"></asp:TextBox>
            </span></td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="1" class="auto-style11">Pay Rate<span class="auto-style2">*</span><span class="auto-style3">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="14"><span class="auto-style3">
                <asp:TextBox ID="TextBoxPayRate" runat="server" TabIndex="5" Height="20px" Width="100px"></asp:TextBox>
            </span></td>
        </tr>

        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="1" class="auto-style12"></td>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" Text="New" OnClick="ButtonNew_Click" Width="100px" TabIndex="8" />
            </td>
            <td colspan="5">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" OnClick="ButtonDelete_Click" Visible="False" Width="75px" />
            </td>
            <td colspan="2">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" OnClick="ButtonSave_Click" Visible="False" TabIndex="9" Width="125px" />
            </td>
            <td colspan="6">&nbsp;</td>
        </tr>

    </table>
    <script type="text/javascript">
        function fnOnDateChange() {
            var sStartDate = document.getElementById('<%= TextBoxStartDate.ClientID %>').value;
            var sEndDate = document.getElementById('<%= TextBoxEndDate.ClientID %>').value;


            if (sStartDate != null && sEndDate != null && sStartDate != '' && sEndDate != '') {
                var startDate = new Date(sStartDate);
                var endDate = new Date(sEndDate);

                var availability = startDate.toLocaleDateString('en-US') + " to " + endDate.toLocaleDateString('en-US');
                document.getElementById('<%= TextBoxAvailability.ClientID %>').value = availability;
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .auto-style2 {
            color: #FF0000;
        }

        .auto-style3 {
            color: #000000;
        }

        .auto-style10 {
            height: 20px;
        }

        .auto-style11 {
            text-align: right;
            width: 200px;
        }

        .auto-style12 {
            width: 200px;
        }
    </style>
</asp:Content>


<%@ Page Language="C#" MasterPageFile="siteMaster.Master" AutoEventWireup="true" CodeBehind="Resources.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Resources" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
                            <asp:ListItem Text="" Value="" />

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
            <td colspan="1">Name<span class="auto-style2">*</span><span class="auto-style3">:</span></td>
            <td colspan="3"><span class="auto-style3">
                <asp:TextBox ID="TextBoxName" runat="server"></asp:TextBox>
            </span></td>
            <td colspan="1"><span class="auto-style3">
                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" />
            </span></td>
            <td colspan="10">Availability Calendar*:</td>
        </tr>
        <tr>
            <td colspan="15"></td>
        </tr>
        <tr>
            <td colspan="1">Title<span class="auto-style2">*</span><span class="auto-style3">:</span></td>
            <td colspan="14"><span class="auto-style3">
                <asp:TextBox ID="TextBoxTitle" runat="server"></asp:TextBox>
            </span></td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>
        <tr>
            <td colspan="1">Description<span class="auto-style2">*</span><span class="auto-style3">:</span></td>
            <td colspan="14"><span class="auto-style3">
                <asp:TextBox ID="TextBoxDescription" runat="server" Height="128px" MaxLength="1000" TextMode="MultiLine" Width="238px"></asp:TextBox>
            </span></td>
        </tr>
        <tr>
            <td colspan="15"></td>
        </tr>

        <tr>
            <td colspan="1">List of Skills<span class="auto-style2">*</span><span class="auto-style3">:</span></td>
            <td colspan="14"><span class="auto-style3">
                <asp:TextBox ID="TextBoxSkillsDescription" runat="server" Height="128px" MaxLength="1000" TextMode="MultiLine" Width="238px"></asp:TextBox>
            </span></td>
        </tr>
        <tr>
            <td colspan="15"></td>
        </tr>
        <tr>
            <td colspan="1">Pay Rate<span class="auto-style2">*</span><span class="auto-style3">:</span></td>
            <td colspan="14"><span class="auto-style3">
                <asp:TextBox ID="TextBoxPayRate" runat="server"></asp:TextBox>
            </span></td>
        </tr>

        <tr>
            <td colspan="15"></td>
        </tr>
        <tr>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" Text="New" OnClick="ButtonNew_Click" Width="68px" />
            </td>
            <td colspan="4">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" OnClick="ButtonDelete_Click" Visible="False" />
            </td>
            <td colspan="10">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" OnClick="ButtonSave_Click" Visible="False" />
            </td>
        </tr>

    </table>

</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }

        .auto-style2 {
            color: #FF0000;
        }

        .auto-style3 {
            color: #000000;
        }

        .auto-style4 {
            text-align: justify;
            width: 324px;
        }

        .auto-style5 {
            text-align: right;
        }

        .auto-style6 {
            height: 23px;
            width: 324px;
        }

        .auto-style8 {
            text-align: right;
            width: 324px;
        }

        .auto-style9 {
            width: 324px;
        }
    </style>
</asp:Content>


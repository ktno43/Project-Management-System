<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Decisions.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Decisions" %>

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
                        <h4 class="modal-title">Search for Decisions</h4>
                    </div>

                    <div class="modal-body">
                        Decisions List:
                        <asp:DropDownList ID="DropDownListDecisionSelect" runat="server" DataSourceID="DropDownListDecisionDB" DataTextField="Name" DataValueField="DecisionID" Height="30px" Width="571px" AppendDataBoundItems="true">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListDecisionDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [DecisionID] FROM [tblDecisions] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Decision" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="container">
        <!-- Modal -->
        <div class="modal fade" id="myModal2" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Status</h4>
                    </div>

                    <div class="modal-body">
                        Status Name:
                    <br />
                        <asp:TextBox ID="TextBoxAddStatus" autofocus="" runat="server"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalAddStatus" runat="server" Text="Add New Status" CssClass="btn btn-default" OnClick="ButtonModalAddStatus_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="container">
        <!-- Modal -->
        <div class="modal fade" id="myModal3" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Impact</h4>
                    </div>

                    <div class="modal-body">
                        Impact Name:
                    <br />
                        <asp:TextBox ID="TextBoxAddImpact" autofocus="" runat="server"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalAddImpact" runat="server" Text="Add New Impact" CssClass="btn btn-default" OnClick="ButtonModalAddImpact_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="container">
        <!-- Modal -->
        <div class="modal fade" id="myModal4" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Priority</h4>
                    </div>

                    <div class="modal-body">
                        Priority Name:
                    <br />
                        <asp:TextBox ID="TextBoxAddPriority" autofocus="" runat="server"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalAddPriority" runat="server" Text="Add New Priority" CssClass="btn btn-default" OnClick="ButtonModalAddPriority_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="container2">
        <!-- Modal -->
        <div class="modal fade" id="myModal6" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Associate a Resource</h4>
                    </div>

                    <div class="modal-body">
                        Resources List:
                               <div style="overflow-y: scroll; height: 250px">
                                   <asp:GridView ID="GridViewAssociateResource" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSourceAssociateResource" ForeColor="#333333" GridLines="None" Width="472px" DataKeyNames="ResourceID">
                                       <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                       <Columns>
                                           <asp:BoundField DataField="ResourceID" HeaderText="ResourceID" InsertVisible="False" ReadOnly="True" SortExpression="ResourceID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                           <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                           <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                           <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                                           <asp:BoundField DataField="ListOfSkills" HeaderText="List Of Skills" SortExpression="ListOfSkills" />
                                           <asp:BoundField DataField="PayRate" HeaderText="Pay Rate" SortExpression="PayRate" />
                                           <asp:BoundField DataField="AvailableStartDate" HeaderText="Available Start Date" SortExpression="AvailableStartDate" />
                                           <asp:BoundField DataField="AvailableEndDate" HeaderText="Available End Date" SortExpression="AvailableEndDate" />
                                           <asp:TemplateField>
                                               <ItemTemplate>
                                                   <asp:RadioButton ID="RadioButtonResource" runat="server" OnClick="checkRadioBtn(this.id)" Checked='<%#Convert.ToBoolean(Eval("Checked")) %>' />
                                               </ItemTemplate>
                                           </asp:TemplateField>
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
                        <asp:SqlDataSource ID="SqlDataSourceAssociateResource" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [ResourceID], [Name], 
                            [Description], [Title], [ListOfSkills], [PayRate], [AvailableStartDate], [AvailableEndDate], CASE WHEN [AssociatedDecision] is NULL THEN 0 ELSE 1 END AS [Checked]
                            FROM [tblResources] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) AND ([AssociatedDecision] = @AssociatedDecision OR [AssociatedDecision] IS NULL))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                <asp:SessionParameter Name="AssociatedDecision" SessionField="_CurrentDecisionID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <asp:Button ID="ButtonModalAssociateResource" runat="server" Text="Associate Resource" CssClass="btn btn-default" OnClick="ButtonModalAssociateResource_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                </div>
            </div>

        </div>
    </div>

    <table style="width: 100%;">
        <tr style="vertical-align: top">
            <td colspan="1" class="auto-style16">Name<span class="auto-style1">*</span><span class="auto-style2">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="3" class="auto-style8"><span class="auto-style2">
                <asp:TextBox ID="TextBoxName" runat="server" Height="20px" Width="240px" TabIndex="1"></asp:TextBox>
            </span>&nbsp;<span class="auto-style2"><asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" Width="60px" />
            </span></td>
            <td colspan="1" class="auto-style14">&nbsp;</td>
            <td colspan="1" class="auto-style11">Impact:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxImpact" ClientIDMode="Static" runat="server" Height="20px" Width="150px" BackColor="#CCCCCC"></asp:TextBox>
            </td>
            <td colspan="1" rowspan="2">
                <asp:Button ID="ButtonAddImpact" runat="server" Text="Add Impact" data-toggle="modal" data-target="#myModal3" OnClientClick="return false;" Width="85px" TabIndex="12" />
                <br />
                <br />
                <asp:Button ID="ButtonRemoveImpact" runat="server" Text="Remove Impact" Width="110px" OnClick="ButtonRemoveImpact_Click" TabIndex="13" />
            </td>

            <td colspan="2" rowspan="2">
                <asp:ListBox ID="ListBoxImpact" ClientIDMode="Static" runat="server" Width="185px" onchange="ImpactTextBoxJS(this)" DataSourceID="ListBoxImpactDB" DataTextField="ImpactName" DataValueField="Sequence" Height="150px" TabIndex="11"></asp:ListBox>
                <asp:SqlDataSource ID="ListBoxImpactDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [ImpactName], [Sequence] FROM [tblImpactDec] WHERE ([AssociatedDecision] = @AssocDec) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="AssocDec" SessionField="_CurrentDecisionID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td colspan="5" rowspan="2" class="auto-style8">
                <br />
                <asp:ImageButton ID="ImageButtonImpactMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxImpact', 'up'); return false;" />

                <br />
                <br />
                <asp:ImageButton ID="ImageButtonImpactMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxImpact', 'down'); return false;" />

            </td>
        </tr>
        <tr>
            <td colspan="6"></td>
            <td colspan="1">
                <asp:HiddenField ID="HiddenFieldImpact" runat="server" />
            </td>
            <td colspan="1">&nbsp;</td>
            <td colspan="7">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>

        <tr style="vertical-align: top">
            <td colspan="1" class="auto-style17">Description<span class="auto-style1">*</span><span class="auto-style2">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="4"><span class="auto-style2">
                <asp:TextBox ID="TextBoxDescription" runat="server" MaxLength="1000" TextMode="MultiLine" Height="150px" Width="300px" TabIndex="3"></asp:TextBox>
            </span></td>
            <td colspan="1" class="text-right">Priority:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxPriority" ClientIDMode="Static" runat="server" Height="20px" Width="150px" BackColor="#CCCCCC"></asp:TextBox>
            </td>
            <td colspan="1" rowspan="1">
                <asp:Button ID="ButtonAddPriority" runat="server" Text="Add Priority" data-toggle="modal" data-target="#myModal4" OnClientClick="return false;" Width="85px" TabIndex="15" />
                <br />
                <br />
                <asp:Button ID="ButtonRemovePriority" runat="server" Text="Remove Priority" Width="120px" OnClick="ButtonRemovePriority_Click" TabIndex="16" /></td>
            <td colspan="2" rowspan="2">
                <asp:ListBox ID="ListBoxPriority" ClientIDMode="Static" runat="server" Height="150px" Width="185px" onchange="PriorityTextBoxJS(this)" DataSourceID="ListBoxPriorityDB" DataTextField="PriorityName" DataValueField="Sequence" TabIndex="14"></asp:ListBox>
                <asp:SqlDataSource ID="ListBoxPriorityDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [PriorityName], [Sequence] FROM [tblPriorityDec] WHERE ([AssociatedDecision] = @AssocDec) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="AssocDec" SessionField="_CurrentDecisionID" Type="Int32" />

                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td colspan="5" rowspan="2">
                <br />
                <asp:ImageButton ID="ImageButtonPriorityMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxPriority','up');return false;" />
                <br />
                <br />
                <asp:ImageButton ID="ImageButtonPriorityMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxPriority','down');return false;" />


            </td>

        </tr>
        <tr>
            <td colspan="5" class="auto-style8"></td>
            <td colspan="2" class="auto-style8"></td>
            <td colspan="1" class="auto-style8">
                <asp:HiddenField ID="HiddenFieldPriority" runat="server" />
            </td>
            <td colspan="7" class="auto-style8"></td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="1" class="auto-style12">Date Created<span class="auto-style1">*</span><span class="auto-style2">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="4" class="auto-style9"><span class="auto-style2">
                <asp:TextBox ID="TextBoxDateCreated" runat="server" Height="20px" Width="80px" BackColor="#CCCCCC"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarDateCreated" PopupButtonID="ImageButtonDateCreated" runat="server" TargetControlID="TextBoxDateCreated" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateCreated" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="4" />
            </span>
            </td>

            <td colspan="1" class="text-right">Status<span class="auto-style2">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxStatus" ClientIDMode="Static" runat="server" Height="20px" Width="150px" BackColor="#CCCCCC"></asp:TextBox>
            </td>
            <td colspan="1" rowspan="1">
                <asp:Button ID="ButtonAddStatus" runat="server" Text="Add Status" data-toggle="modal" data-target="#myModal2" OnClientClick="return false;" Width="85px" TabIndex="18" />
                <br />
                <br />
                <asp:Button ID="ButtonRemoveStatus" runat="server" Text="Remove Status" Width="110px" OnClick="ButtonRemoveStatus_Click" TabIndex="19" /></td>
            <td colspan="2" rowspan="2">

                <asp:ListBox ID="ListBoxStatus" ClientIDMode="Static" runat="server" Width="185px" Height="150px" onchange="StatusTextBoxJS(this)" DataSourceID="ListBoxStatusDB" DataTextField="StatusName" DataValueField="Sequence" TabIndex="17"></asp:ListBox>

                <asp:SqlDataSource ID="ListBoxStatusDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [StatusName], [Sequence] FROM [tblStatusDec] WHERE ([AssociatedDecision] = @AssocDec) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="AssocDec" SessionField="_CurrentDecisionID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </td>
            <td colspan="5" rowspan="2">
                <asp:ImageButton ID="ImageButtonStatusMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxStatus','up');return false;" />

                <br />
                <br />

                <asp:ImageButton ID="ImageButtonStatusMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxStatus','down');return false;" />


            </td>
        </tr>
        <tr>

            <td colspan="6"></td>
            <td colspan="1">
                <asp:HiddenField ID="HiddenFieldStatus" runat="server" />
            </td>
            <td colspan="1">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td colspan="5"></td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>


        <tr>
            <td colspan="1" class="auto-style18">Date Needed<span class="auto-style1">*</span><span class="auto-style2">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="4" class="auto-style10"><span class="auto-style2">
                <asp:TextBox ID="TextBoxDateNeeded" runat="server" Height="20px" Width="80px" BackColor="#CCCCCC"></asp:TextBox>

                <cc1:CalendarExtender ID="CalendarDateNeeded" PopupButtonID="ImageButtonDateNeeded" runat="server" TargetControlID="TextBoxDateNeeded" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateNeeded" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="5" />
            </span></td>
            <td colspan="1" style="vertical-align: top" class="text-right">Status Description:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="9">
                <asp:TextBox ID="TextBoxStatusDescription" runat="server" MaxLength="1000" TextMode="MultiLine" Height="150px" Width="300px" TabIndex="20" OnTextChanged="TextBoxStatusDescription_TextChanged"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style17">Expected Completion Date<span class="auto-style1">*</span><span class="auto-style2">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpCompletionDate" runat="server" Height="20px" Width="80px" BackColor="#CCCCCC"></asp:TextBox>
                <span class="auto-style2">

                    <cc1:CalendarExtender ID="CalendarExpComplDate" PopupButtonID="ImageButtonExpCompletionDate" runat="server" TargetControlID="TextBoxExpCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                    <asp:ImageButton ID="ImageButtonExpCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="6" />
                </span>
            </td>
            <td colspan="1"></td>
            <td colspan="1">Last Updated Status:

                <asp:TextBox ID="TextBoxLastUpdatedStatus" runat="server" Height="20px" Width="80px" BackColor="#CCCCCC" ReadOnly="True"></asp:TextBox></td>
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
            <td colspan="15">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style18">
                <asp:Label ID="LabelActualCompletionDate" runat="server" Text="Actual Completion Date:" Visible="False"></asp:Label>
            </td>
            <td colspan="4" class="auto-style10">
                <asp:TextBox ID="TextBoxActCompletionDate" runat="server" Visible="False" Height="20px" Width="80px" BackColor="#CCCCCC"></asp:TextBox>
                <span class="auto-style2">
                    <cc1:CalendarExtender ID="CalendarActComplDate" PopupButtonID="ImageButtonActCompletionDate" runat="server" TargetControlID="TextBoxActCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                    <asp:ImageButton ID="ImageButtonActCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" TabIndex="7" />
                </span>
            </td>
            <td colspan="1" class="auto-style13">Associated Meetinng Note(s):&nbsp;&nbsp;&nbsp; </td>

            <td colspan="9" class="auto-style10">
                <asp:Button ID="ButtonAssociateMeetingNOtes" runat="server" Text="Associate Meeting Notes" Width="175px" TabIndex="21" />
            </td>
        </tr>
        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="5"></td>
            <td colspan="1" class="text-right">&nbsp;</td>
            <td colspan="9">Last Updated Note:<asp:TextBox ID="TextBoxLastUpdatedNote" runat="server" BackColor="#CCCCCC" Height="20px" ReadOnly="True" Width="80px"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="15" class="auto-style8"></td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style17">
                <asp:Label ID="LabelDateMade" runat="server" Text="Date Made:" Visible="False"></asp:Label>
                &nbsp;&nbsp;&nbsp;
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDateMade" runat="server" Visible="False" Height="20px" Width="80px" BackColor="#CCCCCC"></asp:TextBox>
                <span class="auto-style2">
                    <cc1:CalendarExtender ID="Calendar1" PopupButtonID="ImageButtonDateMade" runat="server" TargetControlID="TextBoxDateMade" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                    <asp:ImageButton ID="ImageButtonDateMade" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" TabIndex="8" />
                </span>
            </td>
            <td colspan="1" class="text-right">Associated Reference Document(s):&nbsp;&nbsp;&nbsp; </td>
            <td colspan="9">
                <asp:Button ID="ButtonAssociateRefDocs" runat="server" Text="Associate Reference Documents" Width="215px" TabIndex="22" />
            </td>
        </tr>

        <tr>
            <td colspan="15">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style17">
                <asp:Label ID="LabelDecisionMaker" runat="server" Text="Decision Maker:" Visible="False"></asp:Label>
                &nbsp;&nbsp;&nbsp;
            </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDecisionMaker" runat="server" Visible="False" Width="150px" BackColor="#CCCCCC" Height="20px" ReadOnly="True"></asp:TextBox>
                <asp:Button ID="ButtonDecisionMaker" runat="server" Text="Select Resource" Width="115px" TabIndex="9" data-toggle="modal" data-target="#myModal6" OnClientClick="return false;" Visible="False" />
            </td>
            <td colspan="10">List of Created Decisions:</td>
        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="5">
                <div style="overflow: scroll; height: 250px; width: 800px" runat="server" id="GridViewDecisionScroll">
                    <asp:GridView ID="GridViewListofDecisions" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewDecisionsDB" ForeColor="#333333" GridLines="None" Height="50px" Width="1750px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                                <ItemStyle Width="300px" />
                            </asp:BoundField>

                            <asp:BoundField DataField="DateCreated" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date Created" SortExpression="DateCreated" />
                            <asp:BoundField DataField="DateNeeded" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date Needed" SortExpression="DateNeeded" />
                            <asp:BoundField DataField="DateMade" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date Made" SortExpression="DateMade" />
                            <asp:BoundField DataField="ExpectedCompletionDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Expected Completion Date" SortExpression="ExpectedCompletionDate" />
                            <asp:BoundField DataField="ActualCompletionDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Actual Completion Date" SortExpression="ActualCompletionDate" />
                            <asp:BoundField DataField="NoteDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Note Date" SortExpression="NoteDate" />
                            <asp:BoundField DataField="Imp" HeaderText="Impact" SortExpression="Impact" />
                            <asp:BoundField DataField="Pri" HeaderText="Priority" SortExpression="Priority" />

                            <asp:BoundField DataField="Stat" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="StatusDescription" HeaderText="Status Description" SortExpression="StatusDescription">
                                <ItemStyle Width="300px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="UpdateDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Update Date" SortExpression="UpdateDate" />
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
                <asp:SqlDataSource ID="GridViewDecisionsDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT DISTINCT D.[Name], D.[Description], D.[DateCreated], D.[DateNeeded], D.[DateMade], D.[ExpectedCompletionDate], 
                    D.[ActualCompletionDate], D.[NoteDate], D.[StatusDescription], D.[UpdateDate], P.[PriorityName] Pri, I.[ImpactName] Imp, S.[StatusName] Stat 
                    FROM [tblDecisions] D
                    LEFT JOIN [tblPriorityDec] P ON P.[Sequence] = D.[Priority] AND P.[AssociatedDecision] = D.[DecisionID]
                    LEFT JOIN [tblImpactDec] I ON I.[Sequence] = D.[Impact] AND I.[AssociatedDecision] = D.[DecisionID]
                    LEFT JOIN [tblStatusDec] S ON S.[Sequence] = D.[Status] AND S.[AssociatedDecision] = D.[DecisionID]
                    WHERE ((D.[UserID] = @UserID) AND (D.[ProjectID] = @ProjectID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>

            <td colspan="15">&nbsp;</td>

        </tr>

        <tr>
            <td colspan="1" class="auto-style19"></td>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" Text="New" OnClick="ButtonNew_Click" Style="height: 26px" Width="100px" TabIndex="10" />
            </td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1" class="auto-style15"></td>


            <td colspan="1">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" Visible="False" OnClick="ButtonDelete_Click" Width="75px" />
            </td>
            <td colspan="1">&nbsp;</td>
            <td colspan="1"></td>
            <td colspan="1">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" Visible="False" OnClientClick="return listboxSave();" OnClick="ButtonSave_Click" Width="125px" TabIndex="23" />
            </td>
            <td colspan="1">&nbsp;</td>

            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
        </tr>

    </table>


</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .hiddencol {
            display: none;
        }

        .auto-style1 {
            color: #FF0000;
        }

        .auto-style2 {
            color: #000000;
        }

        .auto-style8 {
            height: 20px;
        }

        .auto-style9 {
            height: 25px;
        }

        .auto-style10 {
            height: 26px;
        }

        .auto-style11 {
            height: 20px;
            text-align: right;
        }

        .auto-style12 {
            height: 25px;
            text-align: right;
            width: 200px;
        }

        .auto-style13 {
            height: 26px;
            text-align: right;
        }

        .auto-style14 {
            height: 20px;
            width: 10px;
        }

        .auto-style15 {
            width: 10px;
        }

        .auto-style16 {
            height: 20px;
            text-align: right;
            width: 200px;
        }

        .auto-style17 {
            text-align: right;
            width: 200px;
        }

        .auto-style18 {
            height: 26px;
            text-align: right;
            width: 200px;
        }

        .auto-style19 {
            width: 200px;
        }
    </style>

    <script type="text/javascript">
        function checkRadioBtn(id) {
            var radioBtn = document.getElementById(id);
            var grid = document.getElementById('<%= GridViewAssociateResource.ClientID %>')
            var List = grid.getElementsByTagName("input");

            for (i = 0; i < List.length; i++) {
                if (List[i].type == "radio" && List[i].id != radioBtn.id) {
                    List[i].checked = false;
                }
            }
        }

        function listboxSave() {
            getClientStatusListBox('<%= ListBoxStatus.ClientID %>');
            getClientPriorityListBox('<%= ListBoxPriority.ClientID %>');
            getClientImpactListBox('<%= ListBoxImpact.ClientID %>');

            return true;
        }

        function getClientStatusListBox(listID) {
            var hiddenBox = document.getElementById('<%= HiddenFieldStatus.ClientID %>');
            var listBoxVal = '';
            var listbox = document.getElementById(listID);
            for (var count = 0; count < listbox.options.length; count++) {
                if (listBoxVal.length > 0) {
                    listBoxVal += '|';
                }

                listBoxVal += listbox.options[count].text;

            }
            hiddenBox.value = listBoxVal;
        }

        function getClientPriorityListBox(listID) {
            var hiddenBox = document.getElementById('<%= HiddenFieldPriority.ClientID %>');
            var listBoxVal = '';
            var listbox = document.getElementById(listID);
            for (var count = 0; count < listbox.options.length; count++) {
                if (listBoxVal.length > 0) {
                    listBoxVal += '|';
                }

                listBoxVal += listbox.options[count].text;

            }
            hiddenBox.value = listBoxVal;
        }

        function getClientImpactListBox(listID) {
            var hiddenBox = document.getElementById('<%= HiddenFieldImpact.ClientID %>');
            var listBoxVal = '';
            var listbox = document.getElementById(listID);
            for (var count = 0; count < listbox.options.length; count++) {
                if (listBoxVal.length > 0) {
                    listBoxVal += '|';
                }

                listBoxVal += listbox.options[count].text;

            }
            hiddenBox.value = listBoxVal;
        }

        function StatusTextBoxJS(ddl) {
            var tbStatus = document.getElementById('<%= TextBoxStatus.ClientID %>');

            if (tbStatus != null) {
                tbStatus.value = ddl.options[ddl.selectedIndex].text;
            }
        }

        function PriorityTextBoxJS(ddl) {
            var tbPriority = document.getElementById('<%= TextBoxPriority.ClientID %>');

            if (tbPriority != null) {
                tbPriority.value = ddl.options[ddl.selectedIndex].text;
            }
        }

        function ImpactTextBoxJS(ddl) {
            var tbImpact = document.getElementById('<%= TextBoxImpact.ClientID %>');

            if (tbImpact != null) {
                tbImpact.value = ddl.options[ddl.selectedIndex].text;
            }
        }

        function listBoxMove(listBoxID, direction) {
            var listBox = document.getElementById(listBoxID);
            var selIndex = listBox.selectedIndex;

            if (-1 == selIndex) {
                alert("Please select an option to move.");
                return;
            }

            var increment = -1;
            if (direction == 'up')
                increment = -1;
            else
                increment = 1;

            if ((selIndex + increment) < 0 ||
                (selIndex + increment) > (listBox.options.length - 1)) {
                return;
            }

            var selValue = listBox.options[selIndex].value;
            var selText = listBox.options[selIndex].text;

            listBox.options[selIndex].value = listBox.options[selIndex + increment].value
            listBox.options[selIndex].text = listBox.options[selIndex + increment].text
            listBox.options[selIndex + increment].value = selValue;
            listBox.options[selIndex + increment].text = selText;
            listBox.selectedIndex = selIndex + increment;
        }
    </script>


</asp:Content>


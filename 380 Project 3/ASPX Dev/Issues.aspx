<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Issues.aspx.cs" Inherits="_380_Project_3.ASPX_Dev.Issues" %>

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
                        <h4 class="modal-title">Search for Issues</h4>
                    </div>

                    <div class="modal-body">
                        Issues List:
                        <asp:DropDownList ID="DropDownListIssuesSelect" runat="server" DataSourceID="DropDownListIssuesDB" DataTextField="Name" DataValueField="IssueID" Height="30px" Width="571px" AppendDataBoundItems="true">


                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownListIssuesDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [Name], [IssueID] FROM [tblIssues] WHERE ([UserID] = @UserID) AND ([ProjectID] = @ProjectID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalSearch" runat="server" Text="Open Issue" CssClass="btn btn-default" OnClick="ButtonModalSearch_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>

    </div>

    <div class="container2">
        <!-- Modal -->
        <div class="modal fade" id="myModal2" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Associate Action Items</h4>
                    </div>

                    <div class="modal-body">
                        Action Items List:
                                   <div style="overflow-y: scroll; height: 250px">
                                       <asp:GridView ID="GridViewAssociateActionItems" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewAssocActItem" ForeColor="#333333" GridLines="None" Width="472px" DataKeyNames="ActionItemID">
                                           <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                           <Columns>
                                               <asp:BoundField DataField="ActionItemID" HeaderText="ActionItemID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                               <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                               <asp:TemplateField>
                                                   <ItemTemplate>
                                                       <asp:CheckBox ID="CheckBoxAssociateActItems" runat="server" Checked='<%#Convert.ToBoolean(Eval("Checked")) %>' />
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
                        <asp:SqlDataSource ID="GridViewAssocActItem" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [ActionItemID], [Name],
                            CASE WHEN [AssociatedIssue] is NULL THEN 0 ELSE 1 END AS [Checked] FROM [tblActionItems] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) 
                            AND ([AssociatedIssue] = @AssocIssue OR [AssociatedIssue] IS NULL))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                <asp:SessionParameter Name="AssocIssue" SessionField="_CurrentIssueID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <asp:Button ID="ButtonModalAssocActItems" runat="server" Text="Associate Action Items" CssClass="btn btn-default" OnClick="ButtonModalAssocActItems_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="container3">
        <!-- Modal -->
        <div class="modal fade" id="myModal3" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Associate Decisions</h4>
                    </div>

                    <div class="modal-body">
                        Decisions List:
                                   <div style="overflow-y: scroll; height: 250px">
                                       <asp:GridView ID="GridViewAssociateDecisions" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewAssocDecisionsDS" ForeColor="#333333" GridLines="None" Width="472px" DataKeyNames="DecisionID">
                                           <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                           <Columns>
                                               <asp:BoundField DataField="DecisionID" HeaderText="DecisionID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                               <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                               <asp:TemplateField>
                                                   <ItemTemplate>
                                                       <asp:CheckBox ID="CheckBoxAssociateDecisions" runat="server" Checked='<%#Convert.ToBoolean(Eval("Checked")) %>' />
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
                        <asp:SqlDataSource ID="GridViewAssocDecisionsDS" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [DecisionID], [Name],
                            CASE WHEN [AssociatedIssue] is NULL THEN 0 ELSE 1 END AS [Checked] FROM [tblDecisions] WHERE (([UserID] = @UserID) AND ([ProjectID] = @ProjectID) 
                            AND ([AssociatedIssue] = @AssocIssue OR [AssociatedIssue] IS NULL))">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                <asp:SessionParameter Name="AssocIssue" SessionField="_CurrentIssueID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <asp:Button ID="ButtonModalAssocDecisions" runat="server" Text="Associate Decisions" CssClass="btn btn-default" OnClick="ButtonModalAssocDecisions_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                        </div>
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
        <div class="modal fade" id="myModal5" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Severity</h4>
                    </div>

                    <div class="modal-body">
                        Severity Name:
                    <br />
                        <asp:TextBox ID="TextBoxAddSeverity" autofocus="" runat="server"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="ButtonModalAddSeverity" runat="server" Text="Add New Severity" CssClass="btn btn-default" OnClick="ButtonModalAddSeverity_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="container">
        <!-- Modal -->
        <div class="modal fade" id="myModal6" role="dialog">
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


    <table style="width: 100%;">
        <tr style="vertical-align: top">
            <td colspan="1" class="auto-style16">Name<span class="auto-style1">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxName" runat="server" Height="20px" Width="240px" TabIndex="1"></asp:TextBox>


                <asp:Button ID="ButtonSearch" runat="server" data-toggle="modal" data-target="#myModal" Text="Search" OnClientClick="return false;" Width="60px" /></td>

            <td colspan="1" class="text-right">Severity:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxSeverity" runat="server" BackColor="#CCCCCC" Height="20px" Width="100px"></asp:TextBox>
                <asp:HiddenField ID="HiddenFieldSeverity" runat="server" />
            </td>

            <td colspan="1">
                <asp:Button ID="ButtonAddSeverity" runat="server" Text="Add Severity" data-toggle="modal" data-target="#myModal5" OnClientClick="return false;" Width="95px" TabIndex="10" />
                <br />
                <br />
                <asp:Button ID="ButtonRemoveSeverity" runat="server" Text="Remove Severity" OnClick="ButtonRemoveSeverity_Click" Width="120px" TabIndex="11" /></td>

            <td colspan="2" rowspan="2">
                <asp:ListBox ID="ListBoxSeverity" ClientIDMode="Static" runat="server" Height="150px" Width="185px" onchange="SeverityTextBoxJS(this)" DataSourceID="ListBoxSeverityDB" DataTextField="SeverityName" DataValueField="Sequence" TabIndex="9"></asp:ListBox>
                <asp:SqlDataSource ID="ListBoxSeverityDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [SeverityName], [Sequence] FROM [tblSeverityIssues] WHERE ([AssociatedIssue] = @AssocIssue)  ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="AssocIssue" SessionField="_CurrentIssueID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>

            <td colspan="1">
                <br />
                <asp:ImageButton ID="ImageSeverityMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxSeverity', 'up'); return false;" />
                <br />
                <br />
                <asp:ImageButton ID="ImageButtonSeverityMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxSeverity', 'down'); return false;" />

            </td>
        </tr>


        <tr>
            <td colspan="11">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="11" class="auto-style2"></td>
        </tr>

        <tr style="vertical-align: top">
            <td colspan="1" style="vertical-align: text-top" class="auto-style16">Description<span class="auto-style1">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDescription" runat="server" TextMode="MultiLine" Height="150px" Width="300px" TabIndex="3"></asp:TextBox></td>
            <td colspan="1" class="auto-style15">Priority<span class="auto-style3">:&nbsp;&nbsp;&nbsp; </span></td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxPriority" runat="server" BackColor="#CCCCCC" Height="20px" Width="100px"></asp:TextBox>
                <asp:HiddenField ID="HiddenFieldPriority" runat="server" />
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonAddPriority" runat="server" Text="Add Priority" data-toggle="modal" data-target="#myModal6" OnClientClick="return false;" Width="85px" TabIndex="13" />
                <br />
                <br />
                <asp:Button ID="ButtonRemovePriority" runat="server" Text="Remove Priority" OnClick="ButtonRemovePriority_Click" Width="120px" TabIndex="14" />
            </td>
            <td colspan="2" rowspan="2">
                <asp:ListBox ID="ListBoxPriority" ClientIDMode="Static" runat="server" Height="150px" Width="185px" onchange="PriorityTextBoxJS(this)" DataSourceID="ListBoxPriorityDB" DataTextField="PriorityName" DataValueField="Sequence" TabIndex="12"></asp:ListBox>


                <asp:SqlDataSource ID="ListBoxPriorityDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [PriorityName], [Sequence] FROM [tblPriorityIssues] WHERE ([AssociatedIssue] = @AssocIssue) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="AssocIssue" SessionField="_CurrentIssueID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>


            </td>

            <td colspan="1">
                <br />
                <asp:ImageButton ID="ImageButtonPriorityMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxPriority', 'up'); return false;" />
                <br />
                <br />
                <asp:ImageButton ID="ImageButtonPriorityMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxPriority', 'down'); return false;" />
            </td>
        </tr>

        <tr>
            <td colspan="11">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="11" class="auto-style2">&nbsp;</td>
        </tr>

        <tr style="vertical-align: top">

            <td colspan="1" class="auto-style16">Expected Completion Date<span class="auto-style1">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxExpectedCompletionDate" runat="server" Height="20px" Width="80px" BackColor="#CCCCCC"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExpComplDate" PopupButtonID="ImageButtonExpCompletionDate" runat="server" TargetControlID="TextBoxExpectedCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonExpCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="4" /></td>
            <td colspan="1" class="text-right">Status:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="1">
                <asp:TextBox ID="TextBoxStatus" runat="server" BackColor="#CCCCCC" Height="20px" Width="100px"></asp:TextBox>
                <asp:HiddenField ID="HiddenFieldStatus" runat="server" />
            </td>
            <td colspan="1">
                <asp:Button ID="ButtonAddStatus" runat="server" Text="Add Status" data-toggle="modal" data-target="#myModal4" OnClientClick="return false;" Width="85px" TabIndex="16" />
                <br />
                <br />
                <asp:Button ID="ButtonRemoveStatus" runat="server" Text="Remove Status" OnClick="ButtonRemoveStatus_Click" Width="110px" TabIndex="17" />

            </td>

            <td colspan="2" rowspan="2">
                <asp:ListBox ID="ListBoxStatus" ClientIDMode="Static" runat="server" Width="185px" Height="150px" onchange="StatusTextBoxJS(this)" DataSourceID="ListBoxStatusDB" DataTextField="StatusName" DataValueField="Sequence" TabIndex="15"></asp:ListBox>
                <asp:SqlDataSource ID="ListBoxStatusDB" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT [StatusName], [Sequence] FROM [tblStatusIssues] WHERE ([AssociatedIssue] = @AssocIssue) ORDER BY [Sequence] ASC">
                    <SelectParameters>
                        <asp:SessionParameter Name="AssocIssue" SessionField="_CurrentIssueID" Type="Int32" />

                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td colspan="1">
                <br />
                <asp:ImageButton ID="ImageButtonStatusMoveUp" runat="server" Height="30px" ImageUrl="~/Images/up.png" OnClientClick="listBoxMove('ListBoxStatus', 'up'); return false;" />

                <br />
                <br />
                <asp:ImageButton ID="ImageButtonStatusMoveDown" runat="server" Height="30px" ImageUrl="~/Images/down.png" OnClientClick="listBoxMove('ListBoxStatus', 'down'); return false;" />

            </td>
        </tr>


        <tr>
            <td colspan="11">&nbsp;</td>
        </tr>

        <tr style="vertical-align: top">
            <td colspan="1" class="auto-style16">Date Raised<span class="auto-style1">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4">
                <asp:TextBox ID="TextBoxDateRaised" runat="server" Height="20px" Width="80px" BackColor="#CCCCCC"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarDateRaised" PopupButtonID="ImageButtonDateRaised" runat="server" TargetControlID="TextBoxDateRaised" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateRaised" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="5" /></td>
            <td colspan="1" class="text-right" style="vertical-align: text-top">Status Description:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="5"><span class="auto-style3">
                <asp:TextBox ID="TextBoxStatusDescription" runat="server" TextMode="MultiLine" Height="150px" Width="300px" TabIndex="18" OnTextChanged="TextBoxStatusDescription_TextChanged"></asp:TextBox>
            </span>
            </td>

        </tr>
        <tr>
            <td colspan="5" class="auto-style1"></td>
            <td colspan="1">&nbsp;</td>
            <td colspan="5">Last Updated:<asp:TextBox ID="TextBoxLastUpdated" runat="server" Height="20px" Width="80px" OnTextChanged="TextBoxLastUpdated_TextChanged" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="11" class="auto-style2">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style18">Date Assigned<span class="auto-style1">*</span>:&nbsp;&nbsp;&nbsp; </td>
            <td colspan="4" class="auto-style19">
                <asp:TextBox ID="TextBoxDateAssigned" runat="server" Height="20px" Width="80px" BackColor="#CCCCCC"></asp:TextBox>

                <cc1:CalendarExtender ID="CalendarDateAssigned" PopupButtonID="ImageButtonDateAssigned" runat="server" TargetControlID="TextBoxDateAssigned" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonDateAssigned" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" TabIndex="6" /></td>
            <td colspan="5" class="auto-style20" style="vertical-align: top">Associated Action Item(s):&nbsp;&nbsp;&nbsp; <asp:Button ID="ButtonAssociateActionItems" runat="server" Text="Associate Action Items" data-toggle="modal" data-target="#myModal2" OnClientClick="return false;" Width="160px" TabIndex="19" />
            </td>


        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="6">
                <div id="GridViewActionItemScroll" runat="server" style="overflow: scroll; height: 250px; width: 800px" visible="false">
                    <asp:GridView ID="GridViewAssociatedActItem" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="AssociatedActionItems" ForeColor="#333333" GridLines="None" Height="50px" Width="1400px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                            <ItemStyle Width="300px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DateCreated" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date Created" SortExpression="DateCreated" />
                            <asp:BoundField DataField="DateAssigned" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date Assigned" SortExpression="DateAssigned" />
                            <asp:BoundField DataField="ExpectedCompletionDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="ExpectedCompletion Date" SortExpression="ExpectedCompletionDate" />
                            <asp:BoundField DataField="ActualCompletionDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Actual Completion Date" SortExpression="ActualCompletionDate" />
                            <asp:BoundField DataField="Stat" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="StatusDescription" HeaderText="Status Description" SortExpression="StatusDescription" >
                            <HeaderStyle Width="300px" />
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
                <asp:SqlDataSource ID="AssociatedActionItems" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT A.[Name], A.[Description], A.[DateCreated], A.[DateAssigned], A.[ExpectedCompletionDate],
                    A.[ActualCompletionDate], A.[StatusDescription], A.[UpdateDate], S.[StatusName] Stat 
                    FROM [tblActionItems] A
                    LEFT JOIN [tblStatusActItem] S ON S.[Sequence] = A.[Status] AND S.AssociatedActionItem = A.[ActionItemID]
                    WHERE ((A.[UserID] = @UserID) AND (A.[ProjectID] = @ProjectID) AND (A.[AssociatedIssue] = @AssocIssueID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                        <asp:SessionParameter Name="AssocIssueID" SessionField="_CurrentIssueID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="5"></td>
            <td colspan="6"></td>

        </tr>

        <tr>
            <td colspan="11">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style18">
                <asp:Label ID="LabelActualCompletionDate" runat="server" Text="Actual Completion Date: " Visible="False"></asp:Label></td>
            <td colspan="4" class="auto-style19">
                <asp:TextBox ID="TextBoxActualCompletionDate" runat="server" Visible="False" Height="20px" Width="80px" BackColor="#CCCCCC"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarActComplDate" PopupButtonID="ImageButtonActCompletionDate" runat="server" TargetControlID="TextBoxActualCompletionDate" Format="MM/dd/yyyy"></cc1:CalendarExtender>
                <asp:ImageButton ID="ImageButtonActCompletionDate" runat="server" Height="25px" ImageUrl="~/Images/calendar.png" Visible="False" TabIndex="7" /></td>

            <td colspan="1" class="auto-style20" style="vertical-align: top">Associated Decision(s):&nbsp;&nbsp;&nbsp; <asp:Button ID="ButtonAssociateDecisions" runat="server" Text="Associate Decisions" data-toggle="modal" data-target="#myModal3" OnClientClick="return false;" Width="150px" TabIndex="20" />
            </td>
            <td colspan="4" class="auto-style19"></td>
        </tr>

        <tr>
            <td colspan="5"></td>
            <td colspan="6">
                <div id="GridViewDecisionScroll" runat="server" style="overflow: scroll; height: 250px; width: 800px" visible="false">
                    <asp:GridView ID="GridViewAssociatedDecisions" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="AssociatedDecisions" ForeColor="#333333" GridLines="None" Height="50px" Width="1750px">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                            <ItemStyle Width="300px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Pri" HeaderText="Priority" SortExpression="Priority" />
                            <asp:BoundField DataField="Imp" HeaderText="Impact" SortExpression="Impact" />
                            <asp:BoundField DataField="DateCreated" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date Created" SortExpression="DateCreated" />
                            <asp:BoundField DataField="DateNeeded" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date Needed" SortExpression="DateNeeded" />
                            <asp:BoundField DataField="DateMade" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date Made" SortExpression="DateMade" />
                            <asp:BoundField DataField="ExpectedCompletionDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Expected Completion Date" SortExpression="ExpectedCompletionDate" />
                            <asp:BoundField DataField="ActualCompletionDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Actual Completion Date" SortExpression="ActualCompletionDate" />
                            <asp:BoundField DataField="NoteDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="NoteDate" SortExpression="NoteDate" />
                            <asp:BoundField DataField="Stat" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="StatusDescription" HeaderText="Status Description" SortExpression="StatusDescription" >
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
                    <asp:SqlDataSource ID="AssociatedDecisions" runat="server" ConnectionString="<%$ ConnectionStrings:DevDB %>" SelectCommand="SELECT D.[Name], D.[Description], D.[DateCreated], D.[DateNeeded], D.[DateMade], D.[ExpectedCompletionDate], 
                    D.[ActualCompletionDate], D.[NoteDate], D.[StatusDescription], D.[UpdateDate], P.[PriorityName] Pri, I.[ImpactName] Imp, S.[StatusName] Stat 
                    FROM [tblDecisions] D
                    LEFT JOIN [tblPriorityDec] P ON P.[Sequence] = D.[Priority] AND P.[AssociatedDecision] = D.[DecisionID]
                    LEFT JOIN [tblImpactDec] I ON I.[Sequence] = D.[Impact] AND I.[AssociatedDecision] = D.[DecisionID]
                    LEFT JOIN [tblStatusDec] S ON S.[Sequence] = D.[Status] AND S.[AssociatedDecision] = D.[DecisionID]
                        WHERE ((D.[UserID] = @UserID) AND (D.[ProjectID] = @ProjectID) AND (D.[AssociatedIssue] = @AssociatedIssue))">
                        <SelectParameters>
                            <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                            <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                            <asp:SessionParameter Name="AssociatedIssue" SessionField="_CurrentIssueID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </td>
        </tr>

        <tr>
            <td colspan="11">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="1" class="auto-style17"></td>
            <td colspan="1">
                <asp:Button ID="ButtonNew" runat="server" Text="New" OnClick="ButtonNew_Click" Width="100px" TabIndex="8" /></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1"></td>
            <td colspan="1">
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" OnClick="ButtonDelete_Click" Width="75px" Height="26px" />
            </td>
            <td colspan="1" class="text-left">&nbsp;</td>
            <td colspan="1">&nbsp;</td>
            <td colspan="1" class="text-left">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" OnClientClick="return listboxSave();" OnClick="ButtonSave_Click" Width="125px" TabIndex="21" />
            </td>
            <td colspan="1">&nbsp;</td>
            <td colspan="1">&nbsp;</td>
        </tr>
    </table>

    <script type="text/javascript">
        function listboxSave() {
            getClientStatusListBox('<%= ListBoxStatus.ClientID %>');
            getClientPriorityListBox('<%= ListBoxPriority.ClientID %>');
            getClientSeverityListBox('<%= ListBoxSeverity.ClientID %>');

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

        function getClientSeverityListBox(listID) {
            var hiddenBox = document.getElementById('<%= HiddenFieldSeverity.ClientID %>');
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

        function SeverityTextBoxJS(ddl) {
            var tbSeverity = document.getElementById('<%= TextBoxSeverity.ClientID %>');

            if (tbSeverity != null) {
                tbSeverity.value = ddl.options[ddl.selectedIndex].text;
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

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        .hiddencol {
            display: none;
        }

        .auto-style1 {
            color: #FF0000;
        }

        .auto-style2 {
            height: 20px;
        }

        .auto-style3 {
            color: #000000;
        }

        .auto-style15 {
            height: 26px;
            text-align: right;
        }

        .auto-style16 {
            text-align: right;
            width: 200px;
        }

        .auto-style17 {
            width: 200px;
        }

        .auto-style18 {
            text-align: right;
            width: 200px;
            height: 40px;
        }

        .auto-style19 {
            height: 40px;
        }

        .auto-style20 {
            text-align: left;
            height: 40px;
        }
    </style>
</asp:Content>


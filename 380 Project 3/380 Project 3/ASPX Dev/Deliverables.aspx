<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="siteMaster.Master" CodeBehind="Deliverables.aspx.cs" Inherits="_380_Project_3.Deliverables" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <table class="auto-style2">
            <tr>
                <td class="auto-style3">Name<span class="auto-style5">*</span><span class="auto-style6">:</span></td>
                <td class="auto-style8">
                    <asp:TextBox ID="TextBox1" runat="server" Width="315px"></asp:TextBox>
                    <asp:Button ID="ButtonSearch" runat="server" Text="Search" OnClick="Button_Search_Click" />
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
                                <asp:Button ID="ButtonReqs" runat="server" Text="Associate Requirements" />
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
                    <textarea id="TextArea1" class="auto-style2" name="TextArea1" maxlength="1000"></textarea></td>
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
                    <asp:Calendar ID="CalendarStart" runat="server"></asp:Calendar>
                </td>
                <td class="auto-style14">
                    <br />
                    <table style="width:100%;">
                        <tr>
                            <td>Associated Task(s):</td>
                            <td>&nbsp;</td>
                            <td class="auto-style15">
                                <asp:Button ID="ButtonTask" runat="server" Text="Associate Tasks" />
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
                <td class="auto-style7">Due Date:</td>
                <td class="auto-style9">
                    <asp:Calendar ID="CalendarDue" runat="server"></asp:Calendar>
                </td>
                <td>
                    <table style="width:100%;">
                        <tr>
                            <td>List of Deliverable(s):</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridDeliverables" ForeColor="#333333" GridLines="None" AllowSorting="True" Width="830px">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <Columns>
                                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                        <asp:BoundField DataField="StartDate" HeaderText="StartDate" SortExpression="StartDate" />
                                        <asp:BoundField DataField="DueDate" HeaderText="DueDate" SortExpression="DueDate" />
                                        <asp:BoundField DataField="Requirements" HeaderText="Requirements" SortExpression="Requirements" />
                                        <asp:BoundField DataField="Tasks" HeaderText="Tasks" SortExpression="Tasks" />
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
                                <asp:SqlDataSource ID="GridDeliverables" runat="server" ConnectionString="<%$ ConnectionStrings:Project DBConnectionString %>" SelectCommand="SELECT [Name], [Description], [StartDate], [DueDate], [Requirements], [Tasks] FROM [tblDeliverables] WHERE (([ProjectID] = @ProjectID) AND ([UserID] = @UserID))">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="ProjectID" SessionField="_CurrentProjID" Type="Int32" />
                                        <asp:SessionParameter Name="UserID" SessionField="_CurrentUserID" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
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
                                <asp:Button ID="ButtonNew" runat="server" Text="New" Width="101px" OnClick="Button_New_Click" />
                            </td>
                            <td class="auto-style15">
                                <asp:Button ID="ButtonDel" runat="server" Text="Delete" Width="96px" OnClick="Button_Del_Click" />
                            </td>
                            <td class="auto-style15">
                                <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="131px" OnClick="Button_Save_Click" />
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

    </asp:Content>

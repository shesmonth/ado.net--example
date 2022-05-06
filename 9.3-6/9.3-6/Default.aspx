<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="_9._3_6.show" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" PageSize="5" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDeleting="GridView1_RowDeleting" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="编号" />
                    <asp:BoundField DataField="name" HeaderText="姓名" />
                    <asp:BoundField DataField="phone" HeaderText="电话" />
                    <asp:BoundField DataField="email" HeaderText="邮箱" />
                    <asp:BoundField DataField="groupname" HeaderText="所在分组" />
                    <asp:HyperLinkField DataNavigateUrlFields="id" DataNavigateUrlFormatString="ContactEdit.aspx?id={0}" HeaderText="编辑" Text="编辑" />
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:ButtonField DataTextField="name" CommandName="del" DataTextFormatString="删除'{0}'的信息" HeaderText="自定义删除" Text="按钮" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:Button ID="Button1" runat="server" Text="录入" OnClick="Button1_Click" />&nbsp;&nbsp;&nbsp; <asp:Button ID="btnBatchDel" runat="server" Text="删除选中的记录" OnClick="btnBatchDel_Click" />
            <br />
            <br />
        </div>
    </form>
</body>
</html>

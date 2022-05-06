<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="show.aspx.cs" Inherits="_9._3_5__调用存储过程实现联系人分组录入.show" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 143px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">分组名称：</td>
                    <td>
                        <asp:TextBox ID="txtGroupName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">备注：</td>
                    <td>
                        <asp:TextBox ID="txtGroupMemo" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="录入" />
                    </td>
                    <td>
                        <asp:Button ID="Button2" runat="server" Text="取消" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>

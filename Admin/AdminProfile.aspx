<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminProfile.aspx.cs" Inherits="AdminProfile" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <title></title>    
</head>
<body>
    <form id="form1" runat="server">   
        <div style="padding: 20px; font-family: Arial;">
        <h2>الملف الشخصي للمدير</h2>
        <hr />
        
        <p>
            <label>الاسم:</label><br />
            <asp:TextBox ID="txtName" runat="server" Width="250px"></asp:TextBox>
        </p>
        
        <p>
            <label>البريد الإلكتروني:</label><br />
            <asp:TextBox ID="txtEmail" runat="server" Width="250px"></asp:TextBox>
        </p>
        
        <p>
            <label>كلمة المرور:</label><br />
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="250px"></asp:TextBox>
        </p>
        
        <p>
            <asp:Button ID="btnUpdate" runat="server" Text="تحديث البيانات" OnClick="btnUpdate_Click" />
        </p>
        
        <p>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
        </p>
    </div>
    </form>
</body>
</html>

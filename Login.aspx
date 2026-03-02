<%@ Page Title="Login"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Login.aspx.cs"
    Inherits="shatha11822App3.ClinicManagementSystem.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    body {
        background: #f4f7fb;
    }

    .login-container {
        min-height: 80vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .login-card {
        background: #ffffff;
        width: 420px;
        padding: 40px;
        border-radius: 16px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        text-align: center;
    }

    .login-title {
        font-size: 26px;
        font-weight: 700;
        color: #0d6efd;
        margin-bottom: 30px;
    }

    .form-center {
        max-width: 100%;
    }

    .form-control {
        width: 100%;
        padding: 12px;
        margin-bottom: 15px;
        border-radius: 8px;
        border: 1px solid #ccc;
    }

    .btn-login {
        width: 100%;
        padding: 12px;
        border-radius: 10px;
        background: #0d6efd;
        color: white;
        font-size: 16px;
        font-weight: 600;
        border: none;
        cursor: pointer;
    }

    .btn-login:hover {
        background: #0b5ed7;
    }

    .login-link {
        margin-top: 15px;
        font-size: 14px;
    }

    .validator {
        color: #dc3545;
        font-size: 13px;
        display: block;
        margin-bottom: 8px;
    }
</style>

<div class="login-container">

    <div class="login-card">

        <h2 class="login-title">Login</h2>

        <asp:ValidationSummary runat="server"
            CssClass="validator" />

        <div class="form-center">

            <asp:TextBox ID="txtEmail"
                runat="server"
                CssClass="form-control"
                Placeholder="Enter your email" />

            <asp:RequiredFieldValidator
                runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Email is required"
                CssClass="validator" />

            <asp:TextBox ID="txtPassword"
                runat="server"
                TextMode="Password"
                CssClass="form-control"
                Placeholder="Enter your password" />

            <asp:RequiredFieldValidator
                runat="server"
                ControlToValidate="txtPassword"
                ErrorMessage="Password is required"
                CssClass="validator" />

            <asp:Button ID="btnLogin"
                runat="server"
                Text="Login"
                CssClass="btn-login"
                OnClick="btnLogin_Click" />

        </div>

        <div class="login-link">
            Don’t have an account?
           <a href="Patient/Signup1.aspx">
                Sign up as a patient
            </a>
        </div>

    </div>

</div>

</asp:Content>
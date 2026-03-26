<%@ Page Title="Login"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Login.aspx.cs"
    Inherits="shatha11822App3.ClinicManagementSystem.Patient.Login" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            height: 100vh;
        }

        .login-card {
            background: white;
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .login-header {
            background-color: #0056b3; 
            color: white;
            padding: 30px;
            text-align: center;
        }

        .btn-kfmc {
            background-color: #0056b3;
            border: none;
            padding: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s;
        }

            .btn-kfmc:hover {
                background-color: #004494;
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            }

        .form-control {
            border-radius: 8px;
            padding: 12px;
            border: 1px solid #dee2e6;
        }

            .form-control:focus {
                border-color: #0056b3;
                box-shadow: 0 0 0 0.2rem rgba(0,86,179,0.1);
            }

        .input-icon {
            position: relative;
        }

            .input-icon i {
                position: absolute;
                left: 15px;
                top: 15px;
                color: #adb5bd;
            }

            .input-icon input {
                padding-left: 40px;
            }
    </style>

    <div class="d-flex justify-content-center align-items-center" style="min-height: 80vh;">
        <div class="card p-4 shadow-lg border-0" style="width: 400px; border-radius: 15px;">

            <h2 class="text-center text-primary fw-bold mb-3">KFMC Login</h2>

            <div class="text-center">
                <asp:Label ID="lblError" runat="server" CssClass="text-danger fw-bold mb-3 d-block" />
            </div>

            <asp:ValidationSummary runat="server" CssClass="text-danger mb-2" DisplayMode="List" />

            <div class="mb-3">
                <label class="form-label text-muted small">Email Address</label>
                <asp:TextBox ID="txtEmail"
                    runat="server"
                    CssClass="form-control" />
                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Email is required"
                    CssClass="text-danger small"
                    Display="Dynamic" />
            </div>

            <div class="mb-3">
                <label class="form-label text-muted small">Password</label>
                <asp:TextBox ID="txtPassword"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Password" />
                <asp:RequiredFieldValidator
                    runat="server"
                    ControlToValidate="txtPassword"
                    ErrorMessage="Password is required"
                    CssClass="text-danger small"
                    Display="Dynamic" />
            </div>

            <asp:Button ID="btnLogin"
                runat="server"
                CssClass="btn btn-primary w-100 py-2 shadow-sm"
                Text="Sign In"
                OnClick="btnLogin_Click" />

            <div class="text-center mt-4 border-top pt-3">
                <span class="text-muted small">New to the clinic?</span><br />
                <a runat="server"
                    href="~/ClinicManagementSystem/Patient/Signup1.aspx"
                    class="btn btn-link text-success text-decoration-none fw-bold mt-1">Create Patient Account
                </a>
            </div>

        </div>
    </div>

</asp:Content>

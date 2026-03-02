<%@ Page Title="Sign Up as Patient"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Signup1.aspx.cs"
    Inherits="shatha11822App3.ClinicManagementSystem.Patient.Signup1" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

    <style>
        body {
            background: #f4f6f9;
        }

        .signup-card {
            max-width: 900px;
            margin: 60px auto;
            background: #fff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0,0,0,.1);
        }

        .signup-title {
            text-align: center;
            color: #0d6efd;
            font-weight: 700;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 600;
            margin-bottom: 6px;
            display: block;
        }

        .form-control {
            border-radius: 8px;
            padding: 10px;
        }

        .validator {
            color: #dc3545;
            font-size: 13px;
            display: block;
            margin-top: 4px;
        }

        .btn-register {
            background: #28a745;
            color: #fff;
            font-size: 18px;
            font-weight: 600;
            padding: 14px;
            width: 100%;
            border: none;
            border-radius: 12px;
            margin-top: 25px;
        }

        .login-link {
            text-align: center;
            margin-top: 18px;
        }
    </style>

    <div class="signup-card">

        <h3 class="signup-title">Sign Up as Patient</h3>

        <asp:ValidationSummary runat="server" CssClass="validator" />

        <!-- Row 1 -->
        <div class="row">
            <div class="col-md-6">
                <label class="form-label">First Name *</label>
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server"
                    ControlToValidate="txtFirstName"
                    ErrorMessage="First name required"
                    CssClass="validator" />
            </div>

            <div class="col-md-6">
                <label class="form-label">Last Name *</label>
                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server"
                    ControlToValidate="txtLastName"
                    ErrorMessage="Last name required"
                    CssClass="validator" />
            </div>
        </div>

        <!-- Row 2 -->
        <div class="row mt-3">
            <div class="col-md-6">
                <label class="form-label">Email *</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Email required"
                    CssClass="validator" />
                <asp:RegularExpressionValidator runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Invalid email format"
                    CssClass="validator" />
            </div>

            <div class="col-md-6">
                <label class="form-label">Phone (optional)</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
            </div>
        </div>

        <!-- Row 3 -->
        <div class="row mt-3">
            <div class="col-md-6">
                <label class="form-label">Gender *</label>
                <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Female" Value="Female" />
                    <asp:ListItem Text="Male" Value="Male" />
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator runat="server"
                    ControlToValidate="rblGender"
                    InitialValue=""
                    ErrorMessage="Gender required"
                    CssClass="validator" />
            </div>

            <div class="col-md-6">
                <label class="form-label">Date of Birth (optional)</label>
                <asp:TextBox ID="txtDOB" runat="server"
                    TextMode="Date"
                    CssClass="form-control" />
            </div>
        </div>

        <!-- Row 4 -->
        <div class="row mt-3">
            <div class="col-md-6">
                <label class="form-label">Password *</label>
                <asp:TextBox ID="txtPassword" runat="server"
                    TextMode="Password"
                    CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server"
                    ControlToValidate="txtPassword"
                    ErrorMessage="Password required"
                    CssClass="validator" />
                <asp:RegularExpressionValidator runat="server"
                    ControlToValidate="txtPassword"
                    ValidationExpression="^(?=.*[A-Za-z])(?=.*\d).{10,}$"
                    ErrorMessage="Min 10 chars, letters & numbers"
                    CssClass="validator" />
            </div>

            <div class="col-md-6">
                <label class="form-label">Confirm Password *</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server"
                    TextMode="Password"
                    CssClass="form-control" />
                <asp:CompareValidator runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtPassword"
                    ErrorMessage="Passwords do not match"
                    CssClass="validator" />
            </div>
        </div>

        <asp:Button ID="btnRegister" runat="server"
            Text="Register"
            CssClass="btn-register"
            OnClick="btnRegister_Click" />

        <div class="login-link">
            Already have an account?
        <a href="../Login.aspx">Login</a>
        </div>

    </div>

</asp:Content>

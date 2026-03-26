<%@ Page Title="Sign Up as Patient" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Signup1.aspx.cs" Inherits="shatha11822App3.ClinicManagementSystem.Patient.Signup1" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            background: #f4f6f9;
        }

        .signup-card {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,.05);
        }

        .signup-title {
            text-align: center;
            color: #0d6efd;
            font-weight: 700;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 600;
            margin-bottom: 5px;
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
            padding: 12px;
            width: 100%;
            border: none;
            border-radius: 8px;
            margin-top: 20px;
            transition: 0.3s;
        }

            .btn-register:hover {
                background: #218838;
            }
    </style>

    <div class="signup-card">
        <h3 class="signup-title">Create Patient Account</h3>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">First Name *</label>
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" ErrorMessage="Required" CssClass="validator" Display="Dynamic" />
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Last Name *</label>
                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" ErrorMessage="Required" CssClass="validator" Display="Dynamic" />
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Email Address *</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="name@example.com" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Required" CssClass="validator" Display="Dynamic" />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Invalid email format" CssClass="validator" Display="Dynamic" />
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Phone (Optional)</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="05xxxxxxxx" MaxLength="10" />
                <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone"
                    ValidationExpression="^05\d{8}$" ErrorMessage="Must start with 05 and be 10 digits"
                    CssClass="validator" Display="Dynamic" />
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Gender *</label>
                <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" CssClass="mt-2">
                    <asp:ListItem Text="&nbsp;Female &nbsp;&nbsp;" Value="Female" />
                    <asp:ListItem Text="&nbsp;Male" Value="Male" />
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="rblGender" ErrorMessage="Select gender" CssClass="validator" Display="Dynamic" />
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Date of Birth</label>
                <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="form-control" />
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Password *</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" IsRequired="true" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" ErrorMessage="Required" CssClass="validator" Display="Dynamic" />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPassword"
                    ValidationExpression="^(?=.*[A-Za-z])(?=.*\d).{10,}$"
                    ErrorMessage="Min 10 chars, letters & numbers" CssClass="validator" Display="Dynamic" />
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Confirm Password *</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" />
                <asp:CompareValidator runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword"
                    ErrorMessage="Passwords do not match" CssClass="validator" Display="Dynamic" />
            </div>
        </div>

        <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn-register" OnClick="btnRegister_Click" />

        <div class="text-center mt-3">
            Already have an account? <a href="../Login.aspx" class="text-decoration-none">Login here</a>
        </div>
    </div>
</asp:Content>

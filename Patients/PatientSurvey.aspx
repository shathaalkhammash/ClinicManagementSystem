<%@ Page Title="Patient Survey"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="PatientSurvey.aspx.cs"
    Inherits="shatha11822App3.ClinicManagementSystem.Patient.PatientSurvey" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="card shadow p-4 mx-auto" style="max-width: 700px; border-radius: 15px;">
            <h2 class="text-center text-primary mb-4">Patient Satisfaction Survey</h2>
            <p class="text-muted text-center">Your feedback helps us improve our services.</p>
            <hr />

            <div class="mb-3">
                <label class="form-label fw-bold">Which department did you visit?</label>
                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select">
                    <asp:ListItem Text="-- Select Department --" Value="" />
                    <asp:ListItem Text="General Practice" Value="General" />
                    <asp:ListItem Text="Cardiology" Value="Cardiology" />
                    <asp:ListItem Text="Pediatrics" Value="Pediatrics" />
                    <asp:ListItem Text="Dental" Value="Dental" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ControlToValidate="ddlDepartment" InitialValue="" ErrorMessage="Please select a department" runat="server" CssClass="text-danger d-block" />
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">How would you rate your overall experience?</label>
                <asp:RadioButtonList ID="rblRating" runat="server" RepeatDirection="Horizontal" CssClass="w-100 mt-2">
                    <asp:ListItem Text="&nbsp;1 (Poor) &nbsp;" Value="1" />
                    <asp:ListItem Text="&nbsp;2 &nbsp;" Value="2" />
                    <asp:ListItem Text="&nbsp;3 (Average) &nbsp;" Value="3" />
                    <asp:ListItem Text="&nbsp;4 &nbsp;" Value="4" />
                    <asp:ListItem Text="&nbsp;5 (Excellent)" Value="5" />
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ControlToValidate="rblRating" ErrorMessage="Please provide a rating" runat="server" CssClass="text-danger" />
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Would you recommend us to others?</label>
                <asp:RadioButtonList ID="rblRecommend" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="&nbsp;Yes &nbsp;" Value="Yes" />
                    <asp:ListItem Text="&nbsp;No" Value="No" />
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ControlToValidate="rblRecommend" ErrorMessage="Selection required" runat="server" CssClass="text-danger" />
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold">Additional Comments</label>
                <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Tell us more about your visit..."></asp:TextBox>
            </div>

            <asp:Button ID="btnSubmitSurvey" runat="server" Text="Submit Feedback" CssClass="btn btn-primary w-100 p-2 fw-bold" OnClick="btnSubmitSurvey_Click" />
        </div>
    </div>
</asp:Content>

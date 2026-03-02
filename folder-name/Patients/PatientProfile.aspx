<%@ Page Title="Patient Profile"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="PatientProfile.aspx.cs"
    Inherits="shatha11822App3.ClinicManagementSystem.Patient.PatientProfile" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

<div class="container d-flex justify-content-center">
    <div class="w-100" style="max-width:900px;">

        <div class="dashboard-card">
            <h3 class="dashboard-title text-center">Patient Profile</h3>

            <p><strong>Full Name:</strong> <asp:Label ID="lblName" runat="server" /></p>
            <p><strong>Phone:</strong> <asp:Label ID="lblPhone" runat="server" /></p>
            <p><strong>Gender:</strong> <asp:Label ID="lblGender" runat="server" /></p>
            <p><strong>Date of Birth:</strong> <asp:Label ID="lblDOB" runat="server" /></p>

            <hr />

            <h4>Visit Information</h4>

            <asp:CheckBoxList ID="cblReasons" runat="server">
                <asp:ListItem Text="Checkup" />
                <asp:ListItem Text="Follow-up" />
                <asp:ListItem Text="Emergency" />
                <asp:ListItem Text="Consultation" />
            </asp:CheckBoxList>

            <asp:TextBox ID="txtSymptoms" runat="server"
                TextMode="MultiLine" Rows="3"
                CssClass="form-control" />

            <div class="mt-3 text-center">
                <asp:Button ID="btnUpdate" runat="server"
                    Text="Update"
                    CssClass="btn btn-primary"
                    OnClick="btnUpdate_Click" />

                <asp:Button ID="btnDelete" runat="server"
                    Text="Delete"
                    CssClass="btn btn-danger"
                    OnClick="btnDelete_Click" />
            </div>
        </div>

        <div class="dashboard-card mt-4">
            <asp:GridView ID="gvProfile" runat="server"
                CssClass="table table-bordered"
                AutoGenerateColumns="true" />
        </div>

    </div>
</div>

</asp:Content>
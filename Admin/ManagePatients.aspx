<%@ Page Title="Manage Patients" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ManagePatients.aspx.cs"
    Inherits="shatha11822App3.ClinicManagementSystem.Admin.ManagePatients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary fw-bold"><i class="bi bi-people me-2"></i>Manage Patients</h2>
            <div>
                <asp:Button ID="btnAddNew" runat="server" Text="Register New Patient" CssClass="btn btn-success shadow-sm me-2" OnClick="btnAddNew_Click" CausesValidation="false" />
                <asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click" CssClass="btn btn-outline-success shadow-sm" CausesValidation="false">
                    <i class="bi bi-file-earmark-excel me-1"></i> Export to Excel
                </asp:LinkButton>
            </div>
        </div>

        <asp:Panel ID="pnlAddEdit" runat="server" CssClass="card shadow-sm p-4 mb-4" Visible="false">
            <h4 class="mb-3 text-secondary">Patient Details</h4>
            <asp:HiddenField ID="hfPatientID" runat="server" />
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">Full Name</label>
                    <asp:TextBox ID="txtPatientName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtPatientName" ErrorMessage="Name required" Display="Dynamic" ForeColor="Red" />
                </div>
                <div class="col-md-4">
                    <label class="form-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Phone</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="mt-4">
                <asp:Button ID="btnSave" runat="server" Text="Save Patient" CssClass="btn btn-primary px-4" OnClick="btnSave_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-light" OnClick="btnCancel_Click" CausesValidation="false" />
            </div>
        </asp:Panel>

        <div class="card border-0 shadow-sm">
            <asp:GridView ID="gvPatients" runat="server" AutoGenerateColumns="False" DataKeyNames="patientId"
                CssClass="table table-hover align-middle mb-0" GridLines="None" DataSourceID="dsPatients">
                <HeaderStyle CssClass="table-light" />
                <Columns>
                    <asp:BoundField DataField="patientId" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="fullName" HeaderText="Patient Name" />
                    <asp:BoundField DataField="email" HeaderText="Email" />
                    <asp:BoundField DataField="phone" HeaderText="Phone" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"
                        ControlStyle-CssClass="btn btn-sm btn-link text-decoration-none" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <asp:SqlDataSource ID="dsPatients" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicDB %>"
        SelectCommand="SELECT patientId, fullName, email, phone FROM Patients"
        UpdateCommand="UPDATE Patients SET fullName=@fullName, email=@email, phone=@phone WHERE patientId=@patientId"
        DeleteCommand="DELETE FROM Patients WHERE patientId=@patientId"></asp:SqlDataSource>
</asp:Content>

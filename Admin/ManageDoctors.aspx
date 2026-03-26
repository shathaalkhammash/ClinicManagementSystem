<%@ Page Title="Manage Doctors" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ManageDoctors.aspx.cs"
    Inherits="shatha11822App3.ClinicManagementSystem.Admin.ManageDoctors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary fw-bold"><i class="bi bi-person-badge me-2"></i>Manage Doctors</h2>
            <div>
                <asp:Button ID="btnAddNew" runat="server" Text="Add New Doctor" CssClass="btn btn-success shadow-sm me-2"
                    OnClick="btnAddNew_Click" CausesValidation="false" />

                <asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click" CssClass="btn btn-outline-success shadow-sm" CausesValidation="false">
                    <i class="bi bi-file-earmark-excel me-1"></i> Export to Excel
                </asp:LinkButton>
            </div>
        </div>

        <asp:Panel ID="pnlAddEdit" runat="server" CssClass="card shadow-sm p-4 mb-4" Visible="false">
            <h4 class="mb-3 text-secondary">Doctor Details</h4>
            <asp:HiddenField ID="hfDoctorID" runat="server" />

            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">Doctor Name</label>
                    <asp:TextBox ID="txtDoctorName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtDoctorName"
                        ErrorMessage="Name required" Display="Dynamic" ForeColor="Red" ValidationGroup="AddDoctor" />
                </div>
                <div class="col-md-4">
                    <label class="form-label">Specialty</label>
                    <asp:DropDownList ID="ddlSpecialty" runat="server" CssClass="form-select">
                        <asp:ListItem>Cardiology</asp:ListItem>
                        <asp:ListItem>Dentist</asp:ListItem>
                        <asp:ListItem>Dermatology</asp:ListItem>
                        <asp:ListItem>Pediatrics</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Phone</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone"
                        ErrorMessage="Phone required" Display="Dynamic" ForeColor="Red" ValidationGroup="AddDoctor" />
                </div>
            </div>

            <div class="mt-4">
                <asp:Button ID="btnSave" runat="server" Text="Save Doctor" CssClass="btn btn-primary px-4" OnClick="btnSave_Click" ValidationGroup="AddDoctor" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-light" OnClick="btnCancel_Click" CausesValidation="false" />
            </div>
        </asp:Panel>

        <div class="card border-0 shadow-sm">
            <asp:GridView ID="gvDoctors" runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="DoctorID"
                CssClass="table table-hover align-middle mb-0"
                GridLines="None"
                OnRowEditing="gvDoctors_RowEditing"
                OnRowCancelingEdit="gvDoctors_RowCancelingEdit"
                OnRowUpdating="gvDoctors_RowUpdating"
                OnRowDeleting="gvDoctors_RowDeleting"
                DataSourceID="SqlDataSource1">

                <HeaderStyle CssClass="table-light" />
                <Columns>
                    <asp:BoundField DataField="DoctorID" HeaderText="ID" ReadOnly="True" ItemStyle-CssClass="text-muted" />

                    <asp:TemplateField HeaderText="Doctor Name">
                        <ItemTemplate><%# Eval("FullName") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDoctorNameEdit" runat="server" Text='<%# Bind("FullName") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Specialty">
                        <ItemTemplate><%# Eval("Specialty") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlSpecialtyEdit" runat="server" CssClass="form-select" SelectedValue='<%# Bind("Specialty") %>'>
                                <asp:ListItem>Cardiology</asp:ListItem>
                                <asp:ListItem>Dentist</asp:ListItem>
                                <asp:ListItem>Dermatology</asp:ListItem>
                                <asp:ListItem>Pediatrics</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Phone">
                        <ItemTemplate><%# Eval("Phone") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPhoneEdit" runat="server" Text='<%# Bind("Phone") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"
                        ControlStyle-CssClass="btn btn-sm btn-link text-decoration-none"
                        EditText="<i class='bi bi-pencil'></i> Edit"
                        DeleteText="<i class='bi bi-trash'></i> Delete" />
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center p-4">No doctors found in the system.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:ClinicDB %>"
        SelectCommand="SELECT DoctorID, FullName, Specialty, Phone FROM Doctors"
        UpdateCommand="UPDATE Doctors SET FullName=@FullName, Specialty=@Specialty, Phone=@Phone WHERE DoctorID=@DoctorID"
        DeleteCommand="DELETE FROM Doctors WHERE DoctorID=@DoctorID">
        <UpdateParameters>
            <asp:Parameter Name="FullName" Type="String" />
            <asp:Parameter Name="Specialty" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="DoctorID" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="DoctorID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

</asp:Content>

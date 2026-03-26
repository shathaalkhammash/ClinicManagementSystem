<%@ Page Title="Manage Appointments" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="ManageAppointments.aspx.cs"
    Inherits="shatha11822App3.ClinicManagementSystem.Admin.ManageAppointments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary fw-bold"><i class="bi bi-calendar-check me-2"></i>Manage Appointments</h2>
            <asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click" CssClass="btn btn-outline-success shadow-sm">
                <i class="bi bi-file-earmark-excel me-1"></i> Export to Excel
            </asp:LinkButton>
        </div>

        <div class="card border-0 shadow-sm">
            <asp:GridView ID="gvAppointments" runat="server" AutoGenerateColumns="False" DataKeyNames="appointmentId"
                CssClass="table table-hover align-middle mb-0" GridLines="None" DataSourceID="dsAppointments">
                <HeaderStyle CssClass="table-light" />
                <Columns>
                    <asp:BoundField DataField="appointmentId" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="PatientName" HeaderText="Patient" ReadOnly="True" />
                    <asp:BoundField DataField="DoctorName" HeaderText="Doctor" ReadOnly="True" />
                    <asp:BoundField DataField="appointmentDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# GetStatusClass(Eval("status").ToString()) %>'>
                                <%# Eval("status") %>
                            </span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStatusEdit" runat="server" SelectedValue='<%# Bind("status") %>' CssClass="form-select form-select-sm">
                                <asp:ListItem>Pending</asp:ListItem>
                                <asp:ListItem>Approved</asp:ListItem>
                                <asp:ListItem>Canceled</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="Notes" HeaderText="Notes" />

                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"
                        ControlStyle-CssClass="btn btn-sm btn-link text-decoration-none" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <asp:SqlDataSource ID="dsAppointments" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicDB %>"
        SelectCommand="SELECT a.appointmentId, p.fullName AS PatientName, d.fullName AS DoctorName, a.appointmentDate, a.status, a.Notes 
                       FROM Appointments a 
                       JOIN Patients p ON a.patientId = p.patientId 
                       JOIN Doctors d ON a.doctorId = d.doctorId"
        UpdateCommand="UPDATE Appointments SET appointmentDate=@appointmentDate, status=@status, Notes=@Notes WHERE appointmentId=@appointmentId"
        DeleteCommand="DELETE FROM Appointments WHERE appointmentId=@appointmentId"></asp:SqlDataSource>
</asp:Content>


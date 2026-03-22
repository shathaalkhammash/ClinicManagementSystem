<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageAppointments.aspx.cs" Inherits="shatha11822App3.web11.Admin.ManageAppointments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
        .admin-container { padding: 20px; direction: ltr; }
        .form-box { background: #f4f4f4; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #ddd; }
        .my-grid { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .my-grid th { background-color: #007bff; color: white; padding: 10px; }
        .my-grid td { padding: 8px; border: 1px solid #eee; text-align: center; }
    </style>

    <div class="admin-container">
        <h2>Manage Appointment</h2>

        <div class="form-box">
            <h4>Book New Appointment</h4>
            <div style="display: flex; gap: 10px; align-items: center; flex-wrap: wrap;">
                <div>
                    Patient Name: <asp:TextBox ID="txtPatientName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div>
                    Doctor: <asp:DropDownList ID="ddlDoctors" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
                <div>
                    Date: <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                </div>
                <asp:Button ID="btnAdd" runat="server" Text="Save Appointment" OnClick="btnAdd_Click" CssClass="btn btn-primary" />
                <asp:Button ID="btnExport" runat="server" Text="Export to Excel" OnClick="btnExport_Click" CssClass="btn btn-success" Style="margin-bottom:10px;" />
            </div>
        </div>

        <asp:GridView ID="gvAppointments" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="AppointmentID" OnRowDeleting="gvAppointments_RowDeleting" CssClass="my-grid">
            <Columns>
                <asp:BoundField DataField="AppointmentID" HeaderText="ID" />
                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                <asp:BoundField DataField="DoctorName" HeaderText="Doctor" />
                <asp:BoundField DataField="AppointmentDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" 
                            OnClientClick="return confirm('Are you sure you want to delete this appointment?');" Text="Delete" ForeColor="Red" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

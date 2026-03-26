<%@ Page Title="Book Appointment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PatientBook.aspx.cs" Inherits="shatha11822App3.ClinicManagementSystem.Patient.PatientBook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h4 class="mb-0">Book an Appointment</h4>
                    </div>
                    <div class="card-body p-4">

                       
                        <asp:UpdatePanel ID="upBooking" runat="server">
                            <ContentTemplate>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">1. Select Specialty</label>
                                    <asp:DropDownList ID="ddlSpecialty" runat="server" CssClass="form-select"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlSpecialty_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">2. Select Doctor</label>
                                    <asp:DropDownList ID="ddlDoctors" runat="server" CssClass="form-select">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvDoctor" runat="server" ControlToValidate="ddlDoctors"
                                        InitialValue="0" ErrorMessage="Please select a doctor" CssClass="text-danger small" Display="Dynamic" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <div class="mb-3">
                            <label class="form-label fw-bold">3. Appointment Date</label>
                            <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate"
                                ErrorMessage="Please pick a date" CssClass="text-danger small" Display="Dynamic" />
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">4. Notes/Symptoms</label>
                            <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="Optional notes..."></asp:TextBox>
                        </div>

                        <div class="d-grid gap-2 mt-4">
                            <asp:Button ID="btnSubmit" runat="server" Text="Confirm Booking" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                            <a href="PatientProfile.aspx" class="btn btn-link text-muted">Cancel</a>
                        </div>

                        
                        <div class="mt-3">
                            <asp:Label ID="lblStatus" runat="server" CssClass="text-danger fw-bold"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


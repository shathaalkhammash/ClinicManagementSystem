<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="shatha11822App3.ClinicManagementSystem.Admin.AdminDashboard" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .dash-card {
            border-radius: 12px;
            padding: 30px;
            color: white;
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
            border: none;
        }

        .bg-blue {
            background: #007bff;
        }

        .bg-green {
            background: #28a745;
        }

        .bg-purple {
            background: #6f42c1;
        }

        .dash-card i {
            position: absolute;
            right: 15px;
            top: 15px;
            font-size: 3rem;
            opacity: 0.2;
        }

        .dash-card h3 {
            font-size: 2.5rem;
            font-weight: bold;
        }
    </style>

    <div class="container mt-5">
        <h2 class="mb-4">Welcome, System Administrator</h2>
        <p class="text-muted">Here is a quick summary of the clinic's current status.</p>
        <hr />

        <div class="row">
            <div class="col-md-4">
                <div class="dash-card bg-blue shadow">
                    <i class="fas fa-users"></i>
                    <h5>Registered Patients</h5>
                    <h3>
                        <asp:Label ID="lblPatientCount" runat="server" Text="0"></asp:Label></h3>
                    <a href="ManagePatient.aspx" class="text-white small text-decoration-none">View All Patients →</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="dash-card bg-green shadow">
                    <i class="fas fa-user-md"></i>
                    <h5>Active Doctors</h5>
                    <h3>
                        <asp:Label ID="lblDoctorCount" runat="server" Text="0"></asp:Label></h3>
                    <a href="#" class="text-white small text-decoration-none">Manage Staff →</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="dash-card bg-purple shadow">
                    <i class="fas fa-comment-medical"></i>
                    <h5>Total Feedbacks</h5>
                    <h3>
                        <asp:Label ID="lblSurveyCount" runat="server" Text="0"></asp:Label></h3>
                    <a href="AdminSurvey.aspx" class="text-white small text-decoration-none">Read Reviews →</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


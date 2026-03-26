%@ Page Title="Admin Survey" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminSurvey.aspx.cs" Inherits="shatha11822App3.ClinicManagementSystem.Admin.AdminSurvey" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .admin-card {
            margin-top: 30px;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .table-header {
            background-color: #0d6efd !important;
            color: white !important;
            text-align: center;
        }

        .btn-delete-row {
            background-color: #dc3545;
            color: white;
            padding: 4px 10px;
            border-radius: 5px;
            text-decoration: none;
            border: none;
            font-size: 13px;
        }

            .btn-delete-row:hover {
                background-color: #a71d2a;
                color: white;
            }
    </style>

    <div class="container">
        <div class="admin-card">
            <h2 class="text-center mb-4"><i class="fas fa-clipboard-list"></i>Patient Survey Results</h2>

            <div class="table-responsive">
                <asp:GridView ID="gvSurvey" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-hover table-bordered"
                    DataKeyNames="surveyId" OnRowDeleting="gvSurvey_RowDeleting">

                    <HeaderStyle CssClass="table-header" />

                    <Columns>
                        <asp:BoundField DataField="surveyId" HeaderText="ID" />
                        <asp:BoundField DataField="patientId" HeaderText="Patient ID" />
                        <asp:BoundField DataField="department" HeaderText="Department" />

                        <asp:TemplateField HeaderText="Rating">
                            <ItemTemplate>
                                <span class="badge bg-primary"><%# Eval("overallRating") %>/5</span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="recommendClinic" HeaderText="Recommend?" />
                        <asp:BoundField DataField="comments" HeaderText="Comments" />
                        <asp:BoundField DataField="submissionDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />

                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete"
                                    Text="Delete" CssClass="btn-delete-row"
                                    OnClientClick="return confirm('Are you sure you want to delete this survey?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <div class="text-center mt-3">
                <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success d-inline-block" Visible="false"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageDoctors.aspx.cs" Inherits="shatha11822App3.web11.Admin.ManageDoctors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<h2 style="color:#4B0082;">&nbsp;</h2>
    <h2 style="color:#4B0082;">&nbsp;</h2>
    <h2 style="color:#4B0082;">Manage Doctors</h2>

<br />

<asp:Button ID="btnAddNew" runat="server"
Text="Add New Doctor"
CssClass="btn btn-primary"
OnClick="btnAddNew_Click" />

<br /><br />

<!-- جدول الأطباء -->

<asp:GridView ID="gvDoctors"
runat="server"
AutoGenerateColumns="False"
DataKeyNames="DoctorID"
CssClass="table table-bordered table-striped"

OnRowEditing="gvDoctors_RowEditing"
OnRowCancelingEdit="gvDoctors_RowCancelingEdit"
OnRowUpdating="gvDoctors_RowUpdating"
OnRowDeleting="gvDoctors_RowDeleting"

DataSourceID="SqlDataSource1">

<Columns>

<asp:BoundField DataField="DoctorID" HeaderText="ID" ReadOnly="True" />

<asp:BoundField DataField="DoctorName" HeaderText="Doctor Name" />

<asp:BoundField DataField="Specialty" HeaderText="Specialty" />

<asp:BoundField DataField="Phone" HeaderText="Phone" />

<asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />

</Columns>

</asp:GridView>

<br />

<!-- Panel إضافة دكتور -->

<asp:Panel ID="pnlAddEdit" runat="server" Visible="false" CssClass="card p-4">

<h4>Add / Edit Doctor</h4>

<asp:HiddenField ID="hfDoctorID" runat="server" />

<br />

<!-- Doctor Name -->

<label>Doctor Name</label>

<asp:TextBox ID="txtDoctorName" runat="server" CssClass="form-control"></asp:TextBox>

<asp:RequiredFieldValidator
ID="rfvName"
runat="server"
ControlToValidate="txtDoctorName"
ErrorMessage="Doctor name required"
ForeColor="Red" />

    <br />

<br />

<!-- Specialty DropDown -->

<label>Specialty</label>

<asp:DropDownList ID="ddlSpecialty" runat="server" CssClass="form-control">

<asp:ListItem>Cardiology</asp:ListItem>
<asp:ListItem>Dentist</asp:ListItem>
<asp:ListItem>Dermatology</asp:ListItem>
<asp:ListItem>Pediatrics</asp:ListItem>

</asp:DropDownList>

<br />

<!-- Gender Radio -->

<label>Gender</label>

<asp:RadioButtonList ID="rblGender" runat="server">

<asp:ListItem>Male</asp:ListItem>
<asp:ListItem>Female</asp:ListItem>

</asp:RadioButtonList>

<br />

<!-- Working Days -->

<label>Working Days</label>

<asp:CheckBoxList ID="cblDays" runat="server">

<asp:ListItem>Sunday</asp:ListItem>
<asp:ListItem>Monday</asp:ListItem>
<asp:ListItem>Tuesday</asp:ListItem>
<asp:ListItem>Wednesday</asp:ListItem>
<asp:ListItem>Thursday</asp:ListItem>

</asp:CheckBoxList>

<br />

<!-- Phone -->

<label>Phone</label>

<asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>

<asp:RequiredFieldValidator
ID="rfvPhone"
runat="server"
ControlToValidate="txtPhone"
ErrorMessage="Phone required"
ForeColor="Red" />

<br /><br />

<!-- Buttons -->

<asp:Button ID="btnSave"
runat="server"
Text="Save"
CssClass="btn btn-success"
OnClick="btnSave_Click" />

<asp:Button ID="btnCancel"
runat="server"
Text="Cancel"
CssClass="btn btn-secondary"
OnClick="btnCancel_Click" />

<asp:Button ID="btnHome"
runat="server"
Text="Back Home"
PostBackUrl="~/Default.aspx"
CssClass="btn btn-dark" />

</asp:Panel>

<!-- Data Source -->

<asp:SqlDataSource
ID="SqlDataSource1"
runat="server"
ConnectionString="<%$ ConnectionStrings:ClinicDBConnectionString %>"
SelectCommand="SELECT * FROM Doctors" OnSelecting="SqlDataSource1_Selecting">

</asp:SqlDataSource>

</asp:Content>

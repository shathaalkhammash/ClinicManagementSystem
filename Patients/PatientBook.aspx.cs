using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace shatha11822App3.ClinicManagementSystem.Patient
{
    public partial class PatientBook : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/ClinicManagementSystem/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadSpecialties();
                ddlDoctors.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Specialty First --", "0"));
            }
        }

        private void LoadSpecialties()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT DISTINCT specialty FROM Doctors ORDER BY specialty";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                ddlSpecialty.DataSource = cmd.ExecuteReader();
                ddlSpecialty.DataTextField = "specialty";
                ddlSpecialty.DataValueField = "specialty";
                ddlSpecialty.DataBind();
                ddlSpecialty.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Specialty --", "0"));
            }
        }

        protected void ddlSpecialty_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSpecialty.SelectedValue != "0")
            {
                LoadDoctors(ddlSpecialty.SelectedValue);
            }
            else
            {
                ddlDoctors.Items.Clear();
                ddlDoctors.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Specialty First --", "0"));
            }
        }

        private void LoadDoctors(string specialty)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT doctorId, fullName FROM Doctors WHERE specialty = @spec";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@spec", specialty);
                con.Open();
                ddlDoctors.DataSource = cmd.ExecuteReader();
                ddlDoctors.DataTextField = "fullName";
                ddlDoctors.DataValueField = "doctorId";
                ddlDoctors.DataBind();
                ddlDoctors.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select a Doctor --", "0"));
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["PatientId"] == null)
            {
                lblStatus.Text = "Session expired. Please login again.";
                return;
            }

            if (ddlDoctors.SelectedValue == "0")
            {
                lblStatus.Text = "Please select a doctor.";
                return;
            }

            if (string.IsNullOrEmpty(txtDate.Text))
            {
                lblStatus.Text = "Please select a date.";
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO Appointments 
                        (patientId, doctorId, appointmentDate, status, Notes) 
                        VALUES (@pid, @did, @date, 'Pending', @notes)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@pid", Session["PatientId"]);
                cmd.Parameters.AddWithValue("@did", ddlDoctors.SelectedValue);
                cmd.Parameters.AddWithValue("@date", DateTime.Parse(txtDate.Text));
                cmd.Parameters.AddWithValue("@notes",
                    string.IsNullOrEmpty(txtNotes.Text) ? (object)DBNull.Value : txtNotes.Text.Trim());

                try
                {
                    con.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        Response.Redirect("PatientProfile.aspx");
                    }
                    else
                    {
                        lblStatus.Text = "Booking failed.";
                    }
                }
                catch (Exception ex)
                {
                    lblStatus.Text = ex.Message;
                }
            }
        }
    }
}

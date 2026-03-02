using System;
using System.Data.SqlClient;
using System.Configuration;

namespace shatha11822App3.ClinicManagementSystem.Patient
{
    public partial class Signup1 : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int newPatientId;

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO Patients
                    (fullName, email, phone, gender, DOB, password)
                    OUTPUT INSERTED.patientId
                    VALUES
                    (@fullName, @email, @phone, @gender, @dob, @password)
                ", con);

                cmd.Parameters.AddWithValue("@fullName",
                    txtFirstName.Text + " " + txtLastName.Text);

                cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@password", txtPassword.Text);
                cmd.Parameters.AddWithValue("@gender", rblGender.SelectedValue);

                cmd.Parameters.AddWithValue("@phone",
                    string.IsNullOrWhiteSpace(txtPhone.Text)
                        ? (object)DBNull.Value
                        : txtPhone.Text);

                cmd.Parameters.AddWithValue("@dob",
                    string.IsNullOrWhiteSpace(txtDOB.Text)
                        ? (object)DBNull.Value
                        : txtDOB.Text);

                con.Open();
                newPatientId = (int)cmd.ExecuteScalar();
            }

            Session["PatientId"] = newPatientId;
            Response.Redirect("PatientProfile.aspx");
        }
    }
}
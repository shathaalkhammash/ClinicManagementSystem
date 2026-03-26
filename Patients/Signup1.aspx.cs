using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;

namespace shatha11822App3.ClinicManagementSystem.Patient
{
    public partial class Signup1 : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    string email = txtEmail.Text.Trim().ToLower();
                    string password = txtPassword.Text.Trim();
                    string firstName = txtFirstName.Text.Trim();
                    string lastName = txtLastName.Text.Trim();
                    string fullName = firstName + " " + lastName;

                    
                    string phoneInput = txtPhone.Text.Trim();
                    object phoneVal = string.IsNullOrWhiteSpace(phoneInput) ? DBNull.Value : (object)phoneInput;

                   
                    string userQuery = @"INSERT INTO Users (userName, passwordHash, role) 
                                 VALUES (@email, @pass, 'Patient'); 
                                 SELECT SCOPE_IDENTITY();";

                    SqlCommand cmdUser = new SqlCommand(userQuery, con, transaction);
                    cmdUser.Parameters.AddWithValue("@email", email);
                    cmdUser.Parameters.AddWithValue("@pass", password);

                    
                    int newUserId = Convert.ToInt32(cmdUser.ExecuteScalar());

                   
                    string patientQuery = @"INSERT INTO Patients (fullName, email, phone, gender, DOB, password) 
                                    OUTPUT INSERTED.patientId 
                                    VALUES (@name, @email, @phone, @gender, @dob, @pass)";

                    SqlCommand cmdPat = new SqlCommand(patientQuery, con, transaction);
                    cmdPat.Parameters.AddWithValue("@name", fullName);
                    cmdPat.Parameters.AddWithValue("@email", email);
                    cmdPat.Parameters.AddWithValue("@phone", phoneVal);
                    cmdPat.Parameters.AddWithValue("@gender", rblGender.SelectedValue);
                    cmdPat.Parameters.AddWithValue("@pass", password);

                    
                    cmdPat.Parameters.AddWithValue("@dob", string.IsNullOrWhiteSpace(txtDOB.Text) ?
                                                    (object)DBNull.Value : txtDOB.Text.Trim());

                    
                    int newPatientId = Convert.ToInt32(cmdPat.ExecuteScalar());

                    
                    transaction.Commit();

               
                    Session["UserId"] = newUserId;
                    Session["UserEmail"] = email;
                    Session["PatientId"] = newPatientId;
                    Session["PatientName"] = fullName;

                    Response.Redirect("PatientProfile.aspx", false);
                }
                catch (Exception ex)
                {
                    if (transaction != null && transaction.Connection != null)
                        transaction.Rollback();

                    string msg = ex.Message.Replace("'", "");
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Signup Error: {msg}');", true);
                }
            }
        }
    }
}

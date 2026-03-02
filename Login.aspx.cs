using System;
using System.Data.SqlClient;
using System.Configuration;

namespace shatha11822App3.ClinicManagementSystem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT patientId, fullName
                      FROM patients
                      WHERE email = @email AND password = @password", con);

                cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@password", txtPassword.Text);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    // ✅ Save session
                    Session["PatientId"] = dr["patientId"];
                    Session["PatientName"] = dr["fullName"];

                    // ✅ Go to patient profile
                    Response.Redirect("~/ClinicManagementSystem/Patient/PatientProfile.aspx");
                }
                else
                {
                    // ❌ Wrong login
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "alert",
                        "alert('Invalid email or password');",
                        true);
                }
            }
        }
    }
}
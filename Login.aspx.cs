using System;
using System.Data.SqlClient;
using System.Configuration;

namespace shatha11822App3.ClinicManagementSystem.Patient
{
    public partial class Login : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (SqlConnection con = new SqlConnection(cs))
            {
                
                string query = @"SELECT u.userId, u.role, p.patientId 
                         FROM Users u 
                         LEFT JOIN Patients p ON u.userName = p.email 
                         WHERE u.userName = @user AND u.passwordHash = @pass";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@user", email);
                cmd.Parameters.AddWithValue("@pass", password);

                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                      
                        Session["UserId"] = dr["userId"].ToString();
                        Session["UserEmail"] = email;
                        string role = dr["role"].ToString();
                        Session["UserRole"] = role;

                       
                        if (role == "Patient")
                        {
                            if (dr["patientId"] != DBNull.Value)
                            {
                                
                                Session["PatientId"] = dr["patientId"].ToString();
                                Response.Redirect("~/ClinicManagementSystem/Patient/PatientProfile.aspx");
                            }
                            else
                            {
                                
                                lblError.Text = "Error: Patient profile missing. Please contact Admin.";
                            }
                        }
                        else if (role == "Admin")
                        {
                            Response.Redirect("~/ClinicManagementSystem/Admin/AdminDashboard.aspx");
                        }
                    }
                    else
                    {
                        lblError.Text = "Invalid email or password.";
                        lblError.Visible = true;
                    }
                }
            }
        }
    }
}

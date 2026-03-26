using System;
using System.Data.SqlClient;
using System.Configuration;

namespace shatha11822App3.ClinicManagementSystem.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetDashboardStats();
            }
        }

        private void GetDashboardStats()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                
                SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM Patients", con);
                lblPatientCount.Text = cmd1.ExecuteScalar().ToString();

                
                SqlCommand cmd2 = new SqlCommand("SELECT COUNT(*) FROM PatientSurveys", con);
                lblSurveyCount.Text = cmd2.ExecuteScalar().ToString();

               
                try
                {
                    SqlCommand cmd3 = new SqlCommand("SELECT COUNT(*) FROM Doctors", con);
                    lblDoctorCount.Text = cmd3.ExecuteScalar().ToString();
                }
                catch
                {
                    lblDoctorCount.Text = "0"; 
                }
            }
        }
    }
}

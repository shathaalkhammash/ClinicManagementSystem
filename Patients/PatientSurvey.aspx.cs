using System;
using System.Data.SqlClient;
using System.Configuration;

namespace shatha11822App3.ClinicManagementSystem.Patient
{
    public partial class PatientSurvey : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["UserId"] == null)
            {
                
                Response.Redirect("~/ClinicManagementSystem/Login.aspx");
            }
        }

        protected void btnSubmitSurvey_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO PatientSurveys (patientId, department, overallRating, recommendClinic, comments) 
                                VALUES (@pid, @dept, @rate, @recom, @comm)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@pid", Session["PatientId"]);
                cmd.Parameters.AddWithValue("@dept", ddlDepartment.SelectedValue);
                cmd.Parameters.AddWithValue("@rate", rblRating.SelectedValue);
                cmd.Parameters.AddWithValue("@recom", rblRecommend.SelectedValue);
                cmd.Parameters.AddWithValue("@comm", txtComments.Text.Trim());

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    
                    btnSubmitSurvey.Enabled = false;
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Thank you! Your feedback has been submitted.'); window.location='PatientProfile.aspx';", true);
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                }
            }
        }
    }
}

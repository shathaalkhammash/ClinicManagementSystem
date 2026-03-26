using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace shatha11822App3.ClinicManagementSystem.Admin
{
    public partial class AdminSurvey : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSurvey();
            }
        }

        private void LoadSurvey()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                
                string query = @"SELECT surveyId, patientId, department, overallRating, recommendClinic, comments, submissionDate 
                                FROM PatientSurveys 
                                ORDER BY submissionDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();

                try
                {
                    da.Fill(dt); 
                    gvSurvey.DataSource = dt;
                    gvSurvey.DataBind();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error loading data: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
        }

        protected void gvSurvey_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int sId = Convert.ToInt32(gvSurvey.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "DELETE FROM PatientSurveys WHERE surveyId=@ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ID", sId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMsg.Visible = true;
            lblMsg.Text = "Survey deleted successfully.";
            lblMsg.CssClass = "alert alert-success";
            LoadSurvey();
        }
    }
}

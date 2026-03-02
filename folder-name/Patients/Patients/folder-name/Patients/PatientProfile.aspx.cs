using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace shatha11822App3.ClinicManagementSystem.Patient
{
    public partial class PatientProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["PatientId"] == null)
                {
                    Response.Redirect("Signup1.aspx");
                    return;
                }

                LoadPatientInfo();
                LoadGrid();
            }
        }

        private int PatientId => (int)Session["PatientId"];

        private void LoadPatientInfo()
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT fullName, phone, gender, DOB
                    FROM Patients
                    WHERE patientId = @id", con);

                cmd.Parameters.AddWithValue("@id", PatientId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblName.Text = dr["fullName"].ToString();
                    lblPhone.Text = dr["phone"].ToString();
                    lblGender.Text = dr["gender"].ToString();
                    lblDOB.Text = dr["DOB"] == DBNull.Value
                        ? "Not provided"
                        : Convert.ToDateTime(dr["DOB"]).ToShortDateString();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
                    UPDATE Patients
                    SET reasons=@reasons, symptoms=@symptoms
                    WHERE patientId=@id", con);

                cmd.Parameters.AddWithValue("@reasons", GetSelectedReasons());
                cmd.Parameters.AddWithValue("@symptoms", txtSymptoms.Text);
                cmd.Parameters.AddWithValue("@id", PatientId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadGrid();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
                    UPDATE Patients
                    SET reasons=NULL, symptoms=NULL
                    WHERE patientId=@id", con);

                cmd.Parameters.AddWithValue("@id", PatientId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            txtSymptoms.Text = "";
            foreach (ListItem i in cblReasons.Items) i.Selected = false;
            LoadGrid();
        }

        private string GetSelectedReasons()
        {
            string r = "";
            foreach (ListItem i in cblReasons.Items)
                if (i.Selected) r += i.Text + ", ";
            return r.TrimEnd(',', ' ');
        }

        private void LoadGrid()
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(@"
                    SELECT fullName, reasons, symptoms
                    FROM Patients
                    WHERE patientId=@id", con);

                da.SelectCommand.Parameters.AddWithValue("@id", PatientId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvProfile.DataSource = dt;
                gvProfile.DataBind();
            }
        }
    }
}

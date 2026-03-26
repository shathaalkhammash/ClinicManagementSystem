using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace shatha11822App3.ClinicManagementSystem.Admin
{
    public partial class GetHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string pid = Request.QueryString["pid"];
            string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                
                string sql = @"SELECT appointmentDate, Notes 
                       FROM Appointments 
                       WHERE patientId = @pid AND Notes IS NOT NULL 
                       ORDER BY appointmentDate DESC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@pid", pid);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                string html = "<ul class='list-group list-group-flush'>";

                bool hasHistory = false;
                while (rdr.Read())
                {
                    hasHistory = true;
                    string date = Convert.ToDateTime(rdr["appointmentDate"]).ToString("MMM dd, yyyy");
                    string note = rdr["Notes"].ToString();

                    html += $"<li class='list-group-item'>" +
                            $"<small class='text-muted d-block'>{date}</small>" +
                            $"<strong>Diagnosis/Illness:</strong> {note}</li>";
                }

                if (!hasHistory) html += "<li class='list-group-item'>No recorded illness history.</li>";

                html += "</ul>";
                Response.Write(html);
                Response.End();
            }
        }
    }
}
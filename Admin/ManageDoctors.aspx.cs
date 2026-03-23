using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace shatha11822App3.web11.Admin
{
    public partial class ManageDoctors : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ClinicDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            pnlAddEdit.Visible = true;

            txtDoctorName.Text = "";
            txtPhone.Text = "";
            ddlSpecialty.SelectedIndex = 0;

            hfDoctorID.Value = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //  Server-side validation
            if (string.IsNullOrEmpty(txtDoctorName.Text) || string.IsNullOrEmpty(txtPhone.Text))
            {
                Response.Write("<script>alert('Please fill all required fields');</script>");
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                if (hfDoctorID.Value == "")
                {
                    cmd.CommandText = "INSERT INTO Doctors (DoctorName,Specialty,Phone) VALUES (@name,@spec,@phone)";
                }
                else
                {
                    cmd.CommandText = "UPDATE Doctors SET DoctorName=@name, Specialty=@spec, Phone=@phone WHERE DoctorID=@id";
                    cmd.Parameters.AddWithValue("@id", hfDoctorID.Value);
                }

                cmd.Parameters.AddWithValue("@name", txtDoctorName.Text);
                cmd.Parameters.AddWithValue("@spec", ddlSpecialty.SelectedValue);
                cmd.Parameters.AddWithValue("@phone", txtPhone.Text);

                cmd.ExecuteNonQuery();

                gvDoctors.DataBind();
                rptDoctors.DataBind();

                pnlAddEdit.Visible = false;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlAddEdit.Visible = false;
        }

        protected void gvDoctors_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewRow row = gvDoctors.Rows[e.NewEditIndex];

            hfDoctorID.Value = gvDoctors.DataKeys[e.NewEditIndex].Value.ToString();

            txtDoctorName.Text = row.Cells[1].Text;
            ddlSpecialty.SelectedValue = row.Cells[2].Text;
            txtPhone.Text = row.Cells[3].Text;

            pnlAddEdit.Visible = true;
        }

        protected void gvDoctors_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDoctors.EditIndex = -1;
            gvDoctors.DataBind();
        }

        protected void gvDoctors_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvDoctors_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            e.Cancel = true;

            int doctorID = Convert.ToInt32(gvDoctors.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "DELETE FROM Doctors WHERE DoctorID=@DoctorID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@DoctorID", doctorID);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvDoctors.DataBind();
            rptDoctors.DataBind();
        }
    }
}

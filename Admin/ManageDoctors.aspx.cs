using System;
using System.Data;
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

        // زر إضافة دكتور جديد
        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            pnlAddEdit.Visible = true;

            txtDoctorName.Text = "";
            txtPhone.Text = "";
            ddlSpecialty.SelectedIndex = 0;

            hfDoctorID.Value = "";
        }

        // حفظ الدكتور
        protected void btnSave_Click(object sender, EventArgs e)
        {
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
                pnlAddEdit.Visible = false;
            }
        }

        // زر إلغاء
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlAddEdit.Visible = false;
        }

        // تعديل من الجدول
        protected void gvDoctors_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewRow row = gvDoctors.Rows[e.NewEditIndex];

            hfDoctorID.Value = gvDoctors.DataKeys[e.NewEditIndex].Value.ToString();

            txtDoctorName.Text = row.Cells[1].Text;
            ddlSpecialty.SelectedValue = row.Cells[2].Text;
            txtPhone.Text = row.Cells[3].Text;

            pnlAddEdit.Visible = true;
        }

        // إلغاء التعديل
        protected void gvDoctors_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDoctors.EditIndex = -1;
            gvDoctors.DataBind();
        }

        // تحديث الدكتور
        protected void gvDoctors_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        // حذف الدكتور
        protected void gvDoctors_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            e.Cancel = true; // يمنع SqlDataSource من تنفيذ الحذف

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
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}

using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace shatha11822App3.ClinicManagementSystem.Admin
{
    public partial class ManageDoctors : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ClinicDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            {
                Response.Redirect("~/ClinicManagementSystem/Login.aspx");
            }

            if (!IsPostBack)
            {
                gvDoctors.DataBind();
            }
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
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = string.IsNullOrEmpty(hfDoctorID.Value)
                    ? "INSERT INTO Doctors (FullName, Specialty, Phone) VALUES (@name, @spec, @phone)"
                    : "UPDATE Doctors SET FullName=@name, Specialty=@spec, Phone=@phone WHERE DoctorID=@id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@name", txtDoctorName.Text.Trim());
                    cmd.Parameters.AddWithValue("@spec", ddlSpecialty.SelectedValue);
                    cmd.Parameters.AddWithValue("@phone", txtPhone.Text.Trim());
                    if (!string.IsNullOrEmpty(hfDoctorID.Value))
                        cmd.Parameters.AddWithValue("@id", hfDoctorID.Value);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            gvDoctors.DataBind();
            pnlAddEdit.Visible = false;
        }

        protected void btnCancel_Click(object sender, EventArgs e) => pnlAddEdit.Visible = false;

        protected void gvDoctors_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvDoctors.EditIndex = e.NewEditIndex;
            gvDoctors.DataBind();
        }

        protected void gvDoctors_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDoctors.EditIndex = -1;
            gvDoctors.DataBind();
        }

        protected void gvDoctors_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvDoctors.Rows[e.RowIndex];
            int doctorID = Convert.ToInt32(gvDoctors.DataKeys[e.RowIndex].Value);

            
            TextBox txtName = (TextBox)row.FindControl("txtDoctorNameEdit");
            DropDownList ddlSpec = (DropDownList)row.FindControl("ddlSpecialtyEdit");
            TextBox txtPh = (TextBox)row.FindControl("txtPhoneEdit");

            if (txtName != null && ddlSpec != null && txtPh != null)
            {
                string fullName = txtName.Text.Trim();
                string specialty = ddlSpec.SelectedValue;
                string phone = txtPh.Text.Trim();

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "UPDATE Doctors SET FullName=@FullName, Specialty=@Specialty, Phone=@Phone WHERE DoctorID=@DoctorID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Specialty", specialty);
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@DoctorID", doctorID);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            gvDoctors.EditIndex = -1;
            gvDoctors.DataBind();
        }

        protected void gvDoctors_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int doctorID = Convert.ToInt32(gvDoctors.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Doctors WHERE DoctorID=@DoctorID", con))
                {
                    cmd.Parameters.AddWithValue("@DoctorID", doctorID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            gvDoctors.DataBind();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            string fileName = "ClinicExport_" + DateTime.Now.ToString("yyyyMMdd") + ".xls";
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName);
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    gvDoctors.AllowPaging = false;
                    gvDoctors.DataBind();

                    
                    int actionColumnIndex = gvDoctors.Columns.Count - 1;
                    gvDoctors.Columns[actionColumnIndex].Visible = false;

                    gvDoctors.RenderControl(hw);
                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();
                }
            }
        }

        public override void VerifyRenderingInServerForm(Control control) { }
    }
}

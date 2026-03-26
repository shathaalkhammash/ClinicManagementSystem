using System;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;


namespace shatha11822App3.ClinicManagementSystem.Admin
{
    public partial class ManagePatients : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Simple session security check
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
                Response.Redirect("~/ClinicManagementSystem/Login.aspx");
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            pnlAddEdit.Visible = true;
            hfPatientID.Value = "";
            txtPatientName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
        }

        protected void btnCancel_Click(object sender, EventArgs e) => pnlAddEdit.Visible = false;

        protected void btnSave_Click(object sender, EventArgs e)
        {
            
            pnlAddEdit.Visible = false;
            gvPatients.DataBind();
        }

        
        protected void btnExport_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Patients_List.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    gvPatients.AllowPaging = false;
                    gvPatients.DataBind();

                    
                    gvPatients.Columns[gvPatients.Columns.Count - 1].Visible = false;

                    gvPatients.RenderControl(hw);
                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();
                }
            }
        }

        public override void VerifyRenderingInServerForm(Control control) { }
    }
}

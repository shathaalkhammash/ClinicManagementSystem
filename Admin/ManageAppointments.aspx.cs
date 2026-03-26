using System;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;

namespace shatha11822App3.ClinicManagementSystem.Admin
{
    public partial class ManageAppointments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
                Response.Redirect("~/ClinicManagementSystem/Login.aspx");
        }

 
        protected string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "approved": return "badge bg-success text-white px-2 py-1 rounded-pill";
                case "pending": return "badge bg-warning text-dark px-2 py-1 rounded-pill";
                case "canceled": return "badge bg-danger text-white px-2 py-1 rounded-pill";
                default: return "badge bg-secondary text-white px-2 py-1 rounded-pill";
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Clinic_Appointments.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    gvAppointments.AllowPaging = false;
                    gvAppointments.DataBind();

                   
                    gvAppointments.Columns[gvAppointments.Columns.Count - 1].Visible = false;

                    gvAppointments.RenderControl(hw);
                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();
                }
            }
        }

        public override void VerifyRenderingInServerForm(Control control) { }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace shatha11822App3.web11.Admin
{
    public partial class ManageAppointments : System.Web.UI.Page
    {
                            //شذى هنا حطي الداتا بيس حقتك 
    string connString = @"Data Source=DESKTOP-C4L4SKR\SQLEXP2017;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
        //@"Data Source=.\SQLEXP2017E;Initial Catalog=saraDB12308;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {
        if (!IsPostBack)
            {
                FillDoctorsList();
                BindGrid(); // تحميل المواعيد عند فتح الصفحة لأول مرة
            }

        }

        // دالة لجلب البيانات من SQL وعرضها في الجدول
        void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = @"SELECT A.appointmentId, A.patientName, A.appointmentDate, A.status, D.DoctorName 
                         FROM [saraDB12308].[dbo].[appointments] A
                         LEFT JOIN [saraDB12308].[dbo].[Doctors] D ON A.DoctorID = D.DoctorID";  //هنا لازم تعدلين على الداتا تحطين حقك
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                try
                {
                    sda.Fill(dt);
                }
                catch (Exception ex)
                {
                    Response.Write("خطأ في الاتصال: " + ex.Message);
                }
                //sda.Fill(dt);
                gvAppointments.DataSource = dt;
                gvAppointments.DataBind();
            }
        }


        // كود إضافة موعد جديد
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // 1. التأكد من أن المستخدم اختار طبيباً ولم يترك الخيار الافتراضي
            if (ddlDoctors.SelectedValue == "0")
            {
                Response.Write("<script>alert('Please select a doctor first');</script>");
                return;
            }

            using (SqlConnection con = new SqlConnection(connString))
            {
                // 2. جملة الإضافة مع اسم القاعدة والجدول الكامل
                string query = "INSERT INTO [saraDB12308].[dbo].[appointments] (patientName, appointmentDate, status, DoctorID) " +
                               "VALUES (@name, @date, 'Pending', @docId)"; // هنا ايضا تعدلين على الداتا

                SqlCommand cmd = new SqlCommand(query, con);

                // 3. ربط القيم من الواجهة بالمتغيرات في الـ SQL
                cmd.Parameters.AddWithValue("@name", txtPatientName.Text);
                cmd.Parameters.AddWithValue("@date", txtDate.Text);
                cmd.Parameters.AddWithValue("@docId", ddlDoctors.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery(); // تنفيذ الإضافة
                con.Close();

                // 4. مسح الخانات بعد الإضافة لراحة المستخدم
                txtPatientName.Text = "";
                txtDate.Text = "";
                ddlDoctors.SelectedIndex = 0;

                // 5. تحديث الجدول (GridView) ليظهر الموعد الجديد فوراً
                BindGrid();
            }
        }


        // كود حذف موعد
        protected void gvAppointments_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvAppointments.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "DELETE FROM [saraDB12308].[dbo].[appointments] WHERE appointmentId = @id"; //هنا ايضا تعديل
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", id);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                BindGrid(); // تحديث الجدول بعد الحذف
            }
        }

        void FillDoctorsList()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                //  [dbo].[Doctors] للتأكد
                string query = "SELECT DoctorID, DoctorName FROM [saraDB12308].[dbo].[Doctors]"; // هنا كمان تعديل
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                ddlDoctors.DataSource = dt;
                ddlDoctors.DataTextField = "DoctorName"; // الاسم الذي يظهر للمستخدم
                ddlDoctors.DataValueField = "DoctorID";   // القيمة المخفية (الرقم)
                ddlDoctors.DataBind();

                // إضافة خيار افتراضي في البداية
                ddlDoctors.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Doctor --", "0"));
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=AppointmentsReport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                // 2. إخفاء عمود "Actions" (الحذف) قبل التصدير لكي لا يظهر في الاكسل
                gvAppointments.Columns[gvAppointments.Columns.Count - 1].Visible = false;

                // 3. تحويل الـ GridView إلى HTML
                gvAppointments.RenderControl(hw);

                // 4. كتابة الكود في ملف الاكسل
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        // 5. ضروري جداً إضافة هذه الميثود فارغة لمنع حدوث خطأ RenderControl
        public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET server control at run time. */
        }


        
    }
}

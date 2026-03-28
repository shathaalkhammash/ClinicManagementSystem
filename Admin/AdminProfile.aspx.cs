using System;
using System.Web.UI;

public partial class AdminProfile : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) 
        {
            
            txtName.Text = "مريم";
            txtEmail.Text = "admin@clinic.com";
        }
    }

   
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
       

       
        lblMessage.Text = "تم تحديث البيانات بنجاح!";
    }
}
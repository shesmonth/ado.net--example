using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace _9._3_6
{
    public partial class ContactAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGroup();//绑定分组下拉框
            }
        }

        private void BindGroup()
        {
            string sql = "select id,groupname from contactgroup";
            DataTable dt = SqlDbHelper.ExecuteDataTable(sql);
            //下拉框的文本和值绑定
            DropDownList1.DataTextField = "groupname";
            DropDownList1.DataValueField = "id";
            //数据源
            DropDownList1.DataSource = dt;
            //数据绑定
            DropDownList1.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (txtName.Text == "")
            {
                lblMsg.Text = "姓名不能为空";
                return;
            }
            string sql = "insert into contact(name,phone,email,groupid) values(@name, @phone, @email, @groupid)";
            SqlParameter[] sp = {new SqlParameter("@name", txtName.Text),
                                 new SqlParameter("@phone", txtPhone.Text),
                                 new SqlParameter("@email", txtEmail.Text),
                                 new SqlParameter("@groupid",Convert.ToInt32(DropDownList1.SelectedValue))};
            SqlDbHelper.ExecuteNonQuery(sql, CommandType.Text, sp);
            //Response.Redirect("Default.aspx");
            Response.Write("<script>alert('录入成功！');window.location.href='Default.aspx' </script>");
        }
    }
}
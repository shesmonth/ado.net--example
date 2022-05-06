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
    public partial class ContactEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //判断是否获取到了id
            //没有获取到就跳回主页
            if (string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                Response.Redirect("Default.aspx");
            }

            //首次页面加载时，调用指定ID的原值数据信息
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"]; //获取主键
                lblID.Text = id;

                BindGroup(); //绑定分组下拉框 

                string sql = "select id,name,phone,email,groupid from contact where id=@id";
                SqlParameter[] sp = { new SqlParameter("@id", Convert.ToInt32(id)) };
                using (SqlDataReader dr = SqlDbHelper.ExecuteReader(sql, CommandType.Text, sp))
                {
                    if (dr.Read())
                    {
                        txtName.Text = dr["name"].ToString();
                        txtPhone.Text = dr["phone"].ToString();
                        txtEmail.Text = dr["email"].ToString();
                        //选中相应的分组
                        DropDownList1.SelectedValue = dr["groupid"].ToString();
                    }
                }
            }

        }

        private void BindGroup()
        {
            string sql = "select id,groupname from contactgroup";
            DataTable dt = SqlDbHelper.ExecuteDataTable(sql);
            DropDownList1.DataTextField = "groupname";
            DropDownList1.DataValueField = "id";
            DropDownList1.DataSource = dt;
            DropDownList1.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (txtName.Text == "")
            {
                lblMsg.Text = "姓名不能为空";
                return;
            }

            string sql = "update contact set name = @name,phone = @phone,email = @email,groupid = @groupid where id = @id";

            SqlParameter[] sp = {new SqlParameter("@name", txtName.Text),
                                 new SqlParameter("@phone", txtPhone.Text),
                                 new SqlParameter("@email", txtEmail.Text),
                                 new SqlParameter("@groupid",Convert.ToInt32(DropDownList1.SelectedValue)),
                                 new SqlParameter("@id", Convert.ToInt32(lblID.Text))};

            SqlDbHelper.ExecuteNonQuery(sql, CommandType.Text, sp);
            Response.Redirect("Default.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}
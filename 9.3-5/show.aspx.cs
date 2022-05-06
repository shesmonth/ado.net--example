using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace _9._3_5__调用存储过程实现联系人分组录入
{
    public partial class show : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string groupName = txtGroupName.Text.Trim();
            string memo = txtGroupMemo.Text.Trim();
            string connString =ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = "InsertContactGroup"; //存储过程名称
                SqlCommand cmd = new SqlCommand(sql, conn);
                //指定SqlCommand对象的CommandType类型为StoredProcedure
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@GroupName", groupName);
                cmd.Parameters.AddWithValue("@Memo", memo);
                conn.Open();
                int n = cmd.ExecuteNonQuery();
                if (n != 1)
                {
                    Response.Write("添加分组失败！");
                }
                else
                {
                    Response.Write("添加分组成功！");
                }
            }
        }
    }
}
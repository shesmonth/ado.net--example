using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace _9._3_4__使用参数化sql语句实现联系人分组录入
{
    public partial class show : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //获取文本框信息
            string strGroupName = txtGroupName.Text;
            string strGroupMemo = txtGroupMemo.Text;

            //获取数据库连接字符串
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                //sql语句
                string insertSql = "insert into ContactGroup values(@GroupName,@Memo)";
                SqlCommand cmd = new SqlCommand(insertSql, conn);

                //为参数赋值
                cmd.Parameters.AddWithValue("@GroupName", strGroupName);
                cmd.Parameters.AddWithValue("@Memo", strGroupMemo);

                //执行sql语句
                conn.Open();

                int n = cmd.ExecuteNonQuery(); //执行并返回收影响的行数

                if (n!=1)
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
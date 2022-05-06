using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _9._3_3__SqlDataReader及GridView显示分组信息
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) //首次加载时调用
            {
                //获取数据库连接字符串
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = "select * from ContactGroup";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    conn.Open();
                    //返回cmd的查询结果，并将其保存到sqlDataReader对象中
                    SqlDataReader reader = cmd.ExecuteReader();

                    //指定控件的数据源
                    GridView1.DataSource = reader;
                    //绑定数据
                    GridView1.DataBind();

                    reader.Close();
                }
            }
        }

    }
    }
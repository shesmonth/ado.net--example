using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace _9._3_2__使用DataSet及GridView显示分组信息
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) //首次加载时调用
            {
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = "select * from ContactGroup";
                    SqlDataAdapter da = new SqlDataAdapter(sql,conn);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    //指定控件的数据源
                    GridView1.DataSource = ds.Tables[0];
                    //绑定数据
                    GridView1.DataBind();
                }
            }
        }
    }
}
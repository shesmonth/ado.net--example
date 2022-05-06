using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace _9._3_6
{
    public partial class show : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        /// <summary>
        /// 数据绑定方法
        /// </summary>
        private void BindData()
        {
            string sql = "select contact.id,name,phone,email,groupname from contact inner join contactgroup on contact.groupid = contactgroup.id";
            DataTable dt = SqlDbHelper.ExecuteDataTable(sql);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;

            BindData();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //获得当前所在行
            int rowIndex = e.RowIndex;
            //获得当前行的一个key值
            int id = Convert.ToInt32(GridView1.DataKeys[rowIndex].Value);

            string sql = "delete from Contact where id=@id";

            SqlParameter[] sp = {
                             new SqlParameter("@id", id)};

            SqlDbHelper.ExecuteNonQuery(sql, CommandType.Text, sp);

            // 重新绑定
            BindData();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //判断选中的是否是自定义删除的按钮
            if (e.CommandName == "del")
            {
                //获得点击的行
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                //获得主键key值
                int id = Convert.ToInt32(GridView1.DataKeys[rowIndex].Value);

                string sql = "delete from Contact where id=@id";
                SqlParameter[] sp = {
                                new SqlParameter("@id", id)};

                SqlDbHelper.ExecuteNonQuery(sql, CommandType.Text, sp);
            }
            BindData();
        }

        protected void btnBatchDel_Click(object sender, EventArgs e)
        {
            //我们准备选中的一个字符串数组,空字符串
            string sb = String.Empty;

            //遍历
            foreach (GridViewRow gvr in GridView1.Rows)
            {
                //是数据行
                if (gvr.RowType == DataControlRowType.DataRow)
                {
                    //根据模板列中的空间ID查找指定的空间
                    CheckBox chk = gvr.FindControl("CheckBox1") as CheckBox;

                    //复选框是选中的
                    if ((chk != null) && chk.Checked)
                    {
                        //取出选中行的主键，加入到字符串中
                        sb += GridView1.DataKeys[gvr.RowIndex].Value + ",";
                    }
                }

                //如果存在选中的项
                if (sb.Length > 0)
                {
                    //去除最后一个逗号
                    sb = sb.Substring(0, sb.Length - 1);
                    string sql = "delete from contact where id in (" + sb + ")";
                    SqlDbHelper.ExecuteNonQuery(sql);
                    BindData();
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContactAdd.aspx"); //转到记录编辑页面
        }
    }
}
using BusinessLayer.Repository.Abstract;
using DataLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer.Repository.Concrete
{
    public class UserConcreteObject : IBaseRepository<User>
    {
        private DataBusiness _dataBusiness;

        public UserConcreteObject()
        {
            _dataBusiness = new DataBusiness();
        }
        public void Create(User entity)
        {
            SqlParameter[] queryParams = new SqlParameter[4];
            queryParams[0] = new SqlParameter("FirstName", entity.FirstName);
            queryParams[1] = new SqlParameter("LastName", entity.LastName);
            queryParams[2] = new SqlParameter("UserName", entity.UserName);
            queryParams[3] = new SqlParameter("Password", entity.Password);
            _dataBusiness.ExecuteCommand("SP_user_create", queryParams);
        }

        public void Delete(User entity)
        {
            SqlParameter[] queryParams = new SqlParameter[1];
            queryParams[0] = new SqlParameter("UserId", entity.UserId);
            _dataBusiness.ExecuteCommand("SP_user_delete", queryParams);
        }

        public int Login(string username, string password)
        {
            SqlParameter[] queryParams = new SqlParameter[2];
            queryParams[0] = new SqlParameter("@username", username);
            queryParams[1] = new SqlParameter("@password", password);

            var result = _dataBusiness.ExecuteReturnIntCommand("SP_Login",queryParams);

            return Convert.ToInt32(result);
        }

        public User Get(SqlParameter[] queryParams = null)
        {
            User returnUser = new User();
            var datatable = _dataBusiness.ExecuteSelectCommand("SP_user_select_by_id", queryParams);

            if (datatable.Rows.Count == 0)
                return null;
            else
            {
                returnUser.UserId = Convert.ToInt32(datatable.Rows[0]["UserId"]);
                returnUser.FirstName = datatable.Rows[0]["FirstName"].ToString();
                returnUser.LastName= datatable.Rows[0]["LastName"].ToString();
                returnUser.UserName = datatable.Rows[0]["UserName"].ToString();
            }

            return returnUser;
        }

        public List<User> GetAll()
        {
            List<User> returnList = new List<User>();

            var datatable = _dataBusiness.ExecuteSelectCommand("SP_user_select");
            for(int i= 0; i < datatable.Rows.Count; i++)
            {
                User returnUser = new User();
                returnUser.UserId = Convert.ToInt32(datatable.Rows[0]["UserId"]);
                returnUser.FirstName = datatable.Rows[0]["FirstName"].ToString();
                returnUser.LastName = datatable.Rows[0]["LastName"].ToString();
                returnUser.UserName = datatable.Rows[0]["UserName"].ToString();

                returnList.Add(returnUser);
            }

            return returnList;
        }

        public void Update(User entity)
        {
            SqlParameter[] queryParams = new SqlParameter[4];
            queryParams[0] = new SqlParameter("FirstName", entity.FirstName);
            queryParams[1] = new SqlParameter("LastName", entity.LastName);
            queryParams[2] = new SqlParameter("UserName", entity.UserName);
            queryParams[3] = new SqlParameter("Password", entity.Password);
            _dataBusiness.ExecuteCommand("SP_user_update", queryParams);
        }
    }
}

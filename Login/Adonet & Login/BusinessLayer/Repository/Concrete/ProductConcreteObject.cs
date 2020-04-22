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
    public class ProductConcreteObject : IBaseRepository<Product>
    {
        DataBusiness _dataBusiness = new DataBusiness();
        public void Create(Product entity)
        {
            _dataBusiness.ExecuteCommand("SP_product_create", new SqlParameter[] {
                new SqlParameter("ProductName", entity.ProductName),
                new SqlParameter("Price", entity.Price),
                new SqlParameter("Stock", entity.Stock)
        });
        }
        public void Delete(int id)
        {
             _dataBusiness.ExecuteCommand("SP_product_delete", new SqlParameter[] {
                 new SqlParameter("Id",id)
            });
        }

        public Product Get(SqlParameter[] queryParams = null)
        {
            Product returnUser = new Product();
            var datatable = _dataBusiness.ExecuteSelectCommand("SP_product_select_by_id", queryParams);

            if (datatable.Rows.Count == 0)
                return null;
            else
            {
                returnUser.Id = Convert.ToInt32(datatable.Rows[0]["Id"]);
                returnUser.ProductName = datatable.Rows[0]["ProductName"].ToString();
                returnUser.Price = Convert.ToInt32(datatable.Rows[0]["Price"].ToString());
                returnUser.Stock = Convert.ToInt32(datatable.Rows[0]["Stock"].ToString());
            }

            return returnUser;
        }

        public DataTable GetAll()
        {
            return _dataBusiness.ExecuteSelectCommand("SP_product_select");
        }

        public void Update(Product entity)
        {
            SqlParameter[] queryParams = new SqlParameter[4];
            queryParams[0] = new SqlParameter("Id", entity.Id);
            queryParams[1] = new SqlParameter("ProductName", entity.ProductName);
            queryParams[2] = new SqlParameter("Price", entity.Price);
            queryParams[3] = new SqlParameter("Stock", entity.Stock);
            _dataBusiness.ExecuteCommand("SP_product_update",queryParams);
          
        }
    }
}
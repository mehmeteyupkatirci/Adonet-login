using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer.Repository.Abstract
{
   public interface IBaseRepository <T> where T:class
    {
        void Create(T entity);
        T Get(SqlParameter[] queryParams=null);
        void Update(T entity);
    }
}

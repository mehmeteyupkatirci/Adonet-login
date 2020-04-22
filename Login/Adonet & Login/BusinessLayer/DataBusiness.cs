using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class DataBusiness
    {
        public DataBusiness()
        {

        }

        public DataBusiness(string ConnectionStringName)
        {
            this.ConnectionStringName = ConnectionStringName;
        }

        private string ConnectionStringName { get; }
        public string ConnectionString
        {
            get
            {
                return ConnectionStringName == null
                    ? ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString
                    : ConfigurationManager.ConnectionStrings[ConnectionStringName].ConnectionString;
            }
        }


        public void ExecuteCommand(string cmdText, SqlParameter[] parameters)
        {
            SqlConnection conn = new SqlConnection(ConnectionString);
            if (conn.State == System.Data.ConnectionState.Closed)
                conn.Open();

            SqlCommand _command = new SqlCommand(cmdText, conn);
            _command.CommandType = System.Data.CommandType.StoredProcedure;
            _command.Parameters.AddRange(parameters);
            _command.ExecuteNonQuery();
            _command.Dispose();
            conn.Close();
        }

        public DataTable ExecuteSelectCommand(string cmdText)
        {
            SqlDataAdapter _adapter =
                new SqlDataAdapter(cmdText, ConnectionString);

            DataTable _dataTable = new DataTable();
            _adapter.Fill(_dataTable);

            return _dataTable;
        }

        public DataTable ExecuteSelectCommand(string cmdText, SqlParameter[] parameters)
        {
            SqlDataAdapter _adapter =
                new SqlDataAdapter(cmdText, ConnectionString);

            _adapter.SelectCommand.Parameters.AddRange(parameters);
            _adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable _dataTable = new DataTable();
            _adapter.Fill(_dataTable);
            
            return _dataTable;
        }

        public int  ExecuteReturnIntCommand( string cmdText, SqlParameter[] parameters)
        {
            int returnValue = 3;
            using (var connection = new SqlConnection(ConnectionString))
            using (var command = new SqlCommand(cmdText, connection))
            {
                command.Parameters.AddRange(parameters);
                command.CommandType = CommandType.StoredProcedure;

                var result = command.Parameters.Add("@ReturnVal",SqlDbType.Int);
                result.Direction = ParameterDirection.ReturnValue;

                connection.Open();
                command.ExecuteNonQuery();

                returnValue = (int)result.Value;
            }
            
            return returnValue;
        }
    }
}

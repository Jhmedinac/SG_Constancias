using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace SG_Constancias
{
    public class ConexionBD
    {
        public string error;
        //string cadena = (ConfigurationManager.ConnectionStrings["DB_PARTICIPACIONConnectionString"].ConnectionString);
        string cadena = (ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString);
        public SqlConnection conexion = new SqlConnection();

        public ConexionBD()
        {
            conexion.ConnectionString = cadena;
        }
        public void abrirConexion()
        {
            try
            {
                conexion.Open();
            }
            catch (Exception e)
            {
                error = e.Message;

            }
        }

        public void cerrarConexion()
        {

            conexion.Close();
        }
    }

}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace _380_Project_3.App_Code
{
    public static class DBHelper
    {
        public static readonly string g_sqlConn = ConfigurationManager.ConnectionStrings["devDB"].ConnectionString;

        public static void Connect(SqlConnection conn)
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
        }

        public static void Disconnect(SqlConnection conn)
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }

        public static void Select(ArrayList columns, String table, ArrayList paramaters)
        {

        }

        public static void Insert(ArrayList columns, String table, ArrayList paramaters)
        {

        }

    }
}
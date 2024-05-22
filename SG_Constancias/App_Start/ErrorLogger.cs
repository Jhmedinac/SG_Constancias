using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace SG_Constancias.App_Start
{
    public class ErrorLogger
    {

        private static readonly string logPath = "C:\\Logs\\ErrorLog.txt";  // Asegúrate de que el directorio exista o modifícalo según tus necesidades

        public static void LogError(Exception ex)
        {
            try
            {
                // Crear el directorio si no existe
                string directory = Path.GetDirectoryName(logPath);
                if (!Directory.Exists(directory))
                {
                    Directory.CreateDirectory(directory);
                }

                // Preparar el mensaje de error con la información de la excepción
                string message = $"Timestamp: {DateTime.Now}\nException Type: {ex.GetType().Name}\nMessage: {ex.Message}\nStackTrace: {ex.StackTrace}\n";

                // Escribir el mensaje de error en el archivo de log
                using (StreamWriter writer = new StreamWriter(logPath, true))  // El segundo parámetro 'true' indica que se añadirá al archivo existente
                {
                    writer.WriteLine(message);
                    writer.WriteLine("------------------------------------------------------");  // Separador para una mejor lectura del log
                }
            }
            catch (Exception loggingException)
            {
                // En caso de error al escribir el log, puedes optar por escribir en la consola o manejarlo de otra forma
                Console.WriteLine("Error logging exception: " + loggingException.Message);
            }
        }

    }
}
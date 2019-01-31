using System;
using System.Threading.Tasks;
using Microsoft.Azure.Devices;

namespace SimpleControl
{
    class Program
    {
        private readonly static string _connectionString = Environment.GetEnvironmentVariable("HUB_CONNECTION_STRING");
        private readonly static string _device = Environment.GetEnvironmentVariable("DEVICE");
        private readonly static string _interval = Environment.GetEnvironmentVariable("MESSAGE_INTERVAL");

        private static ServiceClient client;

        private static async Task SetInterval()
        {
            var parameters = new Model.Interval(_interval);
            var directMethod = new CloudToDeviceMethod(parameters.Name) { ResponseTimeout = parameters.Timeout };

            directMethod.SetPayloadJson(parameters.getPayload());

            Log(ConsoleColor.DarkGray, String.Format("Message: {0} for {1} @ {2}", parameters.Name, _device, DateTime.UtcNow));
            Log(ConsoleColor.Green, parameters.toJson());

            var response = await client.InvokeDeviceMethodAsync(_device, directMethod);

            Log(ConsoleColor.DarkGray, String.Format("Response status: {0}, payload:", response.Status));
            Log(ConsoleColor.Green, response.GetPayloadAsJson());
        }

        private static void Main(string[] args)
        {
            client = ServiceClient.CreateFromConnectionString(_connectionString);
            SetInterval().GetAwaiter().GetResult();
        }

        public static void Log(ConsoleColor color, string message) {
            Console.ForegroundColor = color;
            Console.WriteLine(message);
            Console.ResetColor();
        }
    }
}

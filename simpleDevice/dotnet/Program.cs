using System;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Azure.Devices.Client;

namespace SimpleDevice
{
    class Program
    {
        private static string DeviceConnectionString;


        static async Task Main(string[] args)
        {
            DeviceConnectionString = Environment.GetEnvironmentVariable("DEVICE_CONNECTION_STRING");

            Console.WriteLine("Initializing Device Agent...");
            var device = DeviceClient.CreateFromConnectionString(DeviceConnectionString);
            await device.OpenAsync();

            Console.WriteLine("Device is connected!");
            Console.WriteLine("Press any key to exit...");


            Random rand = new Random();
            while (true)
            {

                var telemetry = new Model.Device
                {
                    WindSpeed = 10 + rand.NextDouble() * 4,
                    Humidity = 60 + rand.NextDouble() * 20
                };
                var message = new Message(Encoding.ASCII.GetBytes(telemetry.toJson()));

                Console.WriteLine("Sending message: " + Encoding.ASCII.GetString(message.GetBytes()));
                await device.SendEventAsync(message);

                Console.WriteLine("SendEvent: " + DateTime.UtcNow);
                Thread.Sleep(2000);
            }
        }
    }
}

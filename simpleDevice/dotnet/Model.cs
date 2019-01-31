using System;
using Newtonsoft.Json;

namespace SimpleDevice.Model
{
    public class Climate
    {
        public string DeviceId { get; set; }
        public double WindSpeed { get; set; }
        public double Humidity { get; set; }
        public DateTime TimeStamp { get; set; }

        public Climate()
        {
            Random rand = new Random();
            DeviceId = Environment.GetEnvironmentVariable("DEVICE");
            WindSpeed = 10 + rand.NextDouble() * 4;
            Humidity = 60 + rand.NextDouble() * 20;
            TimeStamp = DateTime.UtcNow;
        }

        public string toJson()
        {
            return JsonConvert.SerializeObject(this);
        }
    }
}

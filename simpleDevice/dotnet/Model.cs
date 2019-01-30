using System;
using Newtonsoft.Json;

namespace SimpleDevice.Model
{
    public class Device
    {
      public Device()
      {
          DeviceId = Environment.GetEnvironmentVariable("DEVICE");
          TimeStamp = DateTime.UtcNow;
      }
      public string DeviceId { get; set; }
      public double WindSpeed { get; set; }
      public double Humidity { get; set; }
      public DateTime TimeStamp { get; set; }

      public string toJson() {
        return JsonConvert.SerializeObject(this);
      }
    }
}

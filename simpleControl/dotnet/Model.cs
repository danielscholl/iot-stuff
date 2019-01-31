using System;
using Newtonsoft.Json;

namespace SimpleControl.Model
{
    class Interval
    {
        public string Name { get; set; }
        public int Payload { get; set; }
        public TimeSpan Timeout { get; set; }

        public Interval(string interval)
        {
          int i = int.TryParse(interval, out i) ? i : 4;
          Name = "SetInterval";
          Timeout = TimeSpan.FromSeconds(30);
          Payload = i;
        }

        public string getPayload()
        {
            return Payload.ToString();
        }

        public string toJson()
        {
            return JsonConvert.SerializeObject(this);
        }

    }
}

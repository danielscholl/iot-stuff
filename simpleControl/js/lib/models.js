const Model = function () {
  let self = this;

  self.Interval = function Device({ responseTimeoutInSeconds = 30, interval = 10 } = {}) {
    return {
      methodName: 'SetTelemetryInterval',
      payload: interval,
      responseTimeoutInSeconds: responseTimeoutInSeconds,
      toJson: function toJson() {
        return JSON.stringify(this);
      },
    };
  };

  return self;
};

module.exports = new Model();

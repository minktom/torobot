module Torobot
  class Servo
    DEFAULT_PULSE_RANGE = 1000..2000 # 500~2500

    attr_accessor :position, :default
    attr_reader :pulse_range

    def initialize(options={})
      @pulse_range = options[:pulse_range] || DEFAULT_PULSE_RANGE
      @position = @default = options[:default] || 0.5
    end

    def pulse_width
      clamp(raw_pulse_with)
    end

    def reset
      @position = @default
    end

    private

    def clamp(value)
      [min, value, max].sort[1]
    end

    def raw_pulse_with
      (min + interval * position).to_i
    end

    def interval
      max - min
    end

    def min
      pulse_range.min
    end

    def max
      pulse_range.max
    end

  end
end
require "torobot/servo"

module Torobot
  class Controller

    DEFAULT_TIME = 10
    attr_reader :serial, :servos

    def initialize(serial, options={})
      @serial = serial
      @servos = options[:servos] || {}
    end

    def add(ch, servo)
      @servos[ch] = servo
    end

    def get(ch)
      @servos[ch] ||= Servo.new
    end

    def move(args={})
      positions = args.select { |k, _| k.is_a?(Integer) }
      options   = args.reject { |k, _| k.is_a?(Integer) }
      return if positions.empty?

      positions.each do |ch, position|
        get(ch).position = position
      end
      write(channels: positions.keys, time: options[:time])
    end

    def move_all(position, options={})
      hsh = Hash[servos.map { |ch, _| [ch, position] }]
      move options.merge(hsh)
    end

    def read(ad_port)
      serial.write "#UPAD#{ad_port}\n\r"
    end

    def write(channels: :all, time: DEFAULT_TIME)
      return false if servos.empty?
      channels = servos.keys if channels == :all

      commands = channels.map do |ch|
        "##{ch}P#{get(ch).pulse_width}"
      end
      serial.write "#{commands.join}T#{time || DEFAULT_TIME}\n\r"
    end

  end
end
# Torobot

Adapter to Torobot 32 channel servo controller board

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'torobot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install torobot

## Usage

```ruby
require "serialport"
serial = SerialPort.new("/dev/tty.usbserial", 9600)
controller = Torobot::Controller.new(serial)

controller.move(1 => 0.2, 2 => 0.9, time: 120)
# sends "#1P1200#2P1900T120\n\r"
```

## Contributing

1. Fork it ( https://github.com/minktom/torobot/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

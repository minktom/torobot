require "torobot/servo"

module Torobot
  describe Servo do

    describe "#pulse_with" do
      {
        nil => {
          0   => 1000,
          0.2 => 1200,
          0.5 => 1500,
          0.7 => 1700,
          1   => 2000,
        },
        500..2500 => {
          0   => 500,
          0.2 => 900,
          0.5 => 1500,
          0.7 => 1900,
          1   => 2500,
        },
      }.each do |range, cases|
        context "with range #{range}" do
          subject { described_class.new(pulse_range: range) }
          cases.each do |pos, pw|
            it "should convert #{pos} position to #{pw} pulse with" do
              subject.position = pos
              expect(subject.pulse_width).to eq pw
            end
          end
        end
      end
    end

    describe "#reset" do
      it "should restore the position to default" do
        subject.position = 0.9
        expect { subject.reset }
          .to change { subject.position }.from(0.9).to(0.5)
      end

      context "when default value is set" do
        subject { described_class.new(default: 0.25) }

        it "should restore the position to default" do
          subject.position = 0.9
          expect { subject.reset }
            .to change { subject.position }.from(0.9).to(0.25)
        end
      end
    end

  end
end
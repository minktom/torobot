require "torobot/controller"

class DummySerial; end

module Torobot
  describe Controller do

    let(:servos) { nil }
    let(:serial) { DummySerial.new }
    subject { described_class.new(serial, servos: servos) }

    describe "#move" do
      let(:servos) { { 1 => Servo.new, 2  => Servo.new } }

      context "1 servo" do
        it "should send the proper command" do
          expect(serial).to receive(:write).with("#1P1800T10\n\r")
          subject.move(1 => 0.8)
        end
      end

      context "multiple servo" do
        it "should send the proper command" do
          expect(serial).to receive(:write).with("#1P1250#2P1750T10\n\r")
          subject.move(1 => 0.25, 2 => 0.75)
        end
      end

      context "with time option" do
        it "should send #1P1000T150\\n\\r" do
          expect(serial).to receive(:write).with("#1P1000T150\n\r")
          subject.move(1 => 0, time: 150)
        end
      end
    end

    describe "#move_all" do
      let(:servos) { { 1 => Servo.new, 2  => Servo.new } }

      it "should send the proper command" do
        expect(serial).to receive(:write).with("#1P1400#2P1400T10\n\r")
        subject.move_all(0.4)
      end

      context "with time option" do
        it "should send the proper command" do
          expect(serial).to receive(:write).with("#1P1400#2P1400T250\n\r")
          subject.move_all(0.4, time: 250)
        end
      end
    end

    describe "#write" do
      context "without channel" do
        let(:servos) { nil }

        it "should not send anything" do
          expect(serial).not_to receive(:write)
          subject.write
        end
      end

      context "with one channel" do
        let(:servos) { { 1 => Servo.new } }

        it "should send command #1P1500T10\\n\\r" do
          expect(serial).to receive(:write).with("#1P1500T10\n\r")
          subject.write
        end
      end

      context "with multiple channels" do
        let(:servos) { { 1 => Servo.new, 2  => Servo.new } }

        it "should send command #1P1500#2P1500T10\\n\\r" do
          expect(serial).to receive(:write).with("#1P1500#2P1500T10\n\r")
          subject.write
        end
      end
    end

    describe "#read" do
      it "should send command #UPAD1\\n\\r" do
        expect(serial).to receive(:write).with("#UPAD1\n\r")
        subject.read(1)
      end

      it "should send command #UPAD2\\n\\r" do
        expect(serial).to receive(:write).with("#UPAD2\n\r")
        subject.read(2)
      end
    end

  end
end
require 'spec_helper'

describe Message do
  describe '.deliver!' do
    let(:message) { Message.new(body: 'Hello,there') }
    let(:sender) { User.new }
    let(:recipient) { User.new }

    context 'when both the sender and recipient are specified' do
      it 'should set the sender of the message'

      it 'should set the recipient of the message'

      it 'should persist the message to the database'
    end

    context 'when neither the sender or recipient is specified' do
      it 'should raise an error' do
        expect { message.deliver! }.to raise_error ArgumentError  
      end
    end

    context 'when only the sender is specified' do
      it 'should raise an error' do
        expect { message.deliver! sending: sender }.to raise_error ArgumentError
      end
    end

    context 'when only the recipient is specified' do
      it 'should raise an error' do
        expect { message.deliver! receiving: recipient }.to raise_error ArgumentError
      end
    end
  end
end
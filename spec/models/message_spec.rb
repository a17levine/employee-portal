require 'spec_helper'

describe Message do
  describe '.deliver!' do
    let(:message) { Message.new(body: 'Hello,there') }
    let(:message_blank) { Message.new(body: '') }
    let(:sender) { mock_model(User) }
    let(:recipient) { mock_model(User) }

    context 'when both the sender and recipient are specified' do
      before(:each) do
        message.deliver! sending: sender, receiving: recipient
      end
      it 'should set the sender of the message' do
        expect(message.sender).to eq(sender)
      end

      it 'should set the recipient of the message' do
        expect(message.recipient).to eq(recipient)
      end

      it 'should persist the message to the database' do
        expect(message.persisted?).to be_true
      end
    end

    context 'when the message body is blank' do
      it 'should raise an error' do
        message_blank.deliver! sending: sender, receiving: recipient

        expect(message_blank.persisted?).to be_false
      end
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
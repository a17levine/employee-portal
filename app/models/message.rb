class Message < ActiveRecord::Base
  attr_accessible :body

  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

  scope :unread, -> { where(read: false) }

  def deliver!(sending: nil, receiving: nil)
    self.sender = sending
    self.recipient = receiving
    self.save 
    raise ArgumentError, "you need to specify people to send and receive" unless sender && recipient
  end
end

class Message < ActiveRecord::Base
  attr_accessible :body

  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

  scope :unread, -> { where(read: false) }

  def deliver!(sending: nil, receiving: nil)
    self.sender = options[:sending]
    self.recipient = options[:receiving]
    self.save
    raise ArgumentError, "you need to specify people to send and receive" unless sending && receiving
  end
end

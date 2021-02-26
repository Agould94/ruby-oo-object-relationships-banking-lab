require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  
  def initialize(sender, receiver, amount)
    @amount = amount
    @sender = sender
    @receiver = receiver
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid?
      sender.deposit(-amount)
      receiver.deposit(amount)
      sender.status = "closed"
      self.status = "complete"
    else
      self.status = "rejected"
      sender.status = "closed"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if execute_transaction
      receiver.deposit(-amount)
      sender.deposit(amount)
      self.status = "reversed"
    end
  end
end

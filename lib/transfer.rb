require 'pry'

class Transfer
  # your code here
  attr_reader :sender, :receiver, :amount
  attr_accessor :status
  
  def initialize(sender,receiver,amount, status='pending')
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = status
    @log = 0
  end

  def valid?
    @sender.valid? && @receiver.valid? == true
  end

  def execute_transaction
    if @sender.valid? == false || @sender.balance < @amount
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    elsif self.status != "complete"
      @sender.balance -= @amount
      @receiver.deposit(amount)
      self.status = "complete"
      @log += @amount
    end
  end

  def reverse_transfer
    if self.status == "complete"
      @sender.balance += @log
      @receiver.balance -= @log
      self.status = "reversed"
    end
  end

end

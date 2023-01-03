class Patron

  attr_reader :name, :spending_money, :interests

  def initialize(name, cash)
    @name = name
    @spending_money = cash
    @interests = []
  end

  def add_interest(interest)
    @interests << interest
  end

  
end
require './shop_keeper'

class Store
  def initialize
    @shop_keeper = Shop_keeper.new
    until @shop_keeper.get_state == "Ready"
      @shop_keeper.talk
    end
  end
  def get_tank_from_shop_keeper
    @shop_keeper.get_tank
  end
end

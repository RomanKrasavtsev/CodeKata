class CheckOut
  def initialize(price)
    @price = price
    @cart = {}
  end

  def scan(item)
    unless item.nil?
      if @cart[item.to_sym].nil?
        @cart[item.to_sym] = 1
      else
        @cart[item.to_sym] += 1
      end
    end
  end

  def total
    total = 0
    @cart.each do |item, quantity|
      if @price[item.to_sym].has_key?(:special_price)
        special_price = @price[item.to_sym][:special_price][:price]
        special_price_quantity = @cart[item].div(@price[item.to_sym][:special_price][:quantity])

        normal_price = @price[item.to_sym][:price]
        normal_price_quantity = @cart[item].modulo(@price[item.to_sym][:special_price][:quantity])

        total += (special_price * special_price_quantity) + (normal_price * normal_price_quantity)
      else
        total += @cart[item.to_sym] * @price[item.to_sym][:price]
      end
    end

    total
  end
end

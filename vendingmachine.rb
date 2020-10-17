
class Product
  attr_reader :id, :name, :price, :count
  @@count = 0

  def initialize(name:, price:)
    @id = @@count += 1
    @name = name
    @price = price
  end
end

class VendingMachine
  attr_reader :products
  
  def initialize(product_params)
    @products = []
    product_params.each do |param|
      @products << Product.new(param)
    end
  end
  
  # 商品を表示
  def disp_products
    puts "いらっしゃいませ！商品を選んで下さい。"
    @products.each do |product|
      puts "#{product.id}.#{product.name}" "(¥#{product.price})"
    end
  end

  # お金を預かる
  def deposit_money(user)
    puts "先に入金して下さい!"
    puts "・・・"
    puts "#{user.money}円お預かりします"
  end

  # お釣りを計算
  def calculate_charges(user)
    puts "#{user.select_product.name}ですね！"
    chage = user.money - user.select_product.price
    puts "#{user.select_product.price}円の商品です。#{user.money}円お預かりしたので、お釣りは#{chage}円です。"
    puts "お買い上げありがとうございました！"
  end
end

class User
  attr_reader :select_product, :money

  def initialize(money:)
    @money = money
  end

  # 商品を選択
  def choose_product(vendingmachine)
    while true
      print "商品の番号を選択 >"
      select_products_num = gets.to_i
      @select_product = vendingmachine.products.find{|product| product.id == select_products_num}
      break if !@select_product.nil?
      puts "#{vendingmachine.products.first.id}から#{vendingmachine.products.last.id}の番号から選んでください。"
    end
  end

end

#自動販売機の商品
product_params1 = [
  {name:"麦茶", price: 120},
  {name:"お水", price: 100},
  {name:"ジュース", price: 160}
]

# product_params1 の商品を持つ自動販売機
vendingmachine = VendingMachine.new(product_params1)

#お客さんの来店
user1 = User.new(money:1000)

# 商品を表示
vendingmachine.disp_products

# お金を預かる
vendingmachine.deposit_money(user1)

# 商品を選択
user1.choose_product(vendingmachine)

# お釣りを計算
vendingmachine.calculate_charges(user1)
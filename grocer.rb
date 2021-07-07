require 'pry'

def find_item_by_name_in_collection(name, collection) #looks for an item
 index = 0
 while index < collection.length do
    if collection[index][:item] == name 
      return collection[index]
      end
  index += 1
 end 
end

def consolidate_cart(cart)
  new_cart = [] #returns an array for the new cart
  index = 0 
while index < cart.length do 
  new_cart_item = find_item_by_name_in_collection(cart[index][:item], new_cart) #returns item if it finds it, otherwise returns nil
  if new_cart_item #if this variable has a truthy value (anything in Ruby except for nil and false)
  new_cart_item[:count] += 1
else 
  new_cart_item = {
    :item => cart[index][:item],
    :price => cart[index][:price],
    :clearance => cart[index][:clearance],
    :count => 1  #adds the :count key/value pair and sets its value to 1
  }
new_cart << new_cart_item  #shoves the new item into the new cart, including the count
end
index += 1
end
  new_cart  # return [{:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 2}]
end

def apply_coupons(cart, coupons)  #Remember, this method *SHOULD* update the cart
  index = 0 
  while index < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[index][:item], cart) #finds item on the coupon and sees if it's in the cart
    couponed_item_name = "#{coupons[index][:item]} W/COUPON" #creates a variable for the W/COUPON items using string interpolation
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart) #variable that holds couponed item's name
    if cart_item && cart_item[:count] >= coupons[index][:num] #returns either a cart item or nil (if nil, the if statement won't execute)
      if cart_item_with_coupon 
        cart_item_with_coupon[:count] += coupons[index][:num]
        cart_item[:count] -= coupons[index][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[index][:cost] / coupons[index][:num],
          :count => coupons[index][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[index][:num]
      end
      end
    index += 1 
  end
  cart
end

def apply_clearance(cart) #this method *SHOULD* update the cart
 index = 0 
 while index < cart.length do 
  if cart[index][:clearance] #if item's clearance key is true
     cart[index][:price] = (cart[index][:price] - (cart[index][:price] * 0.20)).round(2)
    end
     index += 1
 end 
 cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  total = 0 
  index = 0 
  while index < final_cart.length do
    total += final_cart[index][:price] * final_cart[index][:count]
    index += 1
  end
  if total > 100 
    total -= (total * 0.10) #subtracts 10% if the total is over 100
end
total
end
 # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
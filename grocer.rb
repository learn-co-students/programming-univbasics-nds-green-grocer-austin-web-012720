require 'pry'

def find_item_by_name_in_collection(name, collection)
  #Implement me first!

  i = 0
  
  while i < collection.length do
    if name == collection[i][:item]
      return collection[i]
    end
    i += 1
  end
end

def consolidate_cart(cart)
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  new_cart = []
  
  i = 0
  while i < cart.length do
    item_match = find_item_by_name_in_collection(cart[i][:item], new_cart)
    
    if item_match
      item_match[:count] += 1
    else
      cart[i][:count] = 1
      new_cart << cart[i]
    end  
    i += 1
  end 
  new_cart
end

def apply_coupons(cart, coupons)
  # REMEMBER: This method **should** update cart
  
  i = 0
  while i < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    item_name_with_coupon = "#{coupons[i][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(item_name_with_coupon, cart)
    
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      else
        cart_item_with_coupon = {
          :item => item_name_with_coupon,
          :price => coupons[i][:cost] / coupons[i][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[i][:num]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end  
    end  
    i += 1
  end  
  cart
end

def apply_clearance(cart)
  # REMEMBER: This method **should** update cart
  i = 0
  while i < cart.length do
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] * 0.8).round(2)
    end 
    i += 1
  end
  cart
end

def checkout(cart, coupons)
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  
  new_consolidated_cart = consolidate_cart(cart)
  coupons_have_been_applied = apply_coupons(new_consolidated_cart, coupons)
  final_cart = apply_clearance(coupons_have_been_applied)
  
  i = 0
  total = 0
  
  while i < final_cart.length do
    total += final_cart[i][:price] * final_cart[i][:count]
    i += 1
  end 
  if total > 100
    total = total * 0.9
  end  
  total.round(2)
end

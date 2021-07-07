def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  result = nil
  while index < collection.size do
    if collection[index][:item] == name
      result = collection[index]
      break
    end
    index += 1
  end
  
  result
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  con_cart = []
  index = 0
  while index < cart.size do
    name = cart[index][:item]
    con_item = find_item_by_name_in_collection(name, con_cart)
    if con_item == nil
      con_cart << consolidate_cart_item(cart[index])
    else
      con_item[:count] += 1
    end
    index += 1
  end
  
  con_cart
end

def consolidate_cart_item(item)
  {
    :item => item[:item],
    :price => item[:price],
    :clearance => item[:clearance],
    :count => 1
  }
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < coupons.size do
    coupon = coupons[index]
    if coupon_works(cart, coupon)
      apply_coupon(cart, coupon)
    end
    index += 1
  end
  
  cart
end

def coupon_works(cart, coupon)
  # RETURN: true if the coupon works, false otherwise
  item = find_item_by_name_in_collection(coupon[:item], cart)
  if(item[:item] == coupon[:item])
    if(coupon[:num] <= item[:count])
      return true
    end
  end
  
  return false
end

def apply_coupon(cart, coupon)
  # GOAL: Apply the coupon to the cart
  # RETURN: the cart with the applied coupon
  item = find_item_by_name_in_collection(coupon[:item], cart)

  item_with_coupon = consolidate_cart_item(item)
  item_with_coupon[:item] += " W/COUPON"
  item_with_coupon[:price] = coupon[:cost]/coupon[:num]
  item_with_coupon[:count] = coupon[:num]
  item[:count] -= coupon[:num]
  
  cart << item_with_coupon
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < cart.size do
    item = cart[index]
    if item[:clearance]
      item[:price] *= 0.8
    end
    index += 1
  end
  
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  con_cart = consolidate_cart(cart)
  apply_coupons(con_cart, coupons)
  apply_clearance(con_cart)
  
  total = 0.0
  index = 0
  
  while index < con_cart.size do
    total += con_cart[index][:price] * con_cart[index][:count]
    index += 1
  end
  if total > 100.00
    total *= 0.9
  end
  
  total.round(2)
end

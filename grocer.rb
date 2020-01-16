def find_item_by_name_in_collection(name, collection)
  for i in 0...collection.length do 
        return collection[i] if collection[i][:item] == name
  end 
  return nil
end

def consolidate_cart(cart)
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  arr = []
  for i in 0...cart.length do 
      if arr.include?(cart[i])
          find_item_by_name_in_collection(cart[i][:item],cart)[:count] +=1
      else
         cart[i][:count] = 1
         arr << cart[i]
      end
  end
  return arr
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  for i in 0...cart.length do
      coup = find_item_by_name_in_collection(cart[i][:item], coupons)
      if coup != nil && coup[:num] <= cart[i][:count]
        c = {}
        c[:item] = cart[i][:item] + " W/COUPON"
        c[:price] = coup[:cost]/coup[:num]
        c[:clearance] = cart[i][:clearance] 
        cart[i][:count] -= coup[:num]
        c[:count] = coup[:num]
        
        cart << c
      end
  
  end
  return cart 
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  for i in 0...cart.length do
      if cart[i][:clearance] == true
        cart[i][:price] = (cart[i][:price] * 0.8).round(2)
      end
  end
  return cart 
  
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
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  for i in 0...cart.length
      total+= (cart[i][:price]*cart[i][:count])
  
  end
  if total>100
    total = (total*0.9).round(2)
  end 
  return total
end

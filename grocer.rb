def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  counter = 0
  while counter < collection.length do
      if collection[counter][:item] == name
        return collection[counter]
      end
    counter += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  counter = 0
  while counter < cart.length do
      new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
      if new_cart_item
          new_cart_item[:count] += 1
      else
          new_cart_item = {
              :item => cart[counter][:item],
              :price => cart[counter][:price],
              :clearance => cart[counter][:clearance],
              :count => 1
          }
          new_cart << new_cart_item
      end
      counter += 1
  end
  return new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0
   while counter < coupons.length do
     cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
     item_name_with_coupon = "#{coupons[counter][:item]} W/COUPON"
     cart_item_with_coupon = find_item_by_name_in_collection(item_name_with_coupon, cart)

     if cart_item && cart_item[:count] >= coupons[counter][:num]
       if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
       cart_item_with_coupon = {
         :item => item_name_with_coupon,
         :price => coupons[counter][:cost] / coupons[counter][:num],
         :clearance => cart_item[:clearance],
         :count => coupons[counter][:num]
       }
       cart << cart_item_with_coupon
       cart_item[:count] -= coupons[counter][:num]
     end
   end
   counter += 1
 end
 return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0
  while counter < cart.length do
      if cart[counter][:clearance]
          cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.2)).round(2)
      end
      counter += 1
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
  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(coupons_applied)

  counter = 0
  total = 0

  while counter < final_cart.length do
      total += final_cart[counter][:price] * final_cart[counter][:count]
      counter += 1
  end
  if total > 100
      total = total * 0.9
  end
  return total
end

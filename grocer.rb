def find_item_by_name_in_collection(name, collection)
  # this method will return value of key, specifically value of :item key
  # if the key/value pair exists, else nil
  i = 0 
  while i < collection.length do 
    if collection[i][:item] == name 
      return collection[i]
    end 
    i += 1   
  end

end

def consolidate_cart(cart)
  
  cartSummary = []
  i = 0 
  
  while i < cart.length do 
    cartSummary_item = find_item_by_name_in_collection(cart[i][:item], cartSummary)
    if cartSummary_item != nil 
      cartSummary_item[:count] += 1 
    else 
      cartSummary_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1 
      }
      cartSummary << cartSummary_item
    end 
    i += 1 
  end 
  cartSummary 

end

def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.length do 
    cartItem = find_item_by_name_in_collection(coupons[i][:item], cart)
    coupondItemName = "#{coupons[i][:item]} W/COUPON"
    cartItemWithCoupon = find_item_by_name_in_collection(coupondItemName, cart)

    if cartItem && cartItem[:count] >= coupons[i][:num]
      if cartItemWithCoupon
        cartItemWithCoupon += coupons[i][:num]
        cartItem[:count] -= coupons[i][:num] 
      else
        cartItemWithCoupon = {
          :item => coupondItemName,
          :price => coupons[i][:cost] / coupons[i][:num],
          :clearance => cartItem[:clearance],
          :count => coupons[i][:num] 
        }
        cart << cartItemWithCoupon
        cartItem[:count] -= coupons[i][:num]
      end 
    end 
    i += 1 
  end 
  cart 
end

def apply_clearance(cart)
  i = 0 
  while i < cart.length do 
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] * 0.8).round(3)
    end 
    i += 1
  end 
  cart
end

def checkout(cart, coupons)
  sumaryCart = consolidate_cart(cart)
  couponCart = apply_coupons(sumaryCart, coupons)
  finalCart = apply_clearance(couponCart)

  i = 0 
  checkoutTotal = 0
  while i < finalCart.length do 
    checkoutTotal += finalCart[i][:price] * finalCart[i][:count]
    i += 1
  end 
  if checkoutTotal > 100.00
    checkoutTotal -= (checkoutTotal * 0.1).round(2)
  end 
  checkoutTotal
end

def find_item_by_name_in_collection(name, collection)
 i = 0 
 while i < collection.length do 
   if collection[i][:item] == name
     return collection[i]
    else
    nil
  end
   i += 1 
 end 
end

def consolidate_cart(cart)
  array = [] 
  i = 0 
  while i < cart.length do 
    new_item = find_item_by_name_in_collection(cart[i][:item], array)
    if new_item
      new_item[:count] += 1 
    else 
      new_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1 
      }
      array << new_item
    end #if
    i += 1
  end #while
    array
end

def apply_coupons(cart, coupons)
  i = 0 
  while i < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    coupon_item = "#{coupons[i][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_item, cart)
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      else
        cart_item_with_coupon = {
          :item => coupon_item,
          :price => coupons[i][:cost] / coupons[i][:num],
          :count => coupons[i][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end
      
    end #if 
      
    
    i += 1 
  end #while
  cart
end

def apply_clearance(cart)
 counter = 0 
 while counter < cart.length do 
   if cart[counter][:clearance]
     cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2)
   end 
   counter += 1 
 end 
 cart
end

def checkout(cart, coupons)
 consolidated_cart = consolidate_cart(cart)
 couponed_cart = apply_coupons(consolidated_cart, coupons)
 final_cart = apply_clearance(couponed_cart)
 
 t = 0 
 i = 0 
 while i < final_cart.length do 
   t += final_cart[i][:price] * final_cart[i][:count]
   i += 1 
 end 
 if t > 100
   t -= (t * 0.10)
 end 
 t
end

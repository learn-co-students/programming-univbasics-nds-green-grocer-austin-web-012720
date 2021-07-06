def find_item_by_name_in_collection(name, collection)
  
  new_hash = {}
    
    index = 0
    while index < collection.length
      if collection[index][:item] == name
       return collection[index] 
      end
      index += 1
    end
  end

def consolidate_cart(cart)
  new_array = []
  index = 0
  while index < cart.length
   new_cart_item = find_item_by_name_in_collection(cart[index][:item], new_array)
    if new_cart_item
     new_cart_item[:count] += 1
    else
     new_cart_item = {
       :item => cart[index][:item],
       :price => cart[index][:price],
       :clearance =>cart[index][:clearance],
       :count => 1
        }
      new_array << new_cart_item
     end
     index += 1
   end
   new_array
 end
 
def apply_coupons(cart, coupons)
  counter = 0
  while counter < coupons.length 
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1
  end
  cart
end

def apply_clearance(cart)
  
  index = 0
  while index < cart.length
    if cart[index][:clearance]
      cart[index][:price] -= (cart[index][:price] * 0.2).round(2)
    end
    index += 1
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clear_cart = apply_clearance(couponed_cart)
  index = 0
  total = 0
  
    while index < clear_cart.length
      total += clear_cart[index][:price] * clear_cart[index][:count]
      index += 1
    end
    if total > 100
      total = (total * 0.9).round(2)
    end
    total
end

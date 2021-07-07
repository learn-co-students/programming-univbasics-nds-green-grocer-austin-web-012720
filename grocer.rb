require 'pry'
# binding.pry

def find_item_by_name_in_collection(name, collection)
  index =  0 
  item_hash = {}
  while index < collection.length do 
    if name == collection[index][:item]
      return collection[index]
    end
      index += 1 
  end
end

def consolidate_cart(cart)
  index = 0 
  new_cart = []
  while index < cart.length do 
    new_cart_item = find_item_by_name_in_collection(cart[index][:item], new_cart)
    if new_cart_item    #!= nil 
      new_cart_item[:count] += 1 
    else
      new_cart_item = find_item_by_name_in_collection(cart[index][:item], cart)
      new_cart_item[:count] = 1 
      new_cart << new_cart_item
    end
    index += 1 
  end
  new_cart 
end

def apply_coupons(cart, coupons)
  index = 0 
  while index < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[index][:item], cart)
    couponed_item_name = "#{coupons[index][:item]} W/COUPON"
    cart_item_w_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[index][:num]
      if cart_item_w_coupon
        cart_item_w_coupon[:count] += coupons[index][:num]
        cart_item[:count] -= coupons[index][:num]
      else
        cart_item_w_coupon = {
          :item => couponed_item_name,
          :price => coupons[index][:cost] / coupons[index][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[index][:num]
        }
        cart << cart_item_w_coupon
        cart_item[:count] -= coupons[index][:num]
      end
    end
    index += 1 
  end
  cart
end

def apply_clearance(cart)
  index = 0 
  while index < cart.length do
    if cart[index][:clearance]
      cart[index][:price] *= 0.80
    end
    index += 1 
  end
cart
end

def checkout(cart, coupons)
  cons_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(cons_cart, coupons)
  clear_cart = apply_clearance(couponed_cart)
  total = 0 
  index = 0 
  while index < clear_cart.length do
    total += clear_cart[index][:price] * clear_cart[index][:count]
    if total > 100
      total *= 0.90.round(2)
      return total
    end
    index += 1 
  end
  total.round(2)
end

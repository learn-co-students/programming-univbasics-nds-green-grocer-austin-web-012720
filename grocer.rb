def find_item_by_name_in_collection(name, collection)
  v = 0
  while v < collection.length do
    if collection[v][:item] == name
      return collection[v]
    end
    v += 1
  end
end

def consolidate_cart(cart)
  n = 0
  carts = []
  while n < cart.length do
    cartitem = find_item_by_name_in_collection(cart[i][:item], new_cart)
    if cartitem
      cartitem[:count] += 1
    else
      cartitem = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1 
      }
      carts << cartitem
    end
    n += 1
end
  new_cart

def apply_coupons(cart, coupons)
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
  m = 0
  while m < cart.length do
    if cart [m][:clearance]
      cart[m][:price]=(cart[i][:price]*0.8).round(2)
    end
    m += 1
  end
  cart
end

def checkout(cart, coupons)
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

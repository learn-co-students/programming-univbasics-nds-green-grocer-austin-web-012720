require 'pp'
require 'pry'

def find_item_by_name_in_collection(name, collection)
  collection_index = 0
  while collection_index < collection.size do
    if collection[collection_index][:item] == name
      return collection[collection_index]
    end
    collection_index += 1
  end
  nil
end

def consolidate_cart(cart)
  items_in_cart = []
  cart_index = 0
  while cart_index < cart.size do
    current_item = find_item_by_name_in_collection(cart[cart_index][:item], items_in_cart)
    if current_item == nil
      current_item = {
        item: cart[cart_index][:item],
        price: cart[cart_index][:price],
        clearance: cart[cart_index][:clearance],
        count: 1
      }
      items_in_cart << current_item
    else
      current_item[:count] += 1
    end
    cart_index += 1
  end
  items_in_cart
end

def apply_coupons(cart, coupons)
  cart_index = 0
  while cart_index < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[cart_index][:item], cart)
    coupon_item = "#{coupons[cart_index][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_item, cart)
    if cart_item && cart_item[:count] >= coupons[cart_index][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[cart_index][:num]
      else
        cart_item_with_coupon = {
          :item => coupon_item,
          :price => coupons[cart_index][:cost] / coupons[cart_index][:num],
          :count => coupons[cart_index][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
      end
      cart_item[:count] -= coupons[cart_index][:num]
    end
    cart_index += 1
  end
  cart
end

def apply_clearance(cart)
  cart_index = 0
  while cart_index < cart.length do
    if cart[cart_index][:clearance]
      cart[cart_index][:price] = (0.8 * cart[cart_index][:price]).round(3)
    end
    cart_index += 1
  end
  cart
end

def checkout(cart, coupons)
  cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  cart_index = 0
  total = 0
  while cart_index < cart.length do
    total += (cart[cart_index][:price] * cart[cart_index][:count])
    cart_index += 1
  end
  if total > 100
    total = (0.9 * total).round(3)
  end
  total
end

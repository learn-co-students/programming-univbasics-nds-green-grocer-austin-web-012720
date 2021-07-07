require 'pry'
def find_item_by_name_in_collection(name, collection)

  index = 0 
  while index < collection.size
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1
  end
  nil
end

def consolidate_cart(cart)
  result = []
  cart_index = 0 
  while cart_index < cart.length
    item_looking = find_item_by_name_in_collection(cart[cart_index][:item], result) 
   #binding.pry
    if item_looking != nil
      item_looking[:count] += 1
    else
      item_looking = {
        :item => cart[cart_index][:item],
        :price => cart[cart_index][:price],
        :clearance =>  cart[cart_index][:clearance],
        :count => 1 
      }
      result << item_looking
    end
  cart_index += 1
  end

result
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
counter = 0 
  while counter < cart.length
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
  
  total = 0 
  counter = 0
  while counter < final_cart.size
    total += final_cart[counter][:price] * final_cart[counter][:count]
    counter += 1
  end
  if total > 100  
    total -= (total * 0.10)
  end
  total
end

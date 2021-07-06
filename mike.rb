  coupon_index = 0
  index = 0
  new_array = []
  while coupon_index < coupons.length
    while index < cart.length
      coupon_hash = {}
      stub_hash = {}
        if cart[index][:item] == coupons[coupon_index][:item] && cart[index][:count] == coupons[coupon_index][:num]
          coupon_hash = cart[index]
          coupon_hash[:item] = cart[index][:item] + " W/COUPON"
          coupon_hash[:price] = coupons[coupon_index][:cost] / coupons[coupon_index][:num]
          new_array << coupon_hash
          
          
        elsif cart[index][:item] == coupons[coupon_index][:item] && cart[index][:count] > coupons[coupon_index][:count]
          # using same coupon_hash code from if above
         
          coupon_hash = cart[index]
          coupon_hash[:item] = cart[index][:item] + " W/COUPON"
          coupon_hash[:price] = coupons[coupon_index][:cost] / coupons[coupon_index][:num]
          new_array << coupon_hash
          #add stub_hash
          stub_hash = cart[index]
          stub_hash[:count] = cart[index][:count] - coupons[coupon_index][:num]
          new_array << stub_array
          
          
        else
          new_array << cart[index]
        end
      index += 1
    end
    coupon_index += 1
  end
  new_array
end
class Review < ActiveRecord::Base
  belongs_to :product
  #アソシエーションを定義する。一(product)対多(review)
  #reviews.productの記述を可能にする。
  #アソシエーションを使うことでコードの記述を減らすことができる。
  #アソシエーションを使わない場合
  #product = Product.find(1)
  #Review.where(product_id:product.id)
  #アソシエーションを使う場合
  #reveiws.product
end

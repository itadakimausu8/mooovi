class Product < ActiveRecord::Base
  has_many :reviews
  #アソシエーションを定義する。一(product)対多(review)
  #product.reviewsの記述を可能にする。
end

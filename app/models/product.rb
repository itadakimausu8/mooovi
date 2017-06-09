class Product < ActiveRecord::Base
  has_many :reviews
  #アソシエーションを定義する。一(product)対多(review)
  #product.reviewsの記述を可能にする。

  def review_average
    reviews.average(:rate).round
    #averageは引数にあるカラムの平均を出すことができるメソッドである。
    #roundはレシーバの小数点以下の数値を四捨五入してくれるメソッドである。
    #上記の場合だとself(product).reviews(対応した映画のレビュー)のrateカラムの値の平均を出しその値を四捨五入している。
  end

end

class RankingController < ApplicationController
  #RankingコントローラーはApplicationControllerを継承している。
  #productsコントローラーとreviewsコントローラーはこのRankingControllerを継承している。
  #もしすべてのコントローラーに対して何か処理を行いたいときにはApplicationControllerに処理内容を記述する。
  #もしproductsコントローラーとreviewsコントローラーのみに何か処理を行いたいときにはこのRankingコントローラーに記述する。
  layout 'review_site'
  #layout 'レイアウトファイル名'と記述すると使いたいレイアウトファイルを指定することができる。
  before_action :ranking
  #before_actionはこのコントローラーがアクションをする前に処理を挟むことができる。
  #上記の場合、productsコントローラー、もしくはreviewsコントローラーのアクションが動くとき、動かす前にrankingメソッドの処理を行うという意味。
  def ranking
      product_ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys
      #groupメソッドはレシーバのモデルクラスにある引数のカラムの値が同じレコードをまとめることができる。
      #orderメソッドは順番の並び替えをすることができる。
      #countメソッドは配列などの要素数を返すことができる。
      #keysメソッドはハッシュのキーを取り出して配列として返すことができるメソッド。
      #したがって上記の場合だとまずgroupメソッドよりproduct_idカラムの値が同じレコードのまとまりを作る。
      #次にorderメソッドでまとまりの数が多い順に並び替えlimitメソッドでベスト５だけを残す。
      #countメソッドでproduct_idカラムの値をキー、そして対応したカラムのレコードの数をバリューとするハッシュを生成する。{product_id => 同じproduct_idを持つレコードの数}
      #最後にkeysメソッドでハッシュのキーだけを取り出す。
      #上記の手順でレビュー数の多い順に配列で並び替えることができる。
      @ranking = product_ids.map { |id| Product.find(id) }
      #mapメソッドは配列オブジェクトに使うことができるメソッド。
      #配列から要素を一つ一つ取り出しその値を変数(↑の場合だとid)に入れる。
      #そして指定された処理(↑の場合だとProduct.find(id))を行いその値を配列で返すことができる。
      #上記の場合だとproduct_idsにはレビュー数の多い上位5つのproduct_idが保存されている。
      #mapメソッドによってproduct_idが取り出されその値がfindメソッドの引数となる。
      #結果として上位５つのProductモデルのインスタンスが人気順に配列で返されることになる。
  end
end

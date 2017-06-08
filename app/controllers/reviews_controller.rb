class ReviewsController < RankingController
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    Review.create(create_params)
    redirect_to controller: :products, action: :index
    #redirect_toはリダイレクトの設定をすることができるメソッドである。
    # ↑の場合だとproductコントローラーのindexアクションへ飛ばされる。
    # つまりトップページにリダイレクトする。
  end

  private
  def create_params
    #ストロングパラメーターの作成
     params.require(:review).permit(:nickname, :rate, :review).merge(product_id: params[:product_id])
     #permitメソッドよりストロングパラメーターを作成。
     #指定されたカラムはnickname,rate,reviewである。
     #requireメソッドはform_forから送られてきたパラメーターを取得するために使う。
     #form_forによって送られたパラメーターの中身はモデル名をキーとしたハッシュ値に包まれている。(params = {:モデル名{paramsの中身}})
     #requireメソッドではそのモデル名のキーを引数として中身を取り出すことができる。
     #mergeメソッド二つのハッシュ値を統合するときに使う。
     #上記の場合だと{:nickname=>"aa", :rate=>3, :review=>"aaaa",:product_id=>"1}のように統合される。
  end
end

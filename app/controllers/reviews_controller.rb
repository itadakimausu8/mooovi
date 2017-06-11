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
     params.require(:review).permit(:rate, :review).merge(product_id: params[:product_id],user_id: current_user.id)
     #permitメソッドよりストロングパラメーターを作成。
     #指定されたカラムはrate,reviewである。
     #requireメソッドはform_forから送られてきたパラメーターを取得するために使う。
     #form_forによって送られたパラメーターの中身はモデル名をキーとしたハッシュ値に包まれている。(params = {:モデル名{paramsの中身}})
     #requireメソッドではそのモデル名のキーを引数として中身を取り出すことができる。
     #mergeメソッド二つのハッシュ値を統合するときに使う。
     #user_idカラムはcurrent_userを使って値を呼び出し保存する。
     #user_idカラムはアソシエーションに利用される。
     #上記の場合だと{:rate=>3, :review=>"aaaa",:product_id=>"1,nickname=> taro}のように統合される。
  end
end

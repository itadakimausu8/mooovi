class ProductsController < RankingController
  def index
    @products = Product.order("id ASC").limit(20)
    # orderメソッドでidが若い順(昇順)に並び替える。
    # limitメソッドでProduct.order("id ASC")の最初の20件を取り出す。
    # ↑の場合だとproductsテーブルから最新順に作品を２０件取得し、@productsに代入。
  end

  def show
    @product = Product.find(params[:id])
    # findメソッドよりproductsテーブルから指定されたidに対応するレコードのインスタンスを生成し@productに代入する。
    #params[:id]の中身はURL(/products/:id)の「:id」からきている。
    #:idの値はindex.html.erbのaタグ<a href="/products/<%= product.id %>">からきている。
  end

  def search
    # 検索フォームのキーワードをあいまい検索して、productsテーブルから20件の作品情報を取得する
    @products = Product.where('title LIKE(?)', "%#{params[keyword]}%").limit(20)
    # LIKE句を使って検索システムを作る。
    # モデルクラス名.where('検索するカラム名 LIKE(?)', "検索するキーワード")でキーワードのあいまい検索し、レコードのインスタンスを生成している。
    # 検索するキーワードに入る「 % 」には任意の文字列が入る。
    # 例 "a%" → aで始まるキーワード
    #　  "%a" → aで終わるキーワード
    #limitメソッドで20件に絞り込んでいる。

  end
end

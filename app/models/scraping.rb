#データベースへ保存するのでmodelディレクトリの中に入れる。
#rails cでクラスメソッドを実行しスクレイピングを行う。
class Scraping
  def self.movie_urls
    agent = Mechanize.new
    #.get,.searchといったMechanizeクラスのメソッドを利用するためにインスタンスを作成。
    links = []
    #個別のページのURLを保存するための保管庫(配列)
    next_url = ""
    #next_urlが文字列の変数であることを明示する。
    while true
      current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
      #getメソッドで全体ページのURLを取得。
      elements = current_page.search('.entry-title a')
      #searchメソッドより個別のページ(20個)のURLが記述してあるセレクタを配列で取得。
      elements.each do |ele|
        link = ele.get_attribute('href')
        #eachメソッドよりelements(個別ページのURLが記述されているセレクタ20個)からURLを取得する。
        links << link
        #取得したURLが次に取得されるURLに上書きされる前にlinksに保存する。(配列に入れる)
      end

      next_link = current_page.at('.pagination .next a')
      #paginationクラスのnext_クラスから次のページのURLが記述されたセレクタを取得する。
      break unless next_link
      #もし次のページのリンクを記述したセレクタが存在しなければwhileを止めることができる。
      next_url = next_link.get_attribute('href')
      #次のページのURLを取得する。
    end


    links.each do |link|
      get_product('http://review-movie.herokuapp.com/' + link)
      #get_productメソッドをよびだす。引数には取得した個別ページのURLをeachメソッドで一つ一つ入れていく。
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    #上記参照。上とは別のメソッドなので再び定義しなければならない。
    page = agent.get(link)
    #getメソッドで個別ページの一つを取得する。
    title = page.at('.entry-title').inner_text if page.at('.entry-title')
    #.entry-titleの文字列(タイトル)を取得する。
    #if文はセレクタにある文字列がnullになったときにエラーになることを防ぐことができる。
    image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
    #.entry-contentクラスのimgセレクタから画像のURLを取得する。
    #[:src]はget_attribute('src')の省略形
    #if文はimage_urlがnullになったときにエラーになることを防ぐことができる。
    director = page.at('.director span').inner_text if page.at('.director span')
    #directorクラスのspanセレクタから監督の名前を取得する。
    #if文はセレクタにあるdirectorがnullになったときにエラーになることを防ぐことができる。
    detail = page.at('.entry-content p').inner_text if page.at('.entry-content p')
    #entry-contentクラスのpセレクタから詳細を取得する
    #if文はセレクタにある詳細がnullになったときにエラーになることを防ぐことができる。
    open_date = page.at('.date span').inner_text if page.at('.date span')
    #dateクラスのspanセレクタから公開日を取得する。
    #if文はセレクタにある公開日がnullになったときにエラーになることを防ぐことができる。

    product = Product.where(title: title).first_or_initialize
    #whereメソッドは引数に書いてある条件にレコードをすべて取得することができる。
    #first_or_initializeメソッドはレシーバのレコードがあればそのレコードをインスタンスで返し、なければ新しくインスタンスを作ることができるメソッド。
    #↑の場合だとtitleカラムに同じタイトルがあるかをwhereメソッドが割り出し,first_or_initializeメソッドが同じタイトルがあれば更新、なければ新しく作成するように処理を分配している。
    product.image_url = image_url
    product.director = director
    product.detail = detail
    product.open_date = open_date
    #モデルインスタンス.カラム名= データで対応したDBのカラム名を保存、更新することができる。
    product.save
    #上記の内容をDBに保存する。
  end
end
TechReviewSite::Application.routes.draw do
  devise_for :users
  #ルーティングを設定するファイル
  resources :users, only: :show
  #resourcesメソッドによってproductsコントローラーの７つのルーティングを記述。
  #onlyオプションによって７つの内のshowのルーティングだけを記述する。
  resources :products, only: :show do
  #resourcesメソッドによってproductsコントローラーの７つのルーティングを記述。
  #onlyオプションによって７つの内のshowのルーティングだけを記述する。
  resources :reviews, only: [:new,:create]
  #resourcesメソッドによってreviewsコントローラーの７つのルーティングを記述。
  #onlyオプションによって７つの内のnew,createアクションのルーティングだけを記述する。
    collection do
      get 'search'
    end
      #collectionメソッドは７つのアクション以外のルーティングを設定したいときに使う。

  end
  #resoucesメソッドのルーティングのネストがされている。
  #今回の場合、レビューをするときに(reviewsコントローラー)そのレビューがどの映画(productsコントローラー)に対応しているかを判別するために使う。
  #ネストしたルーティングは以下のようになる。
  #product_reviews POST /products/:product_id/reviews(.:format)     reviews#create
  #new_product_review GET  /products/:product_id/reviews/new(.:format) reviews#new

  root 'products#index'
  #rootメソッドはURLがルート(/)のときに動かすアクションを設定できる。

end

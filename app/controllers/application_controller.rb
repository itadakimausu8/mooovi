class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_actionはこのコントローラーがアクションをする前に処理を挟むことができる。
  #オプションはifである。devise_controllerが動いたときに動かすという意味になる。
  #上の場合だとdeviseコントローラーのアクションが動く前にconfigure_permitted_parametersの処理をするという意味になる。
  def after_sign_out_path_for(resource)
    #サインアウト後のリダイレクト先を設定できる。
    #引数には該当のユーザーのオブジェクトが入る。
    '/users/sign_in'
    #リダイレクト先のパス
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avatar])
    #devise_parameter_sanitizerメソッドはdeviseのストロングパラメーターをいじるときに使う。
    #permit(:sign_up,keys: [:nickname, :avatar])と書くことでサインアップ（新規登録時)のnickname,avatarカラムをストロングパラメーターに追加することができる。
  end

end

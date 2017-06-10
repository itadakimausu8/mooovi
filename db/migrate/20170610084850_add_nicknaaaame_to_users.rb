class AddNicknaaaameToUsers < ActiveRecord::Migration
  # rails g migration Addカラム名(なんでもよい)ToUsers nickname:stringで作成
  # 一つ目のカラム名がなんでもよいそうなので
  # rails g migration AddNicknaaaameToUsers nickname:string
  # で作ってみたらclass名に変化が現れた。
  def change
    add_column :users, :nickname, :string
  end
end

class AddRateToProducts < ActiveRecord::Migration
  # bundle exec rails g migration AddRateToProductsでファイルを作成
  #ActiveRecordモジュールのMigrationクラスを継承
  #bundle exec rake db:migrateでこのマイグレーションファイルを実行。
  #スキーマファイル(schema.rb)に結果が保存される。
  def change
    add_column :products, :director, :string
    add_column :products, :detail, :text
    add_column :products, :open_date, :string
    #add_columnはカラム追加したいときに使う。
    #add_column :テーブル名, :カラム名, :カラムの型 で記述する。
    #同様の書き方remove_columnでカラムを削除もできる。
  end
end

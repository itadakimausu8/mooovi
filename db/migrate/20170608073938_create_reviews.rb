class CreateReviews < ActiveRecord::Migration
  #bundle exec rails g model productでこのファイルを作成。
  #ActiveRecordモジュールのMigrationクラスを継承
  #bundle exec rake db:migrateでこのマイグレーションファイルを実行。
  #スキーマファイル(schema.rb)に結果が保存される。
  def change
    create_table :reviews do |t|
      #reviewsテーブルの作成をする。
      t.string :nickname
      #string型のnicknameカラムを作成。
      t.integer :rate
      #integer型のrateカラムを作成。
      t.text :review
      #text型のreviewカラムを作成。
      t.integer :product_id
      #integer型のproduct_idカラムを作成。
      t.timestamps
    end
  end
end

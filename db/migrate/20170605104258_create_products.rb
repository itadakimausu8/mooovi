class CreateProducts < ActiveRecord::Migration
  #bundle exec rails g model productでこのファイルを作成。
  #ActiveRecordモジュールのMigrationクラスを継承
  #bundle exec rake db:migrateでこのマイグレーションファイルを実行。
  #スキーマファイル(schema.rb)に結果が保存される。
  def change
    create_table :products do |t|
      #t.カラムの型(string,text,integerなど) :カラム名でDBのカラム設定を行うことができる。
      t.string :title          #string型 カラム名:tilte
      t.text :image_url        #text型   カラム名:image_url
      t.timestamps             #timestamps型 作られるカラム:created_at,updated_at
      #timestampsのnull falseを消す理由
      #null falseを消すことでHeidSQLからDBに直接,レコードの追加をできる。
      #t.timestamps null falseは「もしtimestampsカラムの中身がnullだったら、そのレコードの存在を認めない」という意味である。
      #もしHeidSQLからレコードを追加しようとしてもtimstampsに対応するカラムは2つ(created_atとupdated_at)あるのでどちらか(もしくは両方)が必ずnullとなってしまうのでレコードを追加することはできない。
    end
  end
end

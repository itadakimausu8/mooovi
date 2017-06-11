class User < ActiveRecord::Base
  validates :nickname, presence: true
  #validates :カラム名, presence: trueは指定したカラムが存在しないときそのレコードを保存させないようにすることができる。
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 has_attached_file :avatar,
 styles:  { medium: "300x300#", thumb: "100x100#" }
 #has_attached_fileは画像のカラムのサイズやデフォルト画像、ファイルの保存先を設定できる。
 #mediumとthumbはImageMagickで保存できる画像の種類である。
 #上の場合だとmediumの大きさを300×300,thumbの大きさを100×100に指定する。
  validates_attachment_content_type :avatar,
  content_type: ["image/jpg","image/jpeg","image/png"]
  #validates_attachment_content_typeは入力できる画像ファイルの指定を行事ができる。
  #書き方はvalidates_attachment_content_type :指定したいカラム名,
  #content_type: ["画像を指定する"]
  #上の場合だと、avatarカラムに入る画像ファイルは"image/jpg","image/jpeg","image/png"のようにする。
end

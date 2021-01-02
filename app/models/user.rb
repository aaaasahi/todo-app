class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy

  def has_written?(board)
    boards.exists?(id: board.id)
  end

  def has_written?(task)
    tasks.exists?(id: task.id)
  end

  def prepare_profile
    #プロフィールがあればプロフィールなければ空のbuild_profile
    profile || build_profile
  end

  def avatar_image
    #プロフィールがありアバターが保存されていれば表示
    #ログインユーザーしか見れないとこはcurrent_userで定義ログインしてなくても見れるとこはmodel.userで定義
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end
end

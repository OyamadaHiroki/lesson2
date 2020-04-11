class User < ApplicationRecord
    mount_uploader :image, ImageUploader
    has_many :posts
    has_many :active_relationships, class_name:  "Relationship",       
            foreign_key: "follower_id",
            dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
            foreign_key: "followed_id",
            dependent:   :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    has_many :likes
    has_many :repries
    has_secure_password
    
    validates :name,
    presence: true,
    length: {maximum: 12}
    

    validates :email,
    presence: true

    validates :password,
    length: {minimum: 6 },
    format: {
        with: /\A[a-z0-9]+\z/,
        message: 'は小文字英数字で入力してください'
    },
    allow_nil: true

    #ユーザーをフォローする
    def follow(other_user)
        self.following << other_user
    end

    # ユーザーをフォロー解除する
    def unfollow(other_user)
        self.active_relationships.find_by(followed_id: other_user.id).destroy
    end

    # 現在のユーザーがフォローしてたらtrueを返す
    def following?(other_user)
        self.following.where(follower_id: other_user.id).any?
    end
end
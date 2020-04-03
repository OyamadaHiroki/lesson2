class Post < ApplicationRecord
    belongs_to :user
    has_many :repries, dependent: :delete_all
    has_many :like, dependent: :delete_all
    validates :content, presence: true, length: {maximum: 140}
end
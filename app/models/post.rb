class Post < ApplicationRecord
    has_many :repries　
    validates :content, presence: true, length: {maximum: 140}
end

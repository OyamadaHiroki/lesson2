class Post < ApplicationRecord
    belongs_to :user
    has_many :repries, dependent: :delete_all
    has_many :like, dependent: :delete_all
    has_many :post_tag_relations, dependent: :delete_all
    has_many :tags, through: :post_tag_relations, dependent: :delete_all
    validates :content, presence: true, length: {maximum: 140}

    after_create do
        post = Post.find_by(id: self.id)
        tags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
        tags.uniq.map do |tag|
            #ハッシュタグは先頭の'#'を外した上で保存
            tag = Tag.find_or_create_by(name: tag.downcase.delete('#＃'))
            post.tags << tag
        end
    end
end
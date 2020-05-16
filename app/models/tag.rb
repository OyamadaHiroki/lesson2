class Tag < ApplicationRecord
    has_many :post_tag_relations, dependent: :delete_all
    has_many :posts, through: :post_tag_relations, dependent: :delete_all

    validates :name, presence: true, length: {maximum: 20}

    def self.search(search) 
        if search
            self.where(['name LIKE ?', "%#{search}%"]) 
        else
            self.all 
        end
    end
end

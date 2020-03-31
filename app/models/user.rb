class User < ApplicationRecord
    has_secure_password

    validates :name,
    presence: true,
    length: {maximum: 12},
    format: {
        with: /\A[a-z0-9]+\z/,
        message: 'は小文字英数字で入力してください'
    }

    validates :email,
    presence: true

    validates :password,
    length: {minimum: 6 }


end
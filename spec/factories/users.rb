FactoryBot.define do
    factory :user do
        name                  {"taro"}
        email                 {"taro@gmail.com"}
        password              {"00000000"}
        password_confirmation {"00000000"}
        profile               {"自己紹介のサンプルです"}
    end
end
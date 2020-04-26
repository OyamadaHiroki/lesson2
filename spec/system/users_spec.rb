require 'rails_helper'

RSpec.describe "users", type: :system, js: true do

    describe 'マイページ' do

        before do
            @user = create(:user)
            visit root_path
            fill_in 'メールアドレス', with: @user.email
            fill_in 'パスワード', with: @user.password
            click_button 'ログイン'
            click_on 'マイページ'
        end

        it '詳細画面が表示されること' do
            expect(page).to have_content("プロフィールを編集")
        end

        it '編集画面に遷移すること' do
            click_on 'プロフィールを編集'
            expect(page).to have_content("自己紹介")
        end

        it '編集が完了すること' do
            click_on 'プロフィールを編集'
            click_on 'プロフィールを保存'
            expect(page).to have_content("編集が完了しました")
        end

        it '編集が完了すること' do
            click_on 'プロフィールを編集'
            fill_in "自己紹介", with: ""
            click_on 'プロフィールを保存'
            expect(page).to have_content("編集が完了しました")
        end
        
        it '編集が失敗すること' do
            click_on 'プロフィールを編集'
            fill_in "名前", with: ""
            click_on 'プロフィールを保存'
            expect(page).to have_content("編集が失敗しました")
        end

    end

end
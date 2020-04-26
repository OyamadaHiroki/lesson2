require 'rails_helper'

RSpec.describe "Sessions", type: :system, js: true do
    

    describe "新規" do

        before do
            @user = build(:user)
        end

        it '表示されること' do 
            visit "users/new"
            expect(page).to have_content('メールアドレス')
        end

        it '作成できること' do 
            visit "users/new"
            fill_in 'ユーザー名', with: @user.name
            fill_in 'メールアドレス', with: @user.email
            fill_in 'パスワード', with: @user.password
            fill_in 'パスワード（確認）', with: @user.password_confirmation
            click_on 'アカウントを作成'
            expect(page).to have_content('ユーザー登録が完了しました')
        end

        describe "作成に失敗すること" do
            it "ユーザー名がない" do
                visit "users/new"
                fill_in 'メールアドレス', with: @user.email
                fill_in 'パスワード', with: @user.password
                fill_in 'パスワード（確認）', with: @user.password_confirmation
                click_on 'アカウントを作成'
                expect(page).to have_content('ユーザー名を入力してください')
            end

            it "メールアドレスがない" do
                visit "users/new"
                fill_in 'ユーザー名', with: @user.name
                fill_in 'パスワード', with: @user.password
                fill_in 'パスワード（確認）', with: @user.password_confirmation
                click_on 'アカウントを作成'
                expect(page).to have_content('メールアドレスを入力してください')
            end

            it "パスワードがない" do
                visit "users/new"
                fill_in 'ユーザー名', with: @user.name
                fill_in 'メールアドレス', with: @user.email
                fill_in 'パスワード（確認）', with: @user.password_confirmation
                click_on 'アカウントを作成'
                expect(page).to have_content('パスワードを入力してください')
            end

            it "パスワード（確認）がない" do
                visit "users/new"
                fill_in 'ユーザー名', with: @user.name
                fill_in 'メールアドレス', with: @user.email
                fill_in 'パスワード', with: @user.password
                click_on 'アカウントを作成'
                expect(page).to have_content('パスワード(確認)とパスワードの入力が一致しません')
            end
        end
    end

    describe 'ログイン' do 
        before do
            @user = create(:user)
        end
        
        it '表示されること' do
            visit root_path
            expect(page).to have_content('メールアドレス')
        end

        it 'ログインできること' do
            visit root_path
            fill_in 'メールアドレス', with: @user.email
            fill_in 'パスワード', with: @user.password
            click_button 'ログイン'
            expect(page).to have_content(@user.name)
        end

        it 'ログアウトできること' do
            visit root_path
            fill_in 'メールアドレス', with: @user.email
            fill_in 'パスワード', with: @user.password
            click_button 'ログイン'
            click_on 'ログアウト'
            expect(page).to have_content('メールアドレス')
        end
    end

end

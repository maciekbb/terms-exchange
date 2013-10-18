module LoginMacros
    def user_login
        @user ||= FactoryGirl.create(:user)
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        click_on 'Sign in'
    end

    def current_user
      @user
    end
end
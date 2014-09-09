require 'rails_helper'

feature 'User browsing the website' do
  
  context 'on homepage' do
    
    it 'sees a login link' do
      visit root_path
      expect(page).to have_button "Sign in"
    end

    it 'sees a SignUp link' do
      visit root_path
      expect(page).to have_content "Sign up"
    end

    it 'can login' do
      @user = User.create!(email: "Rob@rob.com",
                           password: "robrob",
                           password_confirmation: "robrob")
      visit users_backdoor_path(user_id: @user.id)

      expect(page).to have_content "log out"
    end

# pending on Modal testing- can't test right now
    xit 'can SignUp as a new user' do
    	visit root_path
    	click_button "Sign up"
    	fill_in 'Email', with: 'tom@tom.com'
    	find('#pass').set 'tom123'
    	fill_in 'Password confirmation', with: 'tom123'
    	click_button 'Sign up'
    	visit root_path
    	expect(page).to have_content "log out"
    end
  end
end



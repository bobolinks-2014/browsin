require 'rails_helper'

feature 'User browsing the website' do
  
  context 'on homepage' do
    
    it 'should see a login link' do
      visit root_path
      assert page.has_button?("Sign in"), "sign in button does not exit"
    end

    it 'should see a sign up link' do
      visit root_path
      assert page.has_content?("Sign up"), "sign up link does not exist"
    end

    it 'should be able to login' do
      @user = User.create!(email: "Rob@rob.com",
                           password: "robrob",
                           password_confirmation: "robrob",
                           service_list: "hbo")
      visit users_backdoor_path(user_id: @user.id)
      assert page.has_content?("log out"), "log out button does not exist"
    end

    # can only test if sign up form is created or selenium is installed

    # xit 'can click play button for top 25 results', :js => true do
    #   @media = Media.create!(imdb_id: "123test", genre_list: "drama", service_list: "netflix", platform_list: "movie", actor_list: "John Wayne", status_list: "show", run_time: 55, synopsis: "A ruthless cowboy moves to a street with a lawless group of characters", title: "Seseame Street", rating: 99)
    #   @user = User.create!(email: "Rob@rob.com",
    #                        password: "robrob",
    #                        password_confirmation: "robrob")
    #   visit users_backdoor_path(user_id: @user.id)
    #   page.save_screenshot("~/Desktop/screenshot.png", full: true)
    #   page.find('.button').click
    #   # save_and_open_page
    #   expect(page).to have_content "#{@media.title}"
    # end

    # it 'should be able to sign up as a new user' do
    # 	visit root_path
    # 	click_button "Sign up"
    # 	fill_in 'Email', with: 'tom@tom.com'
    # 	find('#pass').set 'tom123'
    # 	fill_in 'Password confirmation', with: 'tom123'
    #   find(:css, '#netflixBox').set true
    #   find(:css, '#hboBox').set true
    #   find('#sign-up-submit.btn').click
    # 	# click_button 'Sign up'
    # 	visit root_path
    #   assert page.has_content?("log out"), "log out button does not exist"
    # end
  end
end



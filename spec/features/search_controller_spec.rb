require 'rails_helper'

feature 'User browsing the website' do
  
  context 'on homepage' do

    xit 'can click play button for top 25 results', :js => true do
  		@media = Media.create!(imdb_id: "123test", genre_list: "drama", service_list: "netflix", platform_list: "movie", actor_list: "John Wayne", status_list: "show", run_time: 55, synopsis: "A ruthless cowboy moves to a street with a lawless group of characters", title: "Seseame Street", rating: 99)
      @user = User.create!(email: "Rob@rob.com",
                           password: "robrob",
                           password_confirmation: "robrob")

      visit users_backdoor_path(user_id: @user.id)
      page.save_screenshot("~/Desktop/screenshot.png", full: true)
      page.find('.button').click
      # save_and_open_page
      expect(page).to have_content "#{@media.title}"
    end

    it 'can use serach' do
      @user = User.create!(email: "Rob@rob.com",
                           password: "robrob",
                           password_confirmation: "robrob")
      visit users_backdoor_path(user_id: @user.id)
      expect(page).to have_content "Rob@rob.com"
    end
  end
end
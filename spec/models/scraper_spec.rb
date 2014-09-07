require 'rails_helper'

RSpec.describe Scraper, :type => :model do
	let(:media_file){['Derek: Season 2 (Trailer)', 'Hemlock Grove: Season 2 (Trailer)', 'Hemlock Grove: Season 2 (Trailer)', ]}

	it 'should return a list of titles without punctuation or seasons' do 
		expect(Scraper.clean_media(media_file)).to eq(['Derek', 'Hemlock Grove'])
	end

	it 'should return an array of titles' do 
		expect(Scraper.clean_media(media_file)).to be_a(Array)
	end

	it 'should remove duplicate titles' do
		expect(Scraper.clean_media(media_file)).to eq(['Derek', 'Hemlock Grove'])
	end

end

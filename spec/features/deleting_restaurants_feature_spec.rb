require 'rails_helper'

describe 'deleting restaurants' do

  context 'logged out' do
    before do
        Restaurant.create name: 'Satay House', cuisine: 'Malaysian'
    end    
    it 'should not be able to delete restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Satay House'
      expect(page).not_to have_link 'Delete'
    end
  end

  context 'logged in as the restaurant creator' do
    before do
      user = User.create email: 'hello@hello.com', password: '12345678', password_confirmation: '12345678'
      login_as user
      Restaurant.create name: 'Satay House', cuisine: 'Malaysian'
    end

    it 'should be able to delete restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'Satay House'
      expect(page).to have_link 'Delete'
    end
  end

  context 'logged in as another user' do
    before do
      alex = User.create email: 'hello@hello.com', password: '12345678', password_confirmation: '12345678'
      faezrah = User.create email: 'hello@helloworld.com', password: '12345678', password_confirmation: '12345678'
      login_as alex

      # faezrah.restaurant.create(name: 'Satay House', cuisine: 'Malaysian')
      Restaurant.create name: 'Satay House', cuisine: 'Malaysian', user: faezrah
    end

    it 'should not be able to delete restaurant' do
      visit '/restaurants'
      click_link 'Delete'
      expect(page).to have_content 'Not your restaurant!'
    end
  end
end
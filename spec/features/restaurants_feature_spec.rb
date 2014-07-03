require 'rails_helper'

describe 'restaurants listing page' do
  context 'no restaurants' do
    it 'tells me there a no restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
    end
  end

  context 'are restaurants' do
    before do
      Restaurant.create(name: 'Ledbury', cuisine: 'French')
    end
    it 'should show the restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'Ledbury'
    end
  end
end

describe 'restaurant creation form' do

  context 'logged out' do
    it 'should redirect user to sign in page' do 
      visit '/restaurants'
      click_link 'Create Restaurant'
      expect(page).to have_content 'Sign in'
    end
  end

  context 'logged in' do
    before do
      user = User.create email: 'hello@hello.com', password: '12345678', password_confirmation: '12345678'
      login_as user
    end
    
    context 'input is valid' do
      it 'should be able to create a restaurant' do
        visit '/restaurants/new'
        fill_in 'Name', with: 'Burger King'
        fill_in 'Cuisine', with: 'Fast Food'
        click_button 'Create Restaurant'
        expect(current_path).to eq '/restaurants'
        expect(page).to have_content 'Burger King (Fast Food)'
      end
    end

    context 'input is not valid' do
      it 'should be able to create a restaurant' do
        visit '/restaurants/new'
        fill_in 'Name', with: 'Burger King'
        fill_in 'Cuisine', with: 'ff'
        click_button 'Create Restaurant'
        expect(current_path).to eq '/restaurants'
        expect(page).to have_content 'Errors'
      end
    end
  end
end

describe 'restaurant editing and deleting' do
  before {Restaurant.create name: 'KFC', cuisine: 'Chicken'}

  context 'logged out' do
    it 'should not be able to edit a restaurant' do
      visit '/restaurants'
      expect(page).not_to have_link 'Edit'
    end

    it 'should not be able to delete a restaurant' do
      visit '/restaurants'
      expect(page).not_to have_link 'Delete'
    end
  end

  context 'logged in' do
    before do
      user = User.create email: 'hello@hello.com', password: '12345678', password_confirmation: '12345678'
      login_as user
    end

    it 'should be able to edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Cuisine', with: 'Fast Food'
      click_button 'Update Restaurant'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Fast Food'
    end

    it 'should be able to delete a restaurant' do
      visit '/restaurants'
      click_link 'Delete'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Successfully deleted KFC'
    end
  end
end   
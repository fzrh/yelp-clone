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
      Restaurant.create(name: 'Ledbury')
    end
    it 'should show the restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'Ledbury'
    end
  end
end

describe 'restaurant creation form' do
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
      expect(page).to have_content 'errors'
      expect(page).to have_content 'Burger King (ff)'
    end
  end
end

describe 'restaurant edit form' do
  before {Restaurant.create name: 'KFC'}
  it 'should be able to edit a restaurant' do
    visit '/restaurants'
    click_link 'Edit'
    fill_in 'Name', with: 'Kentucky Fried Chicken'
    click_button 'Update Restaurant'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'Kentucky Fried Chicken'
  end
end   

describe 'restaurant delete' do
  before {Restaurant.create name: 'KFC'}
  it 'should be able to delete a restaurant' do
    visit '/restaurants'
    click_link 'Delete'
    expect(current_path).to eq '/restaurants'
    # expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Successfully deleted KFC'
  end
end   
require 'spec_helper'

feature 'Homepage' do
  before { visit root_path }
  scenario 'displays the correct title' do
    expect(page).to have_css 'title', text: 'Happybit.eu Blog', visible: false
  end

  scenario 'displays the sign in link' do
   #  expect(page).to have_css '.nav li a', text: 'Sign In'
    expect(page).to have_css '//*[@id="wrap"]/div[1]/div/div[2]/ul[2]/li/a', text: 'Sign In'
  end
end

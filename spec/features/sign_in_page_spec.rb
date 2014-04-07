require 'spec_helper'

feature "Sign In page" do
  before do
    visit login_path
  end
  
  scenario 'shows the sign in form' do
    expect(page).to have_css '#wrap > div.container > div > form', text: 'Email'
  end

  scenario 'logins successfully' do
    user = User.create(username: 'testuser', email: 'testuser@example.com', password: 'secret', password_confirmation: 'secret')
    fill_in :email, with: "testuser@example.com"
    fill_in 'session_password', with: "secret"
    click_button 'Sign In'
    
    expect(page).to have_css 'title', text: 'Happybit.eu Blog', visible: false
    expect(page).to have_css '.alert-success', text: /You have signed in as testuser/ , visible: false
    user.destroy
  end
end


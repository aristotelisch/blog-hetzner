require 'spec_helper'

feature "Sign In page" do
  before do
    visit login_path
  end
  it 'shows the sign in form' do
    expect(page).to have_css '#wrap > div.container > div > form', text: 'Email'
  end
end

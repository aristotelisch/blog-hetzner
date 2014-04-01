require 'spec_helper'

describe 'Homepage' do
  before do
    visit root_path
  end
  it 'displays the correct title' do
    expect(page).to have_css 'title', text: 'Happybit.eu Blog', visible: false
  end

  it 'displays the sign in link' do
    expect(page).to have_css '.nav li a', text: 'Sign In'
  end
end

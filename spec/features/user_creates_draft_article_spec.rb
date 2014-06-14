require 'spec_helper'

# Feature: Create draft articles
#   As an author
#   In order to improve the quality and privacy of my articles
#   I want to create a draft article

feature "Create draft articles" do
  # Scenario: Edit an article as draft
  #   Given I am logged in
  #     And I edit an article
  #     Then I should see 'make draft'
  #
  before do
    user = User.create(username: 'testuser', email: 'testuser@example.com', password: 'secret', password_confirmation: 'secret')
    article = user.articles.create(title: 'A draft article', body: 'draft body content')
    visit login_path
    fill_in :email, with: "testuser@example.com"
    fill_in 'session_password', with: "secret"
    click_button 'Sign In'
    visit article_path(article.id)
  end

  # scenario "I should see make draft on edit article page" do
  scenario "appears 'make draft' on edit article page" do
    click_on "Edit"
    expect(page).to have_button "Make Draft"
  end

  scenario "clicking 'Make Draft' saves article but it is not publicly visible" do
    click_on "Edit"
    click_on "Make Draft"
    save_and_open_page

    expect(page).to have_css 'h1', 'Editing article'
    expect(page).to have_css '#status', 'Draft'
  end

end


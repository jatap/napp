# Feature: English frontend navigation links
#   As a visitor
#   I want to see navigation links
#   So I can find home, about, sign in and sign up
feature 'Frontend navigation links in english', :custom__frontend_devise do
  before :each do
    I18n.default_locale = :en
    I18n.locale         = :en
    visit root_en_path
  end

  scenario 'shows home li text' do
    expect(page).to have_selector 'li', text: 'Home'
  end

  scenario 'shows about link' do
    expect(page).to have_link 'About'
  end

  scenario 'shows spanish language selector link' do
    expect(page).to have_link 'ES'
  end

  scenario 'shows english language selector span' do
    expect(page).to have_selector 'span', text: 'EN'
  end

  scenario 'shows sign in link' do
    expect(page).to have_link 'user-login'
  end

  scenario 'shows sign up link' do
    expect(page).to have_link 'user-register'
  end
end

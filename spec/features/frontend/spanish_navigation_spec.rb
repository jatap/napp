# Feature: Spanish frontend navigation links
#   As a visitor
#   I want to see navigation links
#   So I can find home, about, sign in and sign up
feature 'Frontend navigation links in spanish', :custom__frontend_devise do
  before :each do
    I18n.default_locale = :es
    I18n.locale         = :es
    visit root_es_path
  end

  scenario 'shows home li text' do
    expect(page).to have_selector 'li', text: 'Portada'
  end

  scenario 'shows about link' do
    expect(page).to have_link 'Acerca de'
  end

  scenario 'shows english language selector link' do
    expect(page).to have_link 'EN'
  end

  scenario 'shows spanish language selector span' do
    expect(page).to have_selector 'span', text: 'ES'
  end

  scenario 'shows sign in link' do
    expect(page).to have_link 'user-login'
  end

  scenario 'shows sign up link' do
    expect(page).to have_link 'user-register'
  end
end

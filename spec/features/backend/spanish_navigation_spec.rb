# Feature: Spanish backend navigation links
#   As a logged user in available locales
#   I want to see navigation links
#   So I can find website, jobs, languages, edit user and sign out
feature 'Backend navigation links in spanish', :custom_backend_devise do
  before :each do
    I18n.default_locale = :es
    I18n.locale         = :es
    admin_user = create(:user_with_admin_role)
    login_as(admin_user)
    visit backend_dashboard_es_path
  end

  after :all do
    Warden.test_reset!
  end

  scenario 'shows website link' do
    expect(page).to have_link 'Sitio web'
  end

  scenario 'shows jobs link' do
    expect(page).to have_link 'Trabajos'
  end

  scenario 'shows english language selector link' do
    expect(page).to have_link 'EN'
  end

  scenario 'shows spanish language selector span' do
    expect(page).to have_selector 'span', text: 'ES'
  end

  scenario 'shows edit user link' do
    expect(page).to have_link 'user-edit'
  end

  scenario 'shows sign out link' do
    expect(page).to have_link 'user-logout'
  end
end

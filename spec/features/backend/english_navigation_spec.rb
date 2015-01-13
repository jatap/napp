# Feature: English backend navigation links
#   As a logged user in available locales
#   I want to see navigation links
#   So I can find website, jobs, languages, edit user and sign out
feature 'Backend navigation links in english', :custom_backend_devise do
  before :each do
    I18n.default_locale = :en
    I18n.locale         = :en
    admin_user = create(:user_with_admin_role)
    login_as(admin_user)
    visit backend_dashboard_en_path
  end

  after :all do
    Warden.test_reset!
  end

  scenario 'shows website link' do
    expect(page).to have_link 'Website'
  end

  scenario 'shows jobs link' do
    expect(page).to have_link 'Jobs'
  end

  scenario 'shows spanish language selector link' do
    expect(page).to have_link 'ES'
  end

  scenario 'shows english language selector span' do
    expect(page).to have_selector 'span', text: 'EN'
  end

  scenario 'shows edit user link' do
    expect(page).to have_link 'user-edit'
  end

  scenario 'shows sign out link' do
    expect(page).to have_link 'user-logout'
  end
end

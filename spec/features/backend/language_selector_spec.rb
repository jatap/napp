# Feature: Backend language selector
#   As a logged user
#   I want to change language
#   So I can see links in appropiate language
feature 'Backend language selector', :custom_backend_devise do
  before :each do
    admin_user = create(:user_with_admin_role)
    login_as(admin_user)
  end

  after :each do
    Warden.test_reset!
  end

  scenario 'change locale when current locale is active' do
    I18n.default_locale = :es
    I18n.locale         = :es
    visit backend_dashboard_es_path
    click_link 'backend-language-en'
    expect(current_path).to eq backend_dashboard_en_path
  end

  scenario 'change locale when default locale is on path' do
    I18n.default_locale = :en
    I18n.locale         = :en
    visit users_en_path
    click_link 'backend-language-es'
    expect(current_path).to eq users_es_path
  end

  scenario 'change locale when default locale is on root path' do
    I18n.default_locale = :en
    I18n.locale         = :en
    visit new_user_en_path
    click_link 'backend-language-es'
    expect(current_path).to eq new_user_es_path
  end
end

# Feature: Frontend language selector
#   As a logged user
#   I want to change language
#   So I can see links in appropiate language
feature 'Frontend language selector', :custom_backend_devise do
  scenario 'change locale when current locale is active' do
    I18n.default_locale = :es
    I18n.locale         = :es
    visit frontend_about_es_path
    click_link 'frontend-language-en'
    expect(current_path).to eq frontend_about_en_path
  end

  scenario 'change locale when default locale is on path' do
    I18n.default_locale = :en
    I18n.locale         = :en
    visit frontend_about_en_path
    click_link 'frontend-language-es'
    expect(current_path).to eq frontend_about_es_path
  end

  scenario 'change locale when default locale is on root path' do
    I18n.default_locale = :en
    I18n.locale         = :en
    visit root_en_path
    click_link 'frontend-language-es'
    expect(current_path).to eq root_es_path
  end
end

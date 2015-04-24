feature 'Given an users list' do
  let(:admin_user) { create :user_with_admin_role }

  before :each do
    I18n.default_locale = :en
    I18n.locale         = :en
    login_as admin_user
    visit users_en_path
  end

  scenario 'loads data via ajax', js: true do
    expect(page).to have_content admin_user.fullname
    expect(page).to have_content '1/1'
  end
end

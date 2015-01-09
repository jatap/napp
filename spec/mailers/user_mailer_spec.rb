require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  context 'with UserMailer' do
    let(:full_subject) { t('signup.notification.subject', user: 'Administrator') }
    let(:mail) { UserMailer.signup_notification(create(:user_with_admin_role)) }

    it 'renders the headers' do
      expect(mail.content_type).to start_with('multipart/alternative')
    end
  end
end

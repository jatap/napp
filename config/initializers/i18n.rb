module I18n
  attr_accessor :full_locale

  def self.full_locale
    case
      when (locale == :es) then 'es-ES'
      when (locale == :en) then 'en-US'
    end
  end
end

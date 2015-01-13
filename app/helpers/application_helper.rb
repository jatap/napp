# AplicationHelper Class.
#
# @author julio.antunez.tarin@gmail.com
module ApplicationHelper
  # Create switch locale links (frontend).
  #
  # @note Deprecated use of link_to_unless_current
  #
  # @return [String] the HTML result with switch locale links.
  def switch_locale_frontend
    html = ''

    locales.each_with_index do |locale, _index|
      locale_string = locale.to_s
      link = link_to(locale_string.upcase, { locale: locale_string },
                     data: { no_turbolink: true },
                     id: "frontend-language-#{locale_string.downcase}")
      link = link.gsub(/\/(\?locale=)/, '/')

      if current_locale? locale
        html += "<li class='active'>"
        html += "<span class='current-locale'>#{locale_string.upcase}</span>"
      elsif default_locale_on_path?(locale) ||
            default_locale_on_root_path?(locale)
        html += '<li>'
        html += link.gsub(%r{/(#{locales.join('|')})/?}, '/')
      else
        html += '<li>'
        html += link
      end

      html += '</li>'
    end
    raw(html)
  end

  # Create switch locale links (backend).
  #
  # @note Deprecated use of link_to_unless_current
  #
  # @return [String] the HTML result with switch locale links.
  def switch_locale_backend
    html = ''

    locales.each_with_index do |locale, _index|
      locale_string = locale.to_s
      link = link_to(locale_string.upcase, { locale: locale_string },
                     data: { no_turbolink: true },
                     id: "backend-language-#{locale_string.downcase}")
      link = link.gsub(/\/(\?locale=)/, '/')

      if current_locale? locale
        html += "<li class='current-locale'>"
        html += "<span class='current-locale'>#{locale_string.upcase}</span>"
      elsif default_locale_on_path?(locale) ||
            default_locale_on_root_path?(locale)
        html += '<li>'
        html += link.gsub(%r{/(#{locales.join('|')})/}, '/')
      else
        html += '<li>'
        html += link
      end

      html += '</li>'
    end
    raw(html)
  end

  # Set root path with locale included (exclude default locale).
  #
  # @return [void]
  def locale_root_path
    I18n.locale == I18n.default_locale ? '/' : "/#{I18n.locale}"
  end

  # Check if requested locale is current locale.
  #
  # @param locale [Symbol] locale
  # @return [Boolean] the check result.
  def current_locale?(locale)
    locale == I18n.locale
  end
  private :current_locale?

  # Available locales.
  #
  # @return [Array] the configured available locales
  def locales
    I18n.available_locales
  end
  private :locales

  # Check if requested locale is available.
  #
  # @param (see #current_locale?)
  # @return (see #current_locale?)
  def in_locales?(locale)
    locales.include? locale
  end
  private :in_locales?

  # Check if requested locale is default locale and is included in path.
  #
  # @param (see #current_locale?)
  # @return (see #current_locale?)
  def default_locale_on_path?(locale)
    in_locales?(locale) && default_locale?(locale) && locale_on_path?(locale)
  end
  private :default_locale_on_path?

  # Check if requested locale is default locale and is included in root path.
  #
  # @param (see #current_locale?)
  # @return (see #current_locale?)
  def default_locale_on_root_path?(locale)
    in_locales?(locale) && default_locale?(locale) \
      && locale_on_root_path?(locale)
  end
  private :default_locale_on_root_path?

  # Check if requested locale is included in root path.
  #
  # @param (see #current_locale?)
  # @return (see #current_locale?)
  def locale_on_root_path?(locale)
    in_locales?(locale) && (request.original_fullpath.size == 3)
  end
  private :locale_on_root_path?

  # Check if requested locale is included in path.
  #
  # @param (see #current_locale?)
  # @return (see #current_locale?)
  def locale_on_path?(locale)
    in_locales?(locale) && (request.original_fullpath.size > 3)
  end
  private :locale_on_path?

  # Check if requested locale is default locale.
  #
  # @param (see #current_locale?)
  # @return (see #current_locale?)
  def default_locale?(locale)
    in_locales?(locale) && (locale == I18n.default_locale)
  end
  private :default_locale?
end

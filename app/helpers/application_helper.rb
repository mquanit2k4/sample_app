module ApplicationHelper
  def full_title page_title = ""
    base_title = t("static_pages.home.title")
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  # Language selector helper
  def language_links
    links = []
    I18n.available_locales.each do |locale|
      links << if locale == I18n.locale
                 content_tag(:span, locale_name(locale),
                             class: "current-locale")
               else
                 link_to(locale_name(locale), url_for(locale:))
               end
    end
    safe_join(links, " | ".html_safe)
  end

  private

  def locale_name locale
    t("locales.#{locale}", default: locale.to_s.upcase)
  end
end

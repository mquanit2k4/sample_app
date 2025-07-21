module UsersHelper
  def gravatar_for user
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?d=identicon&s=80"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def gender_options selected = nil
    options_for_select(
      [
        [t("users.gender.female"), :female],
        [t("users.gender.male"), :male],
        [t("users.gender.other"), :other]
      ],
      selected
    )
  end
end

class WinnerMailer < ApplicationMailer
  default from: 'encheresPokemon.com'
  layout 'mailer'


  def winner_mailer(user, article)
    @user = user
    mail(
      to: @user.email,
      subject: t("winning_message_title"),
      content_type: "text/html"  )
  end
end

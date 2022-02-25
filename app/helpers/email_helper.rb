module EmailHelper
  def email_logo_tag(image, **options)
    attachments[image] = File.read(Rails.root.join("app/assets/images/#{image}"))
    image_tag attachments[image].url, **options
  end

  def email_image_tag(image, **options)
    attachments[image] = File.read(Rails.root.join("public#{image}"))
    image_tag attachments[image].url, **options
  end

  def universal_time_format(time)
    time.strftime("%d %b %Y, %H:%M")
  end

  def published_time(article)
    return "Not published yet" unless article.published_at

    return "Edit: #{universal_time_format(article.published_at)}" if article.edited?

    universal_time_format(article.published_at)
  end

  def article_avatar_small_preview(article)
    return article_admin_card_image(asset_path("no-image.png")) if article.avatar.url.nil?

    article_admin_card_image(article.avatar.small_preview.url)
  end

  def article_admin_card_image(image_url)
    image_tag(image_url, class: "card-img-top img-size", alt: "...")
  end
end

module ArticleHelper
  def article_avatar_small_preview(article)
    return article_admin_card_image(asset_path('no-image.png')) if article.avatar.url.nil?

    article_admin_card_image(article.avatar.small_preview.url)
  end

  def article_avatar(article)
    return if article.avatar.url.nil? || article.avatar_disable?

    image_tag(article.avatar.url, class: 'mb-3', alt: '...')
  end

  def article_admin_card_image(image_url)
    image_tag(image_url, class: 'card-img-top img-size', alt: '...')
  end
end

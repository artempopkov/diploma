module ArticleHelper
  def toggle_important(article)
    if article.important?
      link_to toggle_important_admin_article_path(article, important: false), class: 'btn-mark', method: :patch, remote: :true do
        'Unmark'
      end
    else
      link_to toggle_important_admin_article_path(article, important: true), class: 'btn-mark', method: :patch, remote: :true do
        'Mark'
      end
    end
  end

  def article_avatar_small_preview(article)
    return article_admin_card_image(asset_path('no-image.png')) if article.avatar.url.nil?

    article_admin_card_image(article.avatar.small_preview.url)
  end

  def article_avatar(article)
    return if article.avatar_absent_or_disabled?

    image_tag(article.avatar.url, class: 'mb-3', alt: '...')
  end

  def article_admin_card_image(image_url)
    image_tag(image_url, class: 'card-img-top img-size', alt: '...')
  end

  def universal_time_format(time)
    time.strftime("%d %b %Y, %H:%M")
  end
end

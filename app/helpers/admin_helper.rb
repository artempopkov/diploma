module AdminHelper
  def article_avatar_preview(article)
    if article.avatar.present?
      image_tag(article.avatar.index_admin.url, class: 'card-img-top img-size', alt: '...')
    else
      image_tag(asset_path('no-image.png'), class: 'card-img-top img-size', alt: '...')
    end
  end

  def article_avatar(article)
    return unless article.avatar.present? && !article.avatar_disable
    image_tag(article.avatar.url, class: 'mb-3', alt: '...')
  end
end

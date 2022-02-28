module ArticleHelper
  def published_time_label(article)
    utc_published_time = utc(article.published_at)
    return "Изменена: #{utc_published_time}" if article.edited?

    utc_published_time
  end

  def like_heart(article)
    return content_tag(:i, "", class: "icon-heart mr-5") unless current_user

    if current_user.liked?(article)
      link_to "", like_article_path(article, "unlike"), class: "icon-heart-broken mr-5", method: :put, remote: true
    else
      link_to "", like_article_path(article, "like"), class: "icon-heart mr-5", method: :put, remote: true
    end
  end

  def render_article_preview(article, index)
    return render "shared/articles/big_preview_card", article: article if index.zero?

    render "shared/articles/medium_preview_card", article: article
  end

  def toggle_important(article)
    if article.important?
      link_to toggle_important_admin_article_path(article, important: false), class: "btn-mark", method: :patch, remote: :true do
        "Убрать из важных"
      end
    else
      link_to toggle_important_admin_article_path(article, important: true), class: "btn-mark", method: :patch, remote: :true do
        "Добавить в важные"
      end
    end
  end

  def article_avatar(article)
    return if article.avatar_absent_or_disabled?

    image_tag(article.avatar.url, alt: "...")
  end

  def article_avatar_important_preview(article)
    return image_tag("no-image.png", alt: "...") if article.avatar.url.nil?

    image_tag(article.avatar.small_preview.url)
  end

  def article_avatar(article)
    return if article.avatar_absent_or_disabled?
    image_tag(article.avatar.url, alt: "...")
  end

  def article_avatar_preview(article)
    return image_tag("no-image.png", alt: "...") if article.avatar_absent_or_disabled?

    image_tag(article.avatar.url, alt: "...")
  end

  def article_avatar_big_preview(article)
    return image_tag("no-image.png", alt: "...") unless article.avatar.url

    image_tag(article.avatar.big_preview.url, alt: "...")
  end

  def article_avatar_small_preview(article)
    return image_tag("no-image.png", alt: "...") unless article.avatar.url

    image_tag(article.avatar.small_preview.url, alt: "...")
  end

  def utc(time)
    time.strftime("%d %b %Y, %H:%M")
  end
end

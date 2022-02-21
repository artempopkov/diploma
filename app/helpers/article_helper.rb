module ArticleHelper
  def published_time_label(article)
    utc_published_time = utc(article.published_at)
    return "Edit: #{utc_published_time}" if article.edited?

    utc_published_time
  end

  def toggle_important(article)
    if article.important?
      link_to toggle_important_admin_article_path(article, important: false), class: "btn-mark", method: :patch, remote: :true do
        "Unmark"
      end
    else
      link_to toggle_important_admin_article_path(article, important: true), class: "btn-mark", method: :patch, remote: :true do
        "Mark"
      end
    end
  end

  def article_avatar_link(article)
    link_to article do
      article_avatar(article)
    end
  end

  def article_avatar_big_preview_link(article)
    link_to article, class: "img-link" do
      article_avatar_big_preview(article)
    end
  end

  def article_avatar_small_preview_link(article)
    link_to article do
      article_avatar_small_preview(article)
    end
  end

  def article_avatar(article)
    return image_tag(asset_path("no-image.png"), alt: "...") if article.avatar_absent_or_disabled?

    image_tag(article.avatar.url, alt: "...")
  end

  def article_avatar_big_preview(article)
    return image_tag(asset_path("no-image.png"), alt: "...") if article.avatar_absent_or_disabled?

    image_tag(article.avatar.big_preview.url, alt: "...")
  end

  def article_avatar_small_preview(article)
    return image_tag(asset_path("no-image.png"), alt: "...") if article.avatar_absent_or_disabled?

    image_tag(article.avatar.small_preview.url, alt: "...")
  end

  def utc(time)
    time.strftime("%d %b %Y, %H:%M")
  end
end

module ArticleHelper
  def published_time(article)
    return "Not published yet" unless article.published_at

    return "Edit: #{universal_time_format(article.published_at)}" if article.edited?

    universal_time_format(article.published_at)
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

  def comment_form(article)
    return render "comments/form", article: article if current_user

    content_tag(:div, class: "alert alert-danger") do
      link_to "Please login to comment", new_user_session_path
    end
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

  def article_avatar_small_preview(article)
    return article_admin_card_image(asset_path("no-image.png")) if article.avatar.url.nil?

    article_admin_card_image(article.avatar.small_preview.url)
  end

  def article_avatar(article)
    return if article.avatar_absent_or_disabled?

    image_tag(article.avatar.url, class: "mb-3", alt: "...")
  end

  def article_admin_card_image(image_url)
    image_tag(image_url, class: "card-img-top img-size", alt: "...")
  end

  def universal_time_format(time)
    time.strftime("%d %b %Y, %H:%M")
  end
end

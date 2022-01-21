module ArticleHelper
  def published_time(article)
    return 'Not published yet' unless article.published_at

    return "Edit: #{universal_time_format(article.published_at)}" if article.edited?

    universal_time_format(article.published_at)
  end

  def like_heart(article)
    if current_user.liked?(article)
      link_to '', like_article_path(article, 'unlike'), class: 'icon-heart-broken mr-5', method: :put, remote: true
    else
      link_to '', like_article_path(article, 'like'), class: 'icon-heart mr-5', method: :put, remote: true
    end
  end

  def universal_time_format(time)
    time.strftime('%d %b %Y, %H:%M')
  end
end

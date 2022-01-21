module ArticleHelper
  def published_time(article)
    return 'Not published yet' unless article.published_at

    return "Edit: #{universal_time_format(article.published_at)}" if article.edited?

    universal_time_format(article.published_at)
  end

  def universal_time_format(time)
    time.strftime('%d %b %Y, %H:%M')
  end
end

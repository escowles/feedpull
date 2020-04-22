module ApplicationHelper
  def github_url(name)
    "https://github.com/#{name}/"
  end

  def format_date(date_str)
    DateTime.parse(date_str).strftime("%m/%d %I:%M%P")
  end

  def is_pr?(url)
    url.include?("/pull/")
  end

  def icon_for(state, url)
    return "pr_#{state}" if is_pr?(url)
    "issue_#{state}"
  end
end

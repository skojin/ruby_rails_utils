module TimeRange
  extend self

  def today
    now = Time.current
    now.beginning_of_day..now.end_of_day
  end

  def yesterday
    yesterday = 1.day.ago
    yesterday.beginning_of_day..yesterday.end_of_day
  end

  def month(date = Time.current)
    date = date.to_time.beginning_of_month
    date..date.end_of_month
  end

  def day(date = Time.current)
    date = date.to_time.beginning_of_day
    date..date.end_of_day
  end
end
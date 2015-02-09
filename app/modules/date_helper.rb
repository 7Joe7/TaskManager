module DateHelper

  SECONDS_PER_DAY = 86400
  SECONDS_PER_HOUR = 3600
  NOW_TIME = Time.now

  def get_time_plus_days(number_of_days)
    Time.now + SECONDS_PER_DAY * number_of_days
  end

  def get_time_plus_hours(number_of_hours)
    Time.now + SECONDS_PER_HOUR * number_of_hours
  end

  def get_time(attrs)
    now_time = Time.now
    Time.new(attrs[:year] || now_time.year, attrs[:month] || now_time.month, attrs[:day] || now_time.day, attrs[:hour] || now_time.hour, attrs[:minute] || now_time.min, attrs[:second])
  end

  def get_save_time(value)
    value && Time.parse(value.to_s)
  end
end
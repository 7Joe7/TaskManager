require "#{File.dirname(__FILE__)}/model.rb"

class Project < Model

  STANDARD_PARAMETERS = [:area, :done, :state, :vision]
  DATE_PARAMETERS = [:date_of_accomplishment]
  ARRAY_PARAMETERS = [:tasks, :periods]
  INT_PARAMETERS = {ev: 0}
  DB_ADDRESS = "#{File.dirname('.')}/db/projects.json"

  def next_task

  end

  def add_period(period)
    periods << period
  end

  def add_task(task)
    tasks << task
  end

  def money_costs
    tasks.inject(:+) { |task| task.money_costs }
  end

  def work_needed
    tasks.inject(:+) { |task| task.work_needed }
  end
end
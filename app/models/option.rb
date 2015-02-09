require "#{File.dirname(__FILE__)}/model.rb"

class Option < Model

  STANDARD_PARAMETERS = [:area, :done, :decision]
  INT_PARAMETERS = {ev: 0}
  ARRAY_PARAMETERS = [:tasks]
  DB_ADDRESS = "#{File.dirname('.')}/db/options.json"

  def money_costs
    tasks.inject(:+) { |task| task.money_costs }
  end

  def work_needed
    tasks.inject(:+) { |task| task.work_needed }
  end
end
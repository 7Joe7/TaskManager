require "#{File.dirname(__FILE__)}/model.rb"

class Task < Model

  STANDARD_PARAMETERS = [:done, :available_after, :type]
  DATE_PARAMETERS = [:date_from, :date_of_accomplishment, :date_to, :alert, :time_of_impact]
  INT_PARAMETERS = {work_needed: nil, money_costs: 0, time: nil, utility: 0, area_coef: 1}
  DB_ADDRESS = "#{File.dirname('.')}/db/tasks.json"

  def initialize(attrs)
    attrs[:type] ||= TaskType::DO_IT
    super(attrs)
  end
end
require "#{File.dirname(__FILE__)}/modules/overall_helper.rb"

class TaskManager
  extend PrivateAttrAccessor
  extend ModelHelper
  include OverallHelper

  MODELS = [Task, Project, Option, Profile]

  private_attr_accessor *(MODELS.map { |klass| "#{klass}s".downcase.to_sym } << :actual_user)

  DOABLE_MODELS = [Task, Project]

  MODELS.each { |klass| setup_model(klass) }
  DOABLE_MODELS.each { |klass| add_doability(klass) }

  def initialize(user_name)
    MODELS.each { |klass| send("#{klass.to_s.downcase}s=", load_data(klass::DB_ADDRESS, klass)) }
    self.actual_user = find_profile_by_name(user_name)
  end

  def save
    MODELS.each { |klass| save_data(send("#{klass.to_s.downcase}s"), klass::DB_ADDRESS) }
  end

  def alerts
    tasks.find_all { |task| alert?(task) }
  end

  def get_klass(klass_name)
    MODELS.find { |klass| klass.to_s.downcase == klass_name }
  end
end
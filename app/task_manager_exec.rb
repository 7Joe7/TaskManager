require "#{File.dirname(__FILE__)}/task_manager_runner.rb"
require "#{File.dirname(__FILE__)}/task_manager.rb"


begin
  # task_manager_runner = TaskManagerRunner.new
  # task_manager_runner.start
  task_manager = TaskManager.new('Joe')
  task_manager.print_all_available_tasks
  task_manager.print_what_to_do
  # prevention vs creation
  # productivity - cleanliness, awakeness, clear mind, health
  # urgency
  # repetition
  # user interface - pages
  # conquered area - prevention x creation preferences
  # maximize effects to what moment?
  # to moment of death?
  # to infinity?
  # to end of the day?
  # produce x enhance production capability balance
  # utility at the end of the effect of the thing made
  # comparable with comparing also the time of efficiency
  # with repetition it is easy - time of the next repetition
  # project periods - period of effect also
  # compare `¸˘¬effect per hour
  # account for feelings - affection is a plus when working for productivity
  task_manager.save
rescue Exception => e
  p e
  puts e.backtrace
end
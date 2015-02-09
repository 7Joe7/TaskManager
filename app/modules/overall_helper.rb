# Dir.glob("#{File.dirname(__FILE__)}/*").each { |file| require file }
# Dir.glob("#{File.dirname('.')}/models/*").each { |file| require file }

require "#{File.dirname(__FILE__)}/files_helper.rb"
require "#{File.dirname(__FILE__)}/date_helper.rb"
require "#{File.dirname(__FILE__)}/task_type.rb"
require "#{File.dirname(__FILE__)}/data_helper.rb"
require "#{File.dirname(__FILE__)}/model_helper.rb"
require "#{File.dirname(__FILE__)}/private_attr_accessor.rb"
require "#{File.dirname(__FILE__)}/task_helper.rb"
require "#{File.dirname(__FILE__)}/option_helper.rb"
require "#{File.dirname(__FILE__)}/project_helper.rb"
require "#{File.dirname(__FILE__)}/printer_helper.rb"
require './models/project.rb'
require './models/task.rb'
require './models/option.rb'
require './models/profile.rb'
require 'json'
require 'date'
require 'time'

module OverallHelper
  include TaskHelper
  include FilesHelper
  include DateHelper
  include TaskType
  include DataHelper
  include OptionHelper
  include ProjectHelper
  include PrinterHelper

  BREAK_LINE = '-------------------------------------------------------------------------------------------------------------'

end
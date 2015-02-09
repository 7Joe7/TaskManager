require "#{File.dirname(__FILE__)}/model.rb"

class Profile < Model

  STANDARD_PARAMETERS = []
  ARRAY_PARAMETERS = [:areas]
  DATE_PARAMETERS = [:date_of_birth]
  INT_PARAMETERS = {hour_rate: 0, productivity: 0, annual_interest: 0}
  DB_ADDRESS = "#{File.dirname('.')}/db/profiles.json"

end
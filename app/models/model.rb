class Model

  MODEL_PARS = [:name, :description]
  STANDARD_PARAMETERS = []
  DATE_PARAMETERS = []
  INT_PARAMETERS = {}
  ARRAY_PARAMETERS = []

  def initialize(attrs)
    self.class.send(:attr_accessor, *self.class.get_parameters)
    self.class::ARRAY_PARAMETERS.each { |key| attrs[key] ||= [] }
    self.class::INT_PARAMETERS.each do |key, default|
      attrs[key] = attrs[key] ? attrs[key].to_i : default
      self.class.send(:define_method, "#{key}=") { |string| instance_variable_set("@#{key}", string.to_i) }
    end
    self.class::DATE_PARAMETERS.each { |key| attrs[key] = attrs[key] && Time.parse(attrs[key].to_s) }
    self.class.get_parameters.each { |key| send "#{key}=".to_sym, attrs[key] }
  end

  def to_s
    string = "Task: #{name}"
    description.to_s.empty? ? string : "#{string} - #{description}"
  end

  def to_hash
    params = {}
    self.class.get_parameters.each { |key| params[key] = send key unless key == :name }
    {name => params}
  end

  def self.get_parameters
    MODEL_PARS + self::STANDARD_PARAMETERS + self::DATE_PARAMETERS + self::INT_PARAMETERS.keys
  end
end
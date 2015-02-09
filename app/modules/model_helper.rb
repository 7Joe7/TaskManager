module ModelHelper

  def setup_model(klass)
    model = get_model(klass)
    define_method("find_#{model}_by_name") do |name|
      send("#{model}s").find { |entity| entity.name == name }
    end

    define_method("create_#{model}") do |attrs|
      new_entity = klass.new(attrs)
      send("#{model}s") << new_entity
      new_entity
    end

    define_method("delete_#{model}") do |entity|
      send("#{model}s").delete(entity)
    end

    define_method("modify_#{model}") do |entity, attrs|
      attrs.each { |key, value| entity.send("#{key}=".to_sym, value) }
    end

    define_method("get_available_#{model}s") do
      send("#{model}s").find_all { |entity| send("is_#{model}_available?", entity) }
    end

    define_method("print_all_available_#{model}s") do
      entities = send("get_available_#{model}s")
      entities.each { |entity| puts entity }
      puts self.class::BREAK_LINE
    end
  end

  def add_doability(klass)
    model = get_model(klass)
    define_method("set_#{model}_done") do |entity|
      entity.done = true
      entity.date_of_accomplishment = Time.now
    end
  end

  def get_model(klass)
    klass.to_s.downcase
  end
end
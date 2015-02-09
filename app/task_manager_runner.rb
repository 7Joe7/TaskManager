require "#{File.dirname(__FILE__)}/task_manager.rb"

class TaskManagerRunner
  extend PrivateAttrAccessor
  include DateHelper
  include TaskType

  private_attr_accessor :task_manager

  MESSAGES = {
      basic_message:
          'Tell me what to do - first letter stands for action, second for entity
actions: 0 - advice, 1 - create, 2 - modify, 3 - delete, 4 - set done, 8 - save, 9 - exit
entities: 0 - task, 1 - project, 2 - option:',
      changes_saved: 'Changes were saved.',
      alert: '
          !!! ALERT !!! %s, should be finished till: %s
',
      insert_parameter: 'Insert parameter %s: ',
      insert_parameters: 'Insert parameters:',
      insert_value: 'Insert %s value:',
  }

  def initialize
    self.task_manager = TaskManager.new('Joe')
  end

  def start
    process_input('0')
    loop do
      input = gets.chomp
      process_input(input)
    end
  end

  private

  def print_next
    puts
    puts
    puts '---------------------------------------------------------------------------------------------------------------'
    puts MESSAGES[:basic_message]
  end

  def process_input(input)
    if (action = get_action(input[0].to_i)) && (model = get_model(input[1].to_i))
      klass = task_manager.get_klass(model)
      case action
        when 'create_model'
          print_pars(klass) do |pars|
            action.sub!('model', model)
            task_manager.send(action.to_sym, pars)
          end
        when 'modify_model'
          print_entities(model, true) do |entity|
            print_pars(klass) do |pars|
              action.sub!('model', model)
              task_manager.send(action.to_sym, entity, pars)
            end
          end
        when 'delete_model'
          print_entities(model, false) do |entity|
            action.sub!('model', model)
            task_manager.send(action.to_sym, entity)
          end
        when 'set_model_done'
          print_entities(model, true) do |entity|
            action.sub!('model', model)
            task_manager.send(action.to_sym, entity)
          end
        else
      end
      print_next
    end
  end

  def get_action(input)
    case input
      when 0
        task_manager.alerts.each do |task|
          puts MESSAGES[:alert] % [task.name, task.date_to.strftime('%d.%m.%Y %H:%M')]
        end
        puts
        puts task_manager.tell_me_what_to_do.to_s
        print_next
      when 1
        'create_model'
      when 2
        'modify_model'
      when 3
        'delete_model'
      when 4
        'set_model_done'
      when 8
        task_manager.save
        puts MESSAGES[:changes_saved]
        print_next
      when 9
        exit
      else
        puts MESSAGES[:basic_message]
    end
  end

  def get_model(input)
    case input
      when 0
        'task'
      when 1
        'project'
      when 2
        'option'
      else
        puts MESSAGES[:basic_message]
    end
  end

  def print_entities(model, available)
    entities = if available
      task_manager.send("get_available_#{model}s")
    else
      task_manager.send("#{model}s")
    end
    print_list(entities, false, 1) { |index| yield entities[index] if entities[index] }
  end

  def print_list(list, print_process, per_line)
    list.each_with_index do |item, i|
      if i != 0 && i % per_line == 0
        puts
      else
        print '| ' unless i == 0
      end
      print "#{i} - #{item} "
    end
    puts print_process ? "\n#{list.size} - process\n#{list.size + 1} - cancel" : "\n#{list.size} - cancel"
    case (index = gets.chomp)
      when list.size.to_s
        return print_process && nil
      when (list.size + 1).to_s
        return false
      else
        yield index.to_i if block_given?
    end
  end

  def print_pars(klass)
    pars, par_values = klass.get_parameters, {}
    loop do
      puts MESSAGES[:insert_parameters]
      result = print_list(pars, true, 10) do |index|
        puts MESSAGES[:insert_value] % pars[index]
        value = gets.chomp
        par_values[pars[index]] = value
      end
      yield par_values if result.nil? && block_given?
      break unless result
    end
  end
end
module TaskHelper


  # @param [TaskStructure] task
  def get_final_task_value(task, interest, hour_rate)
    if task.time_of_impact
      ((task.utility * task.area_coef) / (1 + interest * task.time_of_impact)) - (task.money_costs + task.time * hour_rate)
    else
      task.utility * task.area_coef - (task.money_costs + task.time * hour_rate)
    end
  end

  # @param [Task] task
  # @param [Profile] profile
  def get_hour_rate_on_task(task, profile)
    (task.utility * task.area_coef - (task.money_costs)) / (task.work_needed ? task.work_needed / profile.productivity.to_f : task.time)
  end

  def is_task_available?(task)
    !task.done && (!task.date_from || task.date_from < self.class::NOW_TIME) && (!task.date_to || task.date_to > self.class::NOW_TIME) &&
        (!task.available_after || find_task_by_name(task.available_after).done) && task.type == TaskType::DO_IT
  end

  def alert?(task)
    !task.done && (((task.alert || task.date_to) && (task.alert || task.date_to) < self.class::NOW_TIME) ||
        task.type == TaskType::DECISION)
  end

  def tell_me_what_to_do
    get_available_tasks.max do |t1, t2|
      get_hour_rate_on_task(t1, actual_user) <=> get_hour_rate_on_task(t2, actual_user)
    end
  end
end
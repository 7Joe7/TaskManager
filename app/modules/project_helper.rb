module ProjectHelper

  def is_project_available?(project)
    !project.done
  end
end
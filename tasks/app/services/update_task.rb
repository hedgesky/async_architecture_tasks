class UpdateTask
  def initialize(task:, attributes:)
    @task = task
    @attributes = attributes
  end

  def call
    @task.assign_attributes(@attributes)
    assignee_changed = @task.assignee_id_changed?

    if @task.save
      NotifyAssignee.call(task: @task) if assignee_changed
      true
    else
      false
    end
  end
end

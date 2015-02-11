ActiveAdmin.register ProjectHistory do
  index do
    selectable_column
    column :id do |history|
      link_to history.id, admin_project_history_path(history)
    end
    column :project do |history|
      link_to history.project.name, admin_project_path(history.project)
    end
    column :field
    column :value
    column :created_at
    #column :updated_at
  end
end

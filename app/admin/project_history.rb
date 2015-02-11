ActiveAdmin.register ProjectHistory do
  actions :index

  index do
    selectable_column
    column :id
    column :project do |history|
      link_to history.project.name, admin_project_path(history.project)
    end
    column :field
    column :value
    column :created_at
  end
end

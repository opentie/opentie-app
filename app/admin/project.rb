ActiveAdmin.register Project do
  permit_params :name, :payload, account_ids: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :payload, as: :string
      f.input :accounts, as: :select, include_blank: false
    end
    f.actions
  end

  index do
    selectable_column
    column :id do |project|
      link_to project.id, admin_project_path(project)
    end
    column :name
    column :payload
    column :accounts do |account|
      account.accounts.map do |account|
        account.name
      end.sort.join ', '
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :payload
      row :accounts do |account|
        account.accounts.map do |account|
          account.name
        end.sort.join ', '
      end
      row :created_at
      row :updated_at
    end
  end

end

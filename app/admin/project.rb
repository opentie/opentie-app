ActiveAdmin.register Project do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  permit_params :name, account_ids: []

  form do |f|
    f.inputs do
      f.input :name
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

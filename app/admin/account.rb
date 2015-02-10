ActiveAdmin.register Account do


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

  permit_params :name, :email, project_ids: [], bureau_ids: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :projects, as: :select, include_blank: false
      f.input :bureaus, as: :select, include_blank: false
    end
    f.actions
  end

  index do
    selectable_column
    column :id do |account|
      link_to account.id, admin_account_path(account)
    end
    column :name
    column :email
    column :projects do |account|
      account.projects.map do |project|
        project.name
      end.sort.join ', '
    end
    column :bureaus do |account|
      account.bureaus.map do |bureau|
        bureau.name
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
      column :projects do |account|
        account.projects.map do |project|
          project.name
        end.sort.join ', '
      end
      column :bureaus do |account|
        account.bureaus.map do |bureau|
          bureau.name
        end.sort.join ', '
      end
      row :created_at
      row :updated_at
    end
  end
end

ActiveAdmin.register Division do
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
    column :id do |division|
      link_to division.id, admin_division_path(division)
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

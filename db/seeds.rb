# coding: utf-8
unless Rails.env.production?
  puts "create Account"
  %w(ayanel yui marei yuka ayana).each do |name|
    Account.create(
                   name: name,
                   email: "#{name}@example.jp",
                   password: "password",
                   password_confirmation: "password",
                   payload: { hoge: "fuga"}
                   )
  end

  puts "create Project"
  %w(tkbctf itf_dj coins_udon).each do |name|
    Project.create(
                   name: name,
                   payload: { email: "#{name}@example.jp" }
                   )
  end

  puts "create Division"
  %w(jsys sok dan).each do |name|
    Division.create(
                    name: name,
                    payload: { people: 15 }
                    )
  end

  puts "create Roles"
  Division.all.each do |division|
    Account.all.each do |account|
      Role.create(
                  account_id: account.id,
                  division_id: division.id
                  )
    end
  end
    
  puts "create GlobalSetting"
  %w(global14 setting15).each do |name|
    GlobalSetting.create(
                         name: name,
                         value: { name: name }
                         )
  end
  
  puts "create RequestSchemata"
  Division.all.each do |division|
    5.times do |i|
      RequestSchema.create(
                           division_id: division.id,
                           payload: { num: i, setting: "div_setting" }
                           )
    end
  end

  puts "create Delegate"
  Project.all.each do |project|
    Account.all.each do |account|
      Delegate.create(
                      project_id: project.id,
                      account_id: account.id,
                      priority: 0
                      )
    end
  end

  puts "create Request"
  Delegate.all.each do |delegate|
    RequestSchema.all.each do |schema|
      Request.create(
                     request_schema_id: schema.id,
                     delegate_id: delegate.id,
                     payload: { num: 5 }
                     )
    end
  end  
end

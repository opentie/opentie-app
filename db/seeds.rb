
# coding: utf-8
unless Rails.env.production?

  puts "create Account"
  ActiveRecord::Base.transaction do
    accounts = []
    20.times do
      name = "account_name_" + ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(5).join
      Account.create(
        name: name,
        email: "#{name}@example.jp",
        password: "password",
        password_confirmation: "password",
        payload: { hoge: "fuga"}
      )
    end
    #Account.import accounts
  end

  puts "create Project"
  ActiveRecord::Base.transaction do
    projects = []
    10.times do
      name = "project_name_" + ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(5).join
      projects << Project.create(
        name: name,
        payload: { email: "#{name}@example.jp" }
      )
    end
    #Project.import projects
  end

  puts "create Division"
  ActiveRecord::Base.transaction do
    divisions = []
    5.times do
      name = "division_name_" + ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(5).join
      Division.create(
        name: name,
        payload: { people: 15 }
      )
    end
    #Division.import divisions
  end
  
  puts "create Roles"
  ActiveRecord::Base.transaction do
    roles = []
    Division.all.each do |division|
      Account.all.each do |account|
        Role.create(
          account_id: account.id,
          division_id: division.id
        )
      end
    end
    #Role.imoport roles
  end
  
  puts "create GlobalSetting"
  ActiveRecord::Base.transaction do
    global_settings = [] 
    %w(global14 setting15).each do |name|
      GlobalSetting.create(
        name: name,
        value: { name: name }
      )
    end
    #GlobalSetting.import global_settings
  end
  
  puts "create RequestSchemata"
  ActiveRecord::Base.transaction do
    schemata = []
    Division.all.each do |division|
      3.times do |i|
        RequestSchema.create(
          division_id: division.id,
          payload: { num: i, setting: "div_setting" }
        )
      end
    end
    #RequestSchema.import schemata
  end

  puts "create Delegate"
  ActiveRecord::Base.transaction do
    delegates = []
    priority_count = 0
    Project.all.each do |project|
      Account.all.each do |account|
        Delegate.create(
          project_id: project.id,
          account_id: account.id,
          priority: priority_count
        )
        priority_count += 1
      end
    end
    #Delegate.import delegates
  end


  puts "create Request"
  ActiveRecord::Base.transaction do
    requests = []
    Delegate.all.each do |delegate|
      RequestSchema.all.each do |schema|
        Request.create(
          request_schema_id: schema.id,
          delegate_id: delegate.id,
          payload: { num: 5 }
        )
      end
    end
    #Request.import requests
  end
end


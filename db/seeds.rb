
# coding: utf-8
unless Rails.env.production?
  ActiveRecord::Base.transaction do
    puts "create Account"
    accounts = []
    100.times do
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

    puts "create Project"
    projects = []
    50.times do
      name = "project_name_" + ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(5).join
      projects << Project.create(
        name: name,
        payload: { email: "#{name}@example.jp" }
      )
    end
    #Project.import projects

    puts "create Division"
    divisions = []
    50.times do
      name = "division_name_" + ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(5).join
      Division.create(
        name: name,
        payload: { people: 15 }
      )
    end
    #Division.import divisions
    
    puts "create Roles"
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
    
    puts "create GlobalSetting"
    global_settings = [] 
    %w(global14 setting15).each do |name|
      GlobalSetting.create(
        name: name,
        value: { name: name }
      )
    end
    #GlobalSetting.import global_settings
    
    puts "create RequestSchemata"
    schemata = []
    Division.all.each do |division|
      20.times do |i|
        RequestSchema.create(
          division_id: division.id,
          payload: { num: i, setting: "div_setting" }
        )
      end
    end
    #RequestSchema.import schemata

    puts "create Delegate"
    delegates = []
    Project.all.each do |project|
      Account.all.each do |account|
        Delegate.create(
          project_id: project.id,
          account_id: account.id,
          priority: 0
        )
      end
    end
    #Delegate.import delegates

    puts "create Request"
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

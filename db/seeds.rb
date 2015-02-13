# coding: utf-8
unless Rails.env.production?
  puts "create Account"
  %w(ayanel yui marei yuka ayana).each do |name|
    Account.create(
      name: name,
      email: "#{name}@example.jp",
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

  puts "create ProjectHistory"
  Project.all.each do |project|
    3.times do |i|
      ProjectHistory.create(
        project_id: project.id,
        field: "test_field",
        value: "value#{i}"
      )
    end
  end

  puts "create Division"
  %w(jsys sok dan).each do |name|
    Division.create(
      name: name,
      payload: { people: 15 }
    )
  end
  
  puts "create GlobalSetting"
  %w(global14 setting15).each do |name|
    GlobalSetting.create(
      value: { name: name }
    )
  end

  puts "create Divisoion"
  %w(jsys sok dan).each do |name|
    Division.create(
      name: name,
      payload: { people: 15 }
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
    Delegate.create(
      project_id: project.id,
      account_id: Account.all.sample.id,
      priority: 0
    )
  end

  puts "create Request"
  Delegate.all.each do |delegate|
    Request.create(
      request_schema_id: RequestSchema.all.sample.id,
      delegate_id: delegate.id,
      payload: { num: 5 }
    )
  end  
end

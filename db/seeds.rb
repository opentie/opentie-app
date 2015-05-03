
# coding: utf-8
unless Rails.env.production?
  puts "initialize sequence" 
  Project.initialize_number(20)

  puts "create Account"
  ActiveRecord::Base.transaction do
    30.times do
      name = "account_name_" + ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(5).join
      Account.create(
        name: name,
        email: "#{name}@example.jp",
        password: "password",
        password_confirmation: "password",
        payload: { hoge: "fuga"}
      )
    end
  end

  puts "create Project"
  ActiveRecord::Base.transaction do
    10.times do
      name = "project_name_" + ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(5).join
      Project.create(
        name: name,
        payload: { email: "#{name}@example.jp" }
      )
    end
  end

  puts "create Division"
  ActiveRecord::Base.transaction do
    [
      '総務局',
      '総合計画局',
      '推進局',
      'ステージ管理局',
      '渉外局',
      '本部企画局',
      '情報システム局',
      '広報宣伝局',
      '財務局',
      '調査専門部会'
    ].each do |name|
      Division.create(
        name: name,
        payload: {}
      )
    end
  end
  
  puts "create Roles"
  ActiveRecord::Base.transaction do
    Division.all.each do |division|
      Account.all.each do |account|
        Role.create(
          account_id: account.id,
          division_id: division.id
        )
      end
    end
  end
  
  puts "create Delegate"
  ActiveRecord::Base.transaction do
    Project.all.each do |project|
      priority_count = 0
      Account.all.each do |account|
        Delegate.create(
          project_id: project.id,
          account_id: account.id,
          priority: priority_count
        )
        priority_count += 1
      end
    end
  end
end

# GlobalSetting data
@global_settings_path = "#{Rails.root}/config/global_settings/"
@request_schemata_path = "#{Rails.root}/config/request_schemata/"

puts "load RequestSchema"
Dir.glob("#{@request_schemata_path}*.json") do |file_path|
  json_data = open(file_path) do |io|
    JSON.load(io)
  end

  RequestSchema.create(
    division_id: Division.find_by(name: json_data['division_name']).id,
    name: json_data['name'],
    payload: json_data['payload'].to_json
  )
end


puts "load GlobalSetting"
Dir.glob("#{@global_settings_path}*.json") do |file_path|
  json_data = open(file_path) do |io|
    JSON.load(io)
  end
  
  GlobalSetting.create(
    name: json_data['name'],
    value: json_data['payload'].to_json
  )
end

unless Rails.env.production?
  puts "create Request"
  ActiveRecord::Base.transaction do
    Project.all.each do |project|
      delegate = project.delegates.find_by(priority: 0)
      RequestSchema.all.each do |schema|
        Request.create(
          request_schema_id: schema.id,
          delegate_id: delegate.id,
          payload: { num: 5 }
        )
      end
    end
  end

  puts "create ProjectComment"
  ActiveRecord::Base.transaction do
    Project.all.each do |project|
      Role.all.each do |role|
        ProjectComment.create(
          project_id: project.id,
          role_id: role.id,
          comment: "===to=== #{project.name} ===from=== #{role.id}"
        )
      end
    end
  end
end


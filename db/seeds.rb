# coding: utf-8

unless Rails.env.production?
  puts "initialize sequence"
  begin
    Project.initialize_number(20)
  rescue => e
    Project.connection.execute "CREATE SEQUENCE projects_number_seq INCREMENT BY 1 START WITH 20"
  end

  @global_settings_path = "#{Rails.root}/config/global_settings/"
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
end

if Rails.env.test?
  puts "create Account"
  ActiveRecord::Base.transaction do
    20.times do
      name = "account_name_" + ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(5).join
      Account.create(
        name: name,
        email: "#{name}@example.jp",
        password: "password",
        password_confirmation: "password",
        payload: { hoge: "fuga"},
        confirmed_email: true
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
    5.times do
      name = "division_name_" + ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(5).join
      Division.create(
        name: name,
        payload: { people: 15 }
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

  puts "create GlobalSetting"
  ActiveRecord::Base.transaction do
    %w(global14 setting15).each do |name|
      GlobalSetting.create(
        name: name,
        value: { name: name }
      )
    end
  end

  puts "create RequestSchemata"
  ActiveRecord::Base.transaction do
    Division.all.each do |division|
      3.times do |i|
        RequestSchema.create(
          division_id: division.id,
          name: "レンタル物品申請",
          payload: [
            {
              "type" => "text",
              "name" => "name",
              "note" => "物の名前を入力してください",
              "title" => "名前",
              "validators" => [
                { "type" => "required", "description" => "必須" },
                { "type" => "minlength", "condition" => "5", "description" => "5文字以上で入力してください" }
              ]
            }
          ].to_json
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

  puts "create Invitation"
  ActiveRecord::Base.transaction do
    Project.all.each do |project|
      10.times do |i|
        Invitation.create(
          project_id: project.id,
          invited_email: "tie_test@example.co.hoge"
        )
      end
    end
  end
end


if Rails.env.development?
  puts "create Account"
  ActiveRecord::Base.transaction do
    30.times do |i|
      name = "account_name_" + ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(5).join
      Account.create(
        name: name,
        email: "dev#{i}@example.jp",
        password: "password",
        password_confirmation: "password",
        payload: { hoge: "fuga"},
        confirmed_email: true
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

  @request_schemata_path = "#{Rails.root}/config/request_schemata/"
  puts "load RequestSchema"
  Dir.glob("#{@request_schemata_path}*.json") do |file_path|
    json_data = open(file_path) do |io|
      JSON.load(io)
    end

    puts "validating #{json_data['name']}"
    Formalizr::FormSchema.new(json_data['payload'])

    RequestSchema.create(
      division_id: Division.find_by(name: json_data['division_name']).id,
      name: json_data['name'],
      payload: json_data['payload'].to_json,

      requestable: json_data['requestable'],
      required: json_data['required'],
      
      deadline_at: DateTime.iso8601(json_data['deadline_at']),
      opened_at: DateTime.iso8601(json_data['opened_at']),
    )
  end

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

  puts "create Invitation"
  ActiveRecord::Base.transaction do
    Project.all.each do |project|
      5.times do |i|
        Invitation.create(
          project_id: project.id,
          invited_email: "tie_test@example.co.hoge"
        )
      end
    end
  end
end

# Need open ID connect
case File.exist? "#{Rails.root}/config/openid.yml"
when true
  OPENID = YAML.load_file("#{Rails.root}/config/openid.yml")
when false
  OPENID = { 'OP_CLIENT_ID' => 'fake_id', 'OP_SECRET_KEY' => 'fake_key'}
end


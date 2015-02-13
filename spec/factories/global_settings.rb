FactoryGirl.define do
  factory :global_setting do
    value { hoge: "fuga" }.to_json
  end
end

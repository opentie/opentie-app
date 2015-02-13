FactoryGirl.define do
  factory :global_setting do
    value { { hoge: "fuga" } }
  end
end

FactoryGirl.define do
  factory :request do
    payload { { hoge: "fuga" } }
  end
end

FactoryGirl.define do
  factory :account_factory, class: Account do
    name "open tai"
    code "uuid(20)"
  end
end

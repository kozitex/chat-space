FactoryGirl.define do
  factory :user do
    name                  'test'
    email                 'tes@test.com'
    password              'testtest'
    password_confirmation 'testtest'
  end
end

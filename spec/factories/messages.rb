include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :message do
    body  Faker::Lorem.sentence
    image File.open("#{Rails.root}/public/uploads/images/image.jpg")
    group
    user
  end
end

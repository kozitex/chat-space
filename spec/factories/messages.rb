include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :message do
    body  'テスト用のメッセージ内容です'
    image File.open("#{Rails.root}/public/uploads/images/image.jpg")
    group
    user
  end
end

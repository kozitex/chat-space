class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages
  validates :name, presence: true

  def show_latest_message
    if (latest_message = messages.last).present?
      if latest_message.body?
        latest_message.body
      else
        '（※画像のみ）'
      end
    else
      'まだメッセージがありません。'
    end
  end
end

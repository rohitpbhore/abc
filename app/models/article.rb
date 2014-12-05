class Article < ActiveRecord::Base
  has_one :user

  validate :text, presence: :true
end

class Order < ActiveRecord::Base
  has_many :characters
end

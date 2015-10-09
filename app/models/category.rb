class Category < ActiveRecord::Base
  include Bootsy::Container

  acts_as_nested_set
end

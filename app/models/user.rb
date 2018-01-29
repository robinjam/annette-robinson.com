class User < ApplicationRecord
  validates_presence_of :provider, :uid
  validates_uniqueness_of :uid, :scope => :provider, :case_sensitive => false
end

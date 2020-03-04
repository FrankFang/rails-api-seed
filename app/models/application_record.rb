class ApplicationRecord < ActiveRecord::Base
  default_scope -> { (self.respond_to? :kept) ? kept : nil }
  self.abstract_class = true
end

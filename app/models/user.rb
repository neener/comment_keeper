class User < ActiveRecord::Base
	has_many :categories

	self.has_secure_password()
end
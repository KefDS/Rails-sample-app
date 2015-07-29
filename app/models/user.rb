class User < ActiveRecord::Base
	# Esta acción la hace antes de guardar un objeto al la BD
	before_save { self.email.downcase! }

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :email,
		presence: true,
		length: { maximum: 255 },
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }

	validates :password, length: { minimum: 6 }

	has_secure_password

	def User.digest(string)
		# Genera un password aleatorio al mínimo costo (por ser de pruebas)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

end

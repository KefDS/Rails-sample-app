class User < ActiveRecord::Base
	# Contendrá un string aleatorio que servirá de token de la sessión
	attr_accessor :remember_token

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

	# Returns the hash digest of the given string.
	def User.digest(string)
		# Genera un password aleatorio al mínimo costo (por ser de pruebas)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
	def User.new_token
		# Generate a 22 length random caracters
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		# En la base de datos se guardará el token aleatorio para tener una session persistentes
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forget a user
	def forget
		update_attribute(:remember_digest, nil)
	end

end

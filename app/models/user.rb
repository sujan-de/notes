class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time
  field :remember_created_at, type: Time

  # custom fields
  field :name, type: String
  # index on email
  index({ email: 1 }, { unique: true, name: "email_index" })

  has_many :notes
end

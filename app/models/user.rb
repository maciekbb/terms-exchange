class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :proposals
  has_many :terms, through: :proposals

  def to_s
  	email
  end

  def subjects_to_exchange
  	terms.map(&:subject).uniq
  end

end

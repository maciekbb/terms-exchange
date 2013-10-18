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

  def to_give(subject)
  	proposals.joins(:term).find_by(terms: { subject_id: subject.id }, preferred: false)
  end

  def to_take(subject)

  end

end

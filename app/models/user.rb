class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :answers,
           class_name: 'Answer',
           foreign_key: 'author_id',
           dependent: :destroy,
           inverse_of: :author

  has_many :questions,
           class_name: 'Question',
           foreign_key: 'author_id',
           dependent: :destroy,
           inverse_of: :author

  def author_of?(model)
       id == model.author_id
  end

end

class Task < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true

    belongs_to :user
    belongs_to :board

    has_many :comments, dependent: :destroy
end

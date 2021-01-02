class Task < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true

    has_one_attached :eyecatch 

    belongs_to :user
    belongs_to :board

    has_many :comments, dependent: :destroy

    def comment_count
        comments.count
    end
end

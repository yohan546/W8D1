# == Schema Information
#
# Table name: subs
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  moderator   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Sub < ApplicationRecord

    validates :moderator, presence: true, uniqueness: true
    validates :title, :description, presence: true

    belongs_to :creator,
        foreign_key: :moderator,
        class_name: :User
end

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  content    :text             not null
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord

    validates :title, :sub_id, :author_id, presence: true

    belongs_to :sub,
        foreign_key: :sub_id,
        class_name: :Post
    
    belongs_to :author,
        foreign_key: :author_id,
        class_name: :User

    
end

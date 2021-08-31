class Relationship < ApplicationRecord
  # follower,followedともにUserクラスに依存する
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end

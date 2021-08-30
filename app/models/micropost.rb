class Micropost < ApplicationRecord
  belongs_to :user
  # active storageのimageとの関連付け(投稿につき１件の画像ファイルを許可)
  has_one_attached :image
  # 投稿を新しい順に並び替え
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  # 画像のフォーマットやサイズに制限をかける
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message: "should be less than 5MB" }
  
  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
  
end

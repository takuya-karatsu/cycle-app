class Article < ApplicationRecord
  with_options presence: true do
    validates :title, length: {maximum: 15}
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :distance
    validates :content, length: {maximum: 150}
  end

  validates :image_title, length: {maximum: 15}

  belongs_to :user
  has_many   :comments, dependent: :destroy
  has_many   :likes,    dependent: :destroy
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  def self.like_sort
    self.includes(:user).joins(:likes).group(:article_id).order('count(article_id) desc').order("created_at desc")
  end

  def self.no_like_sort
    like_exists_id = Like.group(:article_id).order('count(article_id) desc').pluck(:article_id)
    self.includes(:user).where.not(id: like_exists_id).order("created_at desc")
  end

  def self.like_sort_result
    result1 = self.like_sort
    result2 = self.no_like_sort
    if result2.present?
      return result1 + result2
    else
      return result1
    end
  end
end

      
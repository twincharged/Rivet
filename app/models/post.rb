class Post < ActiveRecord::Base

mount_uploader :photo, PhotoUploader

attr_readonly :user_id, except: {on: :create}

validates :user_id, presence: true, length: {maximum: 5000}
validates :shareable_type, inclusion: {in: %w( Post )}, allow_nil: true
validates :youtube_string, length: {maximum: 500}
validate  :presence_of_content, :valid_content_combination

# default_scope {order('posts.created_at DESC')}


belongs_to :user

belongs_to(
  :shareable,
  polymorphic: true
  )

has_many(
  :shares,
  as: :shareable,
  class_name: "Post"
  )

has_many(
  :notifications,
  as: :notifiable,
  dependent: :destroy
  )

has_many(
  :comments,
  as: :threadable,
  class_name: "Comment",
  dependent: :destroy
  )

has_many(
  :likes,
  as: :likeable,
  class_name: "Like",
  dependent: :destroy
  )

has_many(
  :flags,
  as: :flagable,
  class_name: "Flag",
  dependent: :destroy
  )

has_many(
  :blocks,
  as: :blockable,
  dependent: :destroy
  )

##### TOTAL FLAGS ON POST #####

  def flag_count
    self.flags.size
  end

##### BLOCKS ON POST #####

  def blocked_by?(user)
    user.blocked_objects.find_by(blockable: self).present?
  end

##### CONTENT #####

  def valid_content_combination
    return unless (photo.present? && shareable_type.present?)  ||  (photo.present? && youtube_string.present?)  ||  (shareable_type.present? && youtube_string.present?)
      errors.add(:base, "Don't post a photo and share content!")
  end

  def presence_of_content
    return unless  body.blank?  &&  photo.blank?  &&  shareable_type.blank?  &&  youtube_string.blank?
    errors.add(:base, "Try posting something!")
  end


end

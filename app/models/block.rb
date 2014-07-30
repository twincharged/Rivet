class Block < ActiveRecord::Base

attr_readonly :blocker_id, except: {on: :create}

validates :blocker_id, presence: true, uniqueness: {scope: [:blockable_id, :blockable_type]} # the same scope for uniqueness to new post and user objects
validates :blockable_type, inclusion: {in: %w( User Post )}
validate  :validate_block

after_save :destroy_blocked_relationships


belongs_to(
  :blocker,
  class_name: "User"
  )

belongs_to(
  :blockable,
  polymorphic: true
  )


belongs_to(
  :post,
  class_name: "Post",
  foreign_key: :blockable
  )

belongs_to(
  :blocked_user,
  class_name: "User",
  foreign_key: :blockable
  )

private


  def validate_block
    if blockable_type == "User"
      return unless blocker_id == blockable_id
      errors.add(:base, "Can't block self.")
    elsif blockable_type == "Post"
      return unless blocker_id == blockable.user_id
      errors.add(:base, "Can't block own content.")
    else
      return
    end
  end


  def destroy_blocked_relationships
    return unless blockable_type == "User"
    relationships = Relationship.where("(follower_id = ? AND followed_id = ?) OR 
                                        (followed_id = ? AND follower_id = ? )", 
                                         blockable_id, blocker_id, 
                                         blockable_id, blocker_id)
    return if relationships.nil?
    relationships.destroy_all
  end


end

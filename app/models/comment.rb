class Comment < ActiveRecord::Base
  belongs_to :entry
  belongs_to :user
  default_scope -> { order('created_at ASC') }
  validates :user_id, presence: true
  validates :entry_id, presence: true
  validates :comment, presence: true, length: { maximum: 200 }

  def self.on_entry(entry)
    where(entry_id: entry.id)
  end
end

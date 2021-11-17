class Category < ApplicationRecord
    # For initialzing ancestry attribute to nil 
    before_validation :init_ancestry
    # Orphan_strategy method identifies what to do with children of a node that is destroyed.
    # Destroy  option is telling that  all children are destroyed as well (default).
    has_ancestry orphan_strategy: :destroy
    has_many :products, dependent: :destroy




    validates :title, presence: { message: "The title should not be empty" }
    validates :title, uniqueness: { message: "The title already exists" }
    validates :title, length: { maximum: 30,
      too_long: "%{count} characters is the maximum allowed" }
  
    private
    def init_ancestry
      self.ancestry = nil if self.ancestry.blank?
    end
    
end
class Category < ApplicationRecord
    # For initialzing ancestry attribute to nil 
    before_validation :init_ancestry

    has_ancestry 
    has_many :products, dependent: :destroy




    validates :title, presence: { message: "The title should not be empty" }
    validates :title, uniqueness: { message: "The title already exists" }
  
    private
    def init_ancestry
      self.ancestry = nil if self.ancestry.blank?
    end
    
end
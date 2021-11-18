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
  

    # Because my app's searching features is runing base on the Categories and sub-category of all items, a handy method is
  # defined here to access all the category tree node with the help of ancestry gem method 'roots' and 'children'.
  def self.grouped_data
    # Arrange all the category dates in an array, while the self.roots returns an array of categories and the array inject method will 
    # produces accumulating funtion base on the categories array. The empty array argument is the initial value which the result represents,
    # While the parent presents the element in self.roots array which is categories array.
    # In the inject block, I declear a empty array to contain all the categories and then add all the sub categories indisde the array and
    # after combine the initial empty array it finally returns an array contains all the categories and sub categories. 
    # We can loop once in this array for searching specific category.
    # And the, I can invoke this handy method in what ever controllers action to get the main and sub categories record and 
    # send the result back to view.
      self.roots.order("weight desc").inject([]) do |result, parent|
        row = []
        row << parent
        row << parent.children.order("weight desc")
        result << row
      end
    end
    private
    def init_ancestry
      self.ancestry = nil if self.ancestry.blank?
    end
    
end
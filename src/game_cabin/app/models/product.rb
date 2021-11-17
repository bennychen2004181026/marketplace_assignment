class Product < ApplicationRecord

  has_one_attached :product_image do |attachable|
  attachable.variant :medium, resize: "200x200"
  attachable.variant :large, resize: "300x300"
  attachable.variant :thumb, resize: "100x100"
end
  belongs_to :category

  before_create :set_uuid
    


    validates :category_id, presence: { message: "Should has a category." }

    validates :title, presence: { message: "Name should be provided." }

    validates :status, inclusion: { in: %w[available Not_available], 
      message: "Status has to be available or not available." }

    validates :amount, numericality: { only_integer: true,
      message: "Inventory amount has to an integer." },
      if: proc { |product| !product.amount.blank? }

    validates :amount, presence: { message: "Inventory amount should be provided." }

    validates :price, presence: { message: "Price should be provided." }
    validates :price, numericality: { message: "Price should be a number." },
      if: proc { |product| !product.price.blank? }

    validates :product_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg','image/gif'],
    size: { less_than: 8.megabytes , message: 'is too bid, maximin size is 8mb!' }

    validates :description, presence: { message: "Should have description." }
  
    scope :onshelf, -> { where(status: Status::Available) }

   

    private
    # Rails 6 method for generate a Version 4 UUIDs.
    def set_uuid
        self.uuid = SecureRandom.base36(24)
    end
end

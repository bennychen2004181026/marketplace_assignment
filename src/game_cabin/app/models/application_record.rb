class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
# Helper module for identify two status of product model
module Status
  Available = 'Available'
  Not_Available = 'Not_Available'
end

end

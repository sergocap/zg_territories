class OrganizationManager < ApplicationRecord
   belongs_to :organization
   validates_presence_of :organization_id, :user_id

   def manager
     User.find_by id: user_id
   end
end

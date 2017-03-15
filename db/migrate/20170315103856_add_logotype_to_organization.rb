class AddLogotypeToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_attachment :organizations, :logotype
  end
end

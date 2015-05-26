class ChangePartnersToCorporatePartners < ActiveRecord::Migration
  def change
    rename_table :partners, :corporate_partners
  end
end

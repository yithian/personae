class AddObsidianCampaignIdToChronicles < ActiveRecord::Migration
  def self.up
    add_column :chronicles, :obsidian_campaign_id, :string
  end

  def self.down
    remove_column :chronicles, :obsidian_campaign_id
  end
end

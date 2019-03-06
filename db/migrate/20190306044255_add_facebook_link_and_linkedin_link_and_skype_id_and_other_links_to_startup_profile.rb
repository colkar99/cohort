class AddFacebookLinkAndLinkedinLinkAndSkypeIdAndOtherLinksToStartupProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :startup_profiles, :facebook_link, :string
    add_column :startup_profiles, :linkedin_link, :string
    add_column :startup_profiles, :skype_id, :string
    add_column :startup_profiles, :other_links, :text
  end
end

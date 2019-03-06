class AddFacebookLinkAndLinkedinLinkAndSkypeIdAndOtherLinksToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :facebook_link, :string
    add_column :users, :linkedin_link, :string
    add_column :users, :skype_id, :string
    add_column :users, :other_links, :text
  end
end

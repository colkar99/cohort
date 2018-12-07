class RemovePasswordDigestFromStartupProfile < ActiveRecord::Migration[5.2]
  def change
    remove_column :startup_profiles, :password_digest, :string
  end
end

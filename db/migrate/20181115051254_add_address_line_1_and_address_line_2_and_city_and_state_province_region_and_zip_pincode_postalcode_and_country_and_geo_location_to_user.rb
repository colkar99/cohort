class AddAddressLine1AndAddressLine2AndCityAndStateProvinceRegionAndZipPincodePostalcodeAndCountryAndGeoLocationToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
    add_column :users, :city, :string
    add_column :users, :state_province_region, :string
    add_column :users, :zip_pincode_postalcode, :string
    add_column :users, :country, :string
    add_column :users, :geo_location, :string
  end
end

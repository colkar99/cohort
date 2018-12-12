class User < ApplicationRecord
	has_secure_password
	# has_many :user_roles ,:dependent => :delete_all
	# has_many :role_permissions ,through: :user_roles,:dependent => :delete_all
	# has_many :roles ,through: :role_permissions,:dependent => :delete_all
	has_many :user_roles
	has_many :roles, through: :user_roles
	has_many :selected_mentors
	has_many :startup_profiles, through: :selected_mentors
	has_many :startup_users
	has_many :startup_profiles, through: :startup_users
	# has_many :startup_profiles ,through: :selected_mentors,:dependent => :delete_all
	has_many :role_users
	has_many :roles, through: :role_users

	before_save  :set_create_attr
	before_validation :downcase_email
	validates :email, :uniqueness => { :case_sensitive => false }

	
	def set_create_attr
		if self.first_name && self.last_name
			self.full_name = self.first_name + " " + self.last_name
		end	
	end

	private

	def downcase_email
	  self.email = email.downcase if email.present?
	end

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |user|
				csv << user.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file)

	  spreadsheet = Roo::Spreadsheet.open(file.path)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    user = find_by(id: row["id"]) || new
	    user.attributes = row.to_hash
	    user.save!
	  end
	end  

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
	  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
	  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end
	
end

class Program < ApplicationRecord
  belongs_to :program_type
  belongs_to :location
end

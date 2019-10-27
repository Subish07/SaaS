class Department < ApplicationRecord
	has_many :sections, :dependent=> :destroy
	has_many :students,:through=> :section
	before_create :change_to_capital
	
	#validations
	 validates :name, presence: true, uniqueness: true
	#callbacks
	before_create :change_to_capital

	private
	def change_to_capital
		self.name = self.name.upcase
	end
end

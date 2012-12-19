class He < ActiveRecord::Base
	has_many :devices
	validates_presence_of :address

	scope :active, where(:blocked => false)#i.joins(:devices)
	scope :business_mpls, joins(:devices).where(:devices=>{:is_mpls=>true, :is_biznes=>true})


	def is_biznes_mpls
		!self.devices.biznes.mpls.nil?
	end
end

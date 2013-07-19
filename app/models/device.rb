class Device < ActiveRecord::Base

  #attr_accessible zawsze to dawaj

  validates_presence_of :name, :ip, :community
  validates_uniqueness_of :name, :on => :create, :message => 'Urzadzenie o takiej nazwie juz istnieje !'
  validates_uniqueness_of :ip, :on => :create, :message => 'Urzadzenie o takim adresie IP juz istnieje !'
  
  has_and_belongs_to_many :users
  belongs_to :he

  before_save :ip_addr_validate

  scope :mpls, where(:is_mpls => true)
  scope :biznes, where(:is_biznes => true)
  
  def ports_state
    lookup_values = ["ifIndex", "ifDescr", "ifAlias", "ifAdminStatus", "ifOperStatus"]
    ports = []
    
    begin
    SNMP::Manager.open(:Host => self.ip, :Community => self.community) do |manager|
        manager.walk(lookup_values) do |index, descr, ifalias, admin, oper|
          port = [index.value, descr.value, ifalias.value, admin.value, oper.value]
          ports << port
        end
      end
    rescue SNMP::RequestTimeout 
      return -1
    end
    return ports
    end
    
    #SNMP::Manager.open(:Host => self.ip, :Community => self.community) do |manager|
    #    manager.walk(lookup_values) do |index, descr, ifalias, admin, oper|
    #      port = [index.value, descr.value, ifalias.value, admin.value, oper.value]
    #      ports << port
    #    end
    #  end
    #return -1 unless (ports != nil)
    #end
  
  def ports_number
    ports_number = 0
    SNMP::Manager.open(:Host => self.ip, :Community => self.community) do |manager|
      #ports_number = manager.get_value(1.3.6.1.2.1.2.1)
      return ports_number
    end
  end
  
  private
  def ip_addr_validate
    if (IPAddress.valid? self.ip)
      return true
    else
      self.errors.add(:base, "Adres ip niepoprawny")
      return false
    end   
  end
  
end

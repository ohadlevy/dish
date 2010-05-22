class Mux < ActiveRecord::Base
  belongs_to :host
  belongs_to :package
  belongs_to :version
  belongs_to :os
  belongs_to :arch

  def self.import(host, os, list, seperator = "===")
    h = host.is_a?(Host) ? host : Host.find_by_name(host)
    os = Os.find_or_create_by_name os
    current_list = Mux.all(:conditions => {:host_id => h})
    parsed = []

    list.each_line do |line|
      pkg, version, arch = line.split(seperator).map{|s| s.chomp.strip}

      unless m=Mux.first(:joins => [:package, :version, :arch],
                :conditions => {:host_id => h.id, :os_id => os.id, :packages => {:name => pkg},
                  :versions => {:value => version}, :arches => {:name => arch}})

        p = Package.find_or_create_by_name(pkg).id
        v = Version.find_or_create_by_value(version).id
        a = Arch.find_or_create_by_name(arch).id
        m = Mux.create(:host => h, :package_id => p, :version_id => v, :arch_id => a, :os => os)
      end
      parsed << m

    end
    # search for changed packages (deleted, updated etc)
    changes = current_list - parsed
    logger.debug "Processed #{h.name}: #{changes.size} changes"
    Mux.delete_all(:id => changes.map(&:id)) unless changes.empty?
    h.update_attribute(:updated_at, Time.now)
  end
end

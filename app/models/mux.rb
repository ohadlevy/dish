class Mux < ActiveRecord::Base
  belongs_to :host
  belongs_to :package
  belongs_to :version
  belongs_to :os
  belongs_to :arch

#  validates_uniqueness_of :host, :scope => :package
  validates_associated :host, :package, :version, :arch, :os

  def self.import(host, os, list, seperator = "===")
    h = host.is_a?(Host) ? host : Host.find_by_name(host)
    os = Os.find_or_create_by_name os

    list.each_line do |line|
      pkg, version, arch = line.split(seperator).map{|s| s.chomp.strip}
      p = Package.find_or_create_by_name pkg
      v = Version.find_or_create_by_value version
      a = Arch.find_or_create_by_name arch
      if (m = Mux.find(:first,:conditions => {:host_id => h,:package_id => p, :arch_id => a})).nil?
        Mux.create :host => h, :package => p, :version => v, :arch => a, :os => os
      elsif not m.version_id == v.id
        logger.info "#{h}: #{pkg} changed to version #{v} from #{m.version}"
        m.version = v
        m.save
      end
    end
  end

end

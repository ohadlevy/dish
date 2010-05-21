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
    packages = Package.all
    versions = Version.all
    arches = Arch.all

    list.each_line do |line|
      pkg, version, arch = line.split(seperator).map{|s| s.chomp.strip}

      p = packages.find {|r| r.name == pkg}      || Package.create(:name => pkg)
      v = versions.find {|r| r.value == version} || Version.create(:value => version)
      a = arches.find   {|r| r.name == arch}     || Arch.create(:name => arch)

      # check if we already have this record
      exists = current_list.empty? ? false : (not (current_list.reject! do |r|
        r.host_id == h.id && r.package_id == p.id && r.arch_id == a.id && r.version_id == v.id
      end).nil?)

      Mux.create :host => h, :package => p, :version => v, :arch => a, :os => os unless exists
    end

    # search for changed packages (deleted, updated etc)
    # using destory_all as we need to destroy any non required packages/versions
    Mux.destroy_all(:id => current_list)unless current_list.empty?
  end
end

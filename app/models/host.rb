class Host < ActiveRecord::Base
  has_many :muxes
  # bug in dependent => destory, should be fixed in 2.3.6 #2251
  after_destroy {|record| Mux.delete_all("host_id = #{record.id}")}
  has_many :packages, :through => :muxes, :uniq => true
  has_one :os, :through => :muxes
  validates_uniqueness_of :name

  def to_s
    name
  end

  def package pkg
    p = pkg.is_a?(Package) ? pkg : Package.find_by_name(pkg)
    if m = Mux.find(:first, :conditions => {:host_id => self, :package_id => p})
      v = Version.find m.version_id
    end
    "#{pkg}-#{v}"
  end

end

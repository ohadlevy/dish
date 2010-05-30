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

  def to_param
    name
  end

end

class Host < ActiveRecord::Base
  has_many :muxes, :dependent => :destroy
  has_many :packages, :through => :muxes, :uniq => true
  has_one :os, :through => :muxes
  validates_uniqueness_of :name

  scoped_search :on => :name, :complete_value => :true, :default_order => true
  scoped_search :in => :packages, :on => :name, :complete_value => :true, :rename => "package", :only_explicit => true
  scoped_search :in => :os,       :on => :name,  :complete_value => :true, :rename => "os", :only_explicit => true

  def to_s
    name
  end

  def to_param
    name
  end

end

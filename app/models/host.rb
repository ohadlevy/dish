class Host < ActiveRecord::Base
  has_many :muxes
  has_many :packages, :through => :muxes, :uniq => true
  has_one :os, :through => :muxes
  validates_uniqueness_of :name

  scoped_search :on => :name, :complete_value => :true
  scoped_search :in => :packages,    :on => :name, :complete_value => :true, :rename => "package"
  scoped_search :in => :archs,       :on => :name,  :complete_value => :true, :rename => "arch"

  def to_s
    name
  end

  def to_param
    name
  end

end

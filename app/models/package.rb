class Package < ActiveRecord::Base
  has_many :muxes, :dependent => :destroy
  has_many :versions, :through => :muxes, :uniq => true, :dependent => :destroy
  has_many :hosts, :through => :muxes, :uniq => true
  has_many :oss, :through => :muxes, :uniq => true
  has_many :archs, :through => :muxes, :uniq => true
  validates_uniqueness_of :name
  validates_format_of :name, :with => /\A(\S+\s?)+\Z/, :message => "can't be blank or contain trailing white space"

  def to_s
    name
  end

  def to_param
    name
  end

end

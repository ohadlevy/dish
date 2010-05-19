class Os < ActiveRecord::Base
  has_many :muxes
  has_many :packages, :through => :muxes, :uniq => true
  has_many :hosts, :through => :muxes, :uniq => true
  has_many :archs, :through => :muxes, :uniq => true
  has_many :versions, :through => :packages, :uniq => true
  validates_uniqueness_of :name
  validates_format_of :name, :with => /\A(\S+\s?)+\Z/, :message => "can't be blank or contain trailing white space"

  def to_s
    name
  end
end

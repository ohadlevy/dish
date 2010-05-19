class Version < ActiveRecord::Base
  has_many :muxes, :dependent => :destroy
  has_many :packages, :through => :muxes, :uniq => true
  has_many :hosts, :through => :muxes, :uniq => true
  has_many :oss, :through => :muxes, :uniq => true
  validates_uniqueness_of :value
  validates_format_of :value, :with => /\A(\S+\s?)+\Z/, :message => "can't be blank or contain trailing white space"

  def to_s
    value
  end
end

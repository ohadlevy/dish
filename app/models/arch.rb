class Arch < ActiveRecord::Base
  has_many :muxes
  has_many :packages, :through => :muxes, :uniq => true
  validates_format_of :name, :with => /\A(\S+\s?)+\Z/, :message => "can't be blank or contain trailing white space"
  validates_uniqueness_of :name

  def to_s
    name
  end
end

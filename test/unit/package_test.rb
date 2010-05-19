require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Package.new.valid?
  end
end

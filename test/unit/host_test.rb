require 'test_helper'

class HostTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Host.new.valid?
  end
end

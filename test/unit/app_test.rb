require 'test_helper'

class AppTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert App.new.valid?
  end
end

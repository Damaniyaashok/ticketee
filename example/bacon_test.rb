#!/usr/bin/ruby

require 'minitest/autorun'

class Bacon
  def self.saved?
    false
  end
end
class BaconeTest < Minitest::Test
  def test_saved
    assert Bacon.saved?, "our Bacon Was not Saved"
  end
end

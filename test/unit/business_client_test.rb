# -*- coding: utf-8 -*-
require 'test_helper'

class BusinessClientTest < ActiveSupport::TestCase
  test "add a client" do
    c = BusinessClient.new(:name => client)
    assert c.save, "Not saved"
  end
end

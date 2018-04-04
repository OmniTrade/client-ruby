require 'helper'

class TestConfig < Minitest::Test

  def test_get_omnitraderc
    path = File.expand_path '../../fixtures/omnitraderc', __FILE__
    access_key, secret_key = OmniTradeAPI::Config.get_omnitraderc(path)
    assert_equal 'access1234567', access_key
    assert_equal 'secret1234567', secret_key
  end

end

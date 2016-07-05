require 'test_helper'

class IsupControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get isup_input_url
    assert_response :success
  end

  test "should get result" do
    get isup_result_url
    assert_response :success
  end

end

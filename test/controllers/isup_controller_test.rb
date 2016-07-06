require 'test_helper'

class IsupControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get isup_input_url
    assert_response :success
  end

  test "should get result" do
    post isup_result_url, :url => 'www.google.com' 
    assert_response :success
  end

end

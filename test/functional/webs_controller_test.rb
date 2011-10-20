require File.dirname(__FILE__) + '/../test_helper'
require 'webs_controller'

# Re-raise errors caught by the controller.
class WebsController; def rescue_action(e) raise e end; end

class WebsControllerTest < Test::Unit::TestCase
  def setup
    @controller = WebsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

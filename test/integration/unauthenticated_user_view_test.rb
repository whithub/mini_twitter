require "test_helper"

class UnauthenticatedUserViewTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = Whitter::Application
  end

  test 'the unauthenticated user can only view login page' do
    visit root_path

    assert page.has_link? "Login"

    visit dashboard_path

    assert_raises
    assert page.has_no_content("Tweet")
    assert root_path, current_path
  end
end

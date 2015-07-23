require 'test_helper'

class UserLogsInViaTwitterTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = Whitter::Application
    stub_omniauth
  end


  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        provider: 'twitter',
        extra: {
          raw_info: {
            user_id: "1234",
            name: "Whitney Hiemstra",
            screen_name: "whithub",
          }
        },
        credentials: {
          token: "pizza",
          secret: "secretpizza"
        }
      })
  end

  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Login"

    assert_equal "/dashboard", current_path
    assert page.has_content?("Whitney")
    assert page.has_link?("logout")
  end

  test "authenticated user can logout" do
    skip
  end


end

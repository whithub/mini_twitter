require 'test_helper'

class AuthenticatedUserAbilitiesTest < ActionDispatch::IntegrationTest
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
          token: ENV["SAMPLE_OAUTH_TOKEN"],
          secret: ENV["SAMPLE_OAUTH_TOKEN_SECRET"]
        }
      })
  end

  test "authenticated user can Tweet" do
    VCR.use_cassette("user-timeline") do
      visit "/"
      click_on "Login"

      assert_equal "/dashboard", current_path
      assert page.has_content?("Whitney")

      within(".tweeting-through-api") do
        fill_in "What are you Tweeting about?!", with: "Tweeting if fun!"
      end

      within(".my-submit-tweet-button") do
        click_button "Tweet"
      end

      assert_equal "/dashboard", current_path

      assert page.has_content?("Tweeting if fun!")
    end
  end
end

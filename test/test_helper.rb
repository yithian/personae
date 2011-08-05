ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # wrapper method around the native assert_select method that extracts out the html
  # from raw html text that is embedded within javascript code.
  # ex.
  #   $('body').append("<div id=\"edit_post_form_container\" class=\"active modal_form_container\">
  #     <a href=\"#\" class=\"close\">
  #       <img alt=\"Close\" height=\"16\" src=\"/images/close.png?1293730609\" width=\"16\" />
  #     <\/a>
  #     <form accept-charset=\"UTF-8\" action=\"/posts/1023110335\" .../>")
  #
  # assert_js_select "input[type=?][name=?]", "text", "foo[bar]", :count => 1
  # assert_js_select "textarea", "Some long text"
  # assert_js_select "textarea[name=?]", "post_text", "Some long text"
  # assert_js_select "textarea[name=?][class=?]", ["post_text", "css_class", "Some long text"
  def assert_js_select(*args, &block)
    extracted_text = @response.body.match(/(\<.*\>)/)[0].
      gsub("\\n", "").gsub("\\t", "").gsub(/\\"/, '"').gsub("\\", '')
    if extracted_text.present?
      doc = HTML::Document.new(CGI::unescapeHTML(extracted_text)).root
      args.insert(0, doc)
      assert_select(*args, &block)
    else
      assert false, "Unable to extract any html from the js code."
    end
  end
end

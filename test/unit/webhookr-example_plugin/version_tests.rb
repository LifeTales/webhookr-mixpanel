$: << File.join(File.dirname(__FILE__), %w{ .. .. })
require 'test_helper'

describe Webhookr::Mixpanel do
  it "must be defined" do
    Webhookr::Mixpanel::VERSION.wont_be_nil
  end
end

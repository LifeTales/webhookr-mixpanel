
$: << File.join(File.dirname(__FILE__), "..")
require 'test_helper'

describe Webhookr::Mixpanel::Adapter do

  before do
    @event_type = 'dispatch'
    @member_id = SecureRandom.uuid
    @single_response = '{ "$distinct_id": "' + @member_id + '", "$properties": { "first_name": "Lloyd", "last_name": "Christmas" }} '
    @valid_response = 'users=[' + @single_response + ']'
    @valid_responses = 'users=[' + @single_response + ',' + @single_response + ']'
  end

  describe "the class" do

    subject { Webhookr::Mixpanel::Adapter }

    it "must support process" do
      subject.must_respond_to(:process)
    end

    it "should not return an error for a valid packet" do
      lambda {
        subject.process(@valid_response)
      }.must_be_silent
    end

  end

  describe "the instance" do

    subject { Webhookr::Mixpanel::Adapter.new }

    it "should not return an error for a valid packet" do
      lambda {
        subject.process(@valid_response)
      }.must_be_silent
    end

    it "should raise Webhookr::InvalidPayloadError for no packet" do
      lambda {
        subject.process("")
      }.must_raise(Webhookr::InvalidPayloadError)
    end

    it "should raise Webhookr::InvalidPayloadError for a missing event type" do
      lambda {
        subject.process('example_plugin_events=[ { "msg": { "email": "gerry%2Bagent1@zoocasa.com" }} ]')
      }.must_raise(Webhookr::InvalidPayloadError)
    end

    it "should raise Webhookr::InvalidPayloadError for a missing data packet" do
      lambda {
        subject.process('example_plugin_events=[ { "event": "spam" } ]')
      }.must_raise(Webhookr::InvalidPayloadError)
    end

  end

  describe "it's response" do
    before do
      @adapter = Webhookr::Mixpanel::Adapter.new
    end

    subject { @adapter.process(@valid_response).first }

    it "must respond to service_name" do
      subject.must_respond_to(:service_name)
    end

    it "should return the correct service name" do
      assert_equal(Webhookr::Mixpanel::Adapter::SERVICE_NAME, subject.service_name)
    end

    it "must respond to event_type" do
      subject.must_respond_to(:event_type)
    end

    it "should return the correct event type" do
      assert_equal(@event_type, subject.event_type)
    end

    it "must respond to payload" do
      subject.must_respond_to(:payload)
    end

    it "should return the correct data packet" do
      assert_equal("Lloyd", subject.payload.send('$properties').first_name)
    end
  end

end

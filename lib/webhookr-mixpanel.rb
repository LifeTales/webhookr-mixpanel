require "webhookr"
require "webhookr-mixpanel/version"
require "webhookr/ostruct_utils"
require 'active_support/hash_with_indifferent_access'

module Webhookr
  module Mixpanel
    class Adapter
      SERVICE_NAME = "mixpanel"
      EVENT_KEY = "do"
      PAYLOAD_KEY = "$distinct_id"

      include Webhookr::Services::Adapter::Base

      def self.process(raw_response)
        new.process(raw_response)
      end

      def process(raw_response)
        Array.wrap(parse(raw_response)).collect do |p|
          Webhookr::AdapterResponse.new(
            SERVICE_NAME,
            event_type,
            OstructUtils.to_ostruct(p)
          ) if assert_valid_packet(p)
        end
      end

      # the actual event_type is in the request params, 'do' param
      def event_type
        'dispatch'
      end

      private

      def parse(raw_response)
        begin
          assert_valid_packets(
            ActiveSupport::JSON.decode(
              CGI.unescape(raw_response).gsub(/users=/,"")
            )
          )
        rescue Exception => e
          raise InvalidPayloadError.new(e)
        end
      end

      def assert_valid_packets(parsed_responses)
        raise(
          Webhookr::InvalidPayloadError, "Malformed response |#{parsed_responses.inspect}|"
        ) unless parsed_responses.is_a?(Array) && parsed_responses.first.is_a?(Hash)
        parsed_responses
      end

      def assert_valid_packet(packet)
#        raise(Webhookr::InvalidPayloadError, "Unknown event #{self.params.fetch(EVENT_KEY)}") unless self.params.fetch(EVENT_KEY)
        raise(Webhookr::InvalidPayloadError, "No msg in the response") unless packet[PAYLOAD_KEY]
        true
      end

    end
  end
end

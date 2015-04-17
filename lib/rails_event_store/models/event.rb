require 'securerandom'

module RailsEventStore
  module Models
    class Event

      def initialize(event_data)
        @stream     = event_data.fetch(:stream, nil)
        @event_type = event_data.fetch(:event_type, nil)
        @event_id   = event_data.fetch(:event_id, SecureRandom.uuid).to_s
        @metadata   = event_data.fetch(:metadata, nil)
        @data       = event_data.fetch(:data, nil)
      end
      attr_reader :stream, :event_type, :event_id, :metadata, :data

      def validate!
        [stream, event_type, event_id, data].each do |attribute|
          raise IncorrectStreamData if is_invalid?(attribute)
        end
      end

      def to_h
        {
            stream: stream,
            event_type: event_type,
            event_id: event_id,
            metadata: metadata,
            data: data
        }
      end

      private

      def is_invalid?(attribute)
        attribute.nil? || attribute.empty?
      end
    end
  end
end
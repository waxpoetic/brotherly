module Facebook
  class Event
    class Collection
      include Enumerable

      delegate :each, to: :events

      def initialize(urls = [])
        @urls = urls.map { |url| parse(url) }.compact
      end

      def events
        @events = Facebook.graph.batch_api do |graph|
          urls.map do |url|
            params = graph.get_object("/#{id}").deep_symbolize_keys
            Event.new params.merge(url: url)
          end
        end
      end

      def find(url)
        super { |event| event.url == url }
      end

      private

      # Parse out the Facebook Event ID from the URL.
      #
      # @return [String] or +nil+ if not found.
      def parse(url)
        if url =~ %r{https://www.facebook.com/events/(\d+)}
          $1
        end
      end
    end
  end
end

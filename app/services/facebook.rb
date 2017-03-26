module Facebook
  # Graph API client for reading data from Facebook.
  #
  # @return [Koala::Facebook::API]
  def self.graph
    @graph ||= Koala::Facebook::API.new
  end
end

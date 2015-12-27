module Twitter
  class Promoter < Brotherly::Promoter
    remote EventTweet
    local :episode

    def attributes
      {
        text: "#{episode.name} has been announced! #{url}"
      }
    end
  end
end

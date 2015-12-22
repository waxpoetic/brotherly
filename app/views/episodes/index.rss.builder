cache podcast_cache_key do
  xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/",  version: "2.0" do
    cache podcast_cache_key(:channel) do
      xml.channel do
        cache podcast_cache_key(:info) do
          xml.title config.name
          xml.link "http://#{config.name}"
          xml.description config.description
          xml.language 'en'
          xml.pubDate podcast_publish_date
          xml.lastBuildDate podcast_publish_date
          xml.itunes :author, config.name
          xml.itunes :keywords, config.keywords
          xml.itunes :explicit, config.explicit
          xml.itunes :image, href: image_url('podcast.png')
          xml.itunes :owner do
            xml.itunes :name, config.name
            xml.itunes :email, "podcast@#{config.name}"
          end
          xml.itunes :block, 'no'
          xml.itunes :category, text: 'Music'
        end

        cache episodes.in_podcast do
          episodes.in_podcast.map(&:decorate).each do |episode|
            cache episode do
              xml.item do
                xml.title episode.name
                xml.description episode.description
                xml.pubDate episode.published_at
                xml.enclosure episode.enclosure
                xml.link episode.short_url
                xml.guid({isPermaLink: 'false'}, episode_url(episode))
                xml.itunes :author, config.name
                xml.itunes :subtitle, episode.subtitle
                xml.itunes :summary, episode.description
                xml.itunes :explicit, episode.explicit
                xml.itunes :duration, episode.duration
              end
            end
          end
        end
      end
    end
  end
end

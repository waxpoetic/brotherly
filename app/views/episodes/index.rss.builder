cache do
  xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/",  version: "2.0" do
    cache element: 'channel' do
      xml.channel do
        cache section: 'info' do
          xml.title config.name
          xml.link "http://#{config.name}"
          xml.description config.description
          xml.language 'en'
          xml.pubDate episodes.first.decorate.published_at
          xml.lastBuildDate episodes.first.decorate.published_at
          xml.itunes :author, config.name
          xml.itunes :keywords, config.keywords
          xml.itunes :explicit, config.explicit
          xml.itunes :image, href: image_path('logo')
          xml.itunes :owner do
            xml.itunes :name, config.name
            xml.itunes :email, "podcast@#{config.name}"
          end
          xml.itunes :block, 'no'
          xml.itunes :category, text: 'Music' do
            xml.itunes :category, text: 'Electronic'
          end
        end

        cache episodes do
          episodes.each do |episode|
            cache episode do
              xml.item do
                xml.title episode.name
                xml.description episode.description
                xml.pubDate episode.decorate.published_at
                xml.enclosure episode.decorate.enclosure(params[:kind])
                xml.link episode_url(episode)
                xml.guid({isPermaLink: 'false'}, episode_url(episode))
                xml.itunes :author, config.name
                xml.itunes :subtitle, episode.decorate.subtitle
                xml.itunes :summary, episode.description
                xml.itunes :explicit, episode.decorate.explicit
                xml.itunes :duration, episode.duration
              end
            end
          end
        end
      end
    end
  end
end

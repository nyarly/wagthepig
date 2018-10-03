class ExtractMoreIdsFromUrLs < ActiveRecord::Migration[5.2]
  class Game < ActiveRecord::Base
  end

  def up
    Game.find_each do |g|
      url = g.bgg_link || ""
      m = %r[https://(?:www\.)?boardgamegeek.com/boardgame(?:expansion)?/(\d+)/?.*].match(url)
      if m != nil
        g.update!(bgg_id: m[1])
      end
    end
  end
end

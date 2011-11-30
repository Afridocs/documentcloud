module Jammit

  module Routes

    # Jammit uses a single route in order to slow down Rails' routing speed
    # by the absolute minimum.
    def self.draw(map)
      map.jammit '/assets/:package.:format', :controller => 'jammit', :action => 'package'
    end

  end

end
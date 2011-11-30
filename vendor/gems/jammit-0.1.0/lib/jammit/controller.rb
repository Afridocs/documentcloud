module Jammit

  class Controller < ActionController::Base

    VERSION_STRIPPER = /-v\d+\Z/

    caches_page :package

    # Dispatch to the appropriate packaging method for the filetype.
    def package
      case params[:format]
      when 'js'
        render :js => Jammit.packager.pack_javascripts(package)
      when 'css'
        render :text => Jammit.packager.pack_stylesheets(package), :content_type => 'text/css'
      when 'jst'
        render :js => Jammit.packager.pack_templates(package)
      else
        unsupported_media_type
      end
    end


    private

    def package
      params[:args].last.sub(VERSION_STRIPPER, '').to_sym
    end

    def unsupported_media_type
      render :text => "Unsupported Media Type: \"#{params[:format]}\"", :status => 415
    end

  end

end

::JammitController = Jammit::Controller
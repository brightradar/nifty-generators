require 'generators/nifty/scaffold/scaffold_generator'

module Nifty
  module Generators
    class AjaxScaffoldGenerator < ScaffoldGenerator
		
  		RAILS_ROOT = File.dirname(File.dirname(__FILE__))
  		ORIG_SCAFFOLD_TEMPLATES_ROOT = "#{RAILS_ROOT}/scaffold/templates"
  		
  		def self.source_paths_for_search
  		  super << ORIG_SCAFFOLD_TEMPLATES_ROOT
  		end
  
      def create_controller
        super
        unless options.skip_controller?
          template "views/#{view_language}/_.html.#{view_language}", "app/views/#{plural_name}/_#{plural_name}.html.#{view_language}"
        end
      end
  		
    end
  end
end

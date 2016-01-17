require 'rails/generators/js/assets/assets_generator'
require 'rails/generators/scss/assets/assets_generator'
require 'rails/generators/rails/resource/resource_generator'

LOCAL_TEMPLATE_PATH = '../../../lib/templates'

module Js
  module Generators
    AssetsGenerator.class_eval do
      source_root File.expand_path(LOCAL_TEMPLATE_PATH, __FILE__)

      JS_MANIFEST = 'app/assets/javascripts/application.es6'
      IMPORTS = "// Import modules\n"
      READY = "// Initialize modules\n"

      source_root Rails.root.join('lib/templates')

      def copy_javascript
        copy_file 'module.es6', full_file_path
        inject_into_file JS_MANIFEST, module_import, after: IMPORTS
        inject_into_file JS_MANIFEST, module_init,   after: READY
      end

      private

      def full_file_path
        Rails.root.join 'app/assets/javascripts', "#{file_name}.es6"
      end

      def module_import
        "import #{file_name} from '#{file_name}';\n"
      end

      def module_init
        "\s\s#{file_name}(event);\n"
      end
    end
  end
end

module Scss
  module Generators
    AssetsGenerator.class_eval do
      CSS_MANIFEST = 'app/assets/stylesheets/application.scss'
      IMPORTS = "// Import modules\n"

      def import_sass
        inject_into_file CSS_MANIFEST, sass_import, after: IMPORTS
      end

      private

      def sass_import
        "@import '#{file_name}';"
      end
    end
  end
end

module Rails
  module Generators
    ResourceGenerator.class_eval do
      source_root File.expand_path(LOCAL_TEMPLATE_PATH, __FILE__)
      FORM_PARTIAL_NAME = '_form.html.slim'

      def copy_form
        template view_template_path, form_view_path
      end

      def generate_policy
        generate 'pundit:policy', file_name
      end

      private

      def view_template_path
        File.join 'slim/scaffold', FORM_PARTIAL_NAME
      end

      def local_template_path
        File.expand_path LOCAL_TEMPLATE_PATH, __FILE__
      end

      def form_view_path
        File.join 'app/views', controller_file_path, FORM_PARTIAL_NAME
      end
    end
  end
end

Rails.application.config.generators do |g|
  g.test_framework :rspec, fixtures: true, fixture_location: "spec/fixtures"
end

module Webhookr
  module Mixpanel
    module Generators

      class MixpanelHooksGenerator < Rails::Generators::Base
        EXAMPLE_HOOK_FILE = 'app/models/mixpanel_hooks.rb'
        source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

        desc "Creates an example ExamplePlugin hook file: '#{EXAMPLE_HOOK_FILE}'"
        def example_hooks
          copy_file( "mixpanel_hooks.rb", EXAMPLE_HOOK_FILE)
        end
      end

    end
  end
end

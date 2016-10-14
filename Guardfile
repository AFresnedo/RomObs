# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

guard :minitest do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  # example of outputting watch results after triggered
  watch(%r{^lib/(.*/)?([^/]+)\.rb$}) do |m|
    "test/#{m[1]}test_#{m[2]}\.rb".tap do |result|
      Guard::UI.info "Sending changes to Minitest: #{result.inspect}"
      Guard::UI.info "The original match is: #{m.inspect}"
    end
  end
  watch(%r{^test/test_helper\.rb$})      { 'test' }
  # my rails projects had thing_test instead of test_thing format
  watch(%r{^test/(.*)\/?(.*)_test\.rb$})
  # to watch files that are not tests you need to watch the file and pass the
  #   test to run with it
  watch(%r{^app/controllers/(.*)_controller\.rb$}) { 'test/integration' }
  watch(%r{^app/models/(.*)\.rb$}) { |m| "test/models/#{m[1]}_test\.rb" }
  watch(%r{^app/helpers/.*\.rb$}) { 'test/integration' }
  watch(%r{^app/views/.*\.erb$}) { 'test/integration' }
  watch('config/routes.rb') { 'test/integration' }
  # with Minitest::Spec
  # watch(%r{^spec/(.*)_spec\.rb$})
  # watch(%r{^lib/(.+)\.rb$})         { |m| "spec/#{m[1]}_spec.rb" }
  # watch(%r{^spec/spec_helper\.rb$}) { 'spec' }
end

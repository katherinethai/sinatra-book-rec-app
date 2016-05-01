require './config/environment'

if ActiveRecord::Migrator.needs_migraion?
  raise 'Migrations are pending. Run 'rake db:migrate' to resolve the issue'
end

use Rack::MethodOverride
run ApplicationController
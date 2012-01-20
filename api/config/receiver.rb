filename = File.join(File.dirname(__FILE__), '../config', 'database.yml')
ActiveRecord::Base.configurations = YAML::load(ERB.new(File.read(filename)).result)
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Goliath.env.to_s])
class DatabaseTypes
  CONFIGURATION_FILE = File.join [Rails.root, 'config', 'database-types.yml']

  def self.all
    @all ||= HashWithIndifferentAccess.new YAML.load_file(CONFIGURATION_FILE)
  end
end
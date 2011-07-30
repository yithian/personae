oauth_keys_file = "#{Rails.root}/config/oauth_keys.yml"

def load_config_yaml filename
  YAML.load(File.read(filename))
end

if File.exist? oauth_keys_file
  SERVICES = load_config_yaml(oauth_keys_file)
  MageHand::Client.set_app_keys SERVICES['obsidianportal']['consumer_key'], SERVICES['obsidianportal']['consumer_secret']
else
  SERVICES = load_config_yaml("#{Rails.root}/config/oauth_keys.yml.example")
end

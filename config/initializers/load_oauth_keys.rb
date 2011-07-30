oauth_keys_file = "#{Rails.root}/config/oauth_keys.yml"

def load_config_yaml filename
  YAML.load(File.read(filename))
end

if File.exist? oauth_keys_file
  keys = load_config_yaml(oauth_keys_file)["obsidianportal"]
else
  keys = load_config_yaml("#{Rails.root}/config/oauth_keys.yml.example")
end

MageHand::Client.set_app_keys keys['consumer_key'], keys['consumer_secret']

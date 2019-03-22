require 'csv'

SHADOW = 'death-star-shadow.txt'
OUTFILE = 'extracted-' + SHADOW
INFO_PATTERN = /^([a-z_0-9-]+):\$\d\$([A-Za-z0-9.\/]+)\$([A-Za-z0-9.\/]+)/

entries = File.read(SHADOW)
entries = entries.split(/\r?\n/)

# 1 = user name
# 2 = salt
# 3 = salted hash

fields = []
entries.each do |e|
  fields.push(INFO_PATTERN.match(e))
end

File.open(OUTFILE, 'w') do |file|
  fields.each { |f| file << f[1] + ' & p & ' + f[3] + ' & ' + f[2] + " \\\\\n\\hline\n" }
end
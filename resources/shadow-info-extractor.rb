require 'csv'

SHADOW = 'death-star-shadow.txt'
OUTFILE = 'extracted-' + SHADOW + '.csv'
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

CSV.open(OUTFILE, 'w') do |csv|
  fields.each { |f| csv << [f[1], f[2], f[3]] }
end
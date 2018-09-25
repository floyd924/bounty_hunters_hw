require_relative('./models/bounty.rb')
require('pry')

# Bounty.delete_all

row1 = Bounty.new({
  'name' => 'River',
  'bounty_value' => 9000,
  'danger_level' => 'high',
  'last_known_location' => 'EH16'
  })

row2 = Bounty.new({
  'name' => 'Riddick',
  'bounty_value' => 7000,
  'danger_level' => 'high',
  'last_known_location' => 'EH10'
  })


row1.save
row2.save

# Bounty.delete_all
###that works, now let's keep River

row1.danger_level = 'medium'

row1.update


###this was me attempting the extension, don't worry about it
#delete_id(18)

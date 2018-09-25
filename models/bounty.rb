require('pg')

class Bounty

  attr_accessor(:name, :bounty_value, :danger_level, :last_known_location)
  attr_reader(:id)

  def initialize(options)
    @id = options['id'].to_i()
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @danger_level = options['danger_level']
    @last_known_location = options['last_known_location']
  end

  def save
    db = PG.connect({dbname: 'bounty_db', host: 'localhost'})
    sql = "
    INSERT INTO bounties(name, bounty_value, danger_level, last_known_location)
    VALUES ($1, $2, $3, $4)
    RETURNING id;
    "
    ####returning the id for practice. I did not understand it in class
    db.prepare('save', sql)
    result = db.exec_prepared('save', [@name, @bounty_value, @danger_level, @last_known_location])
    db.close
    ##i THINK i get where we are now

    ## the id has been returned? now what do we do with it?

    result_hash = result[0]
    #id is first item in array
    string_id = result_hash['id']
    #get id as a string
    id = string_id.to_i()
    #convert it to an integar
    @id = id
    #assign it to an accessible instance variable with @

  end







  def Bounty.delete_all()
    db = PG.connect({
      dbname: 'bounty_db',
      host: 'localhost'
      })

    sql = 'DELETE FROM bounties;'
    db.exec(sql)

    db.close()
  end









  def update()
    db = PG.connect({dbname: 'bounty_db', host: 'localhost'})

    sql = "UPDATE bounties
    SET (name, bounty_value, danger_level, last_known_location) = ($1, $2, $3, $4)
    WHERE id = $5
    "
    values = [@name, @bounty_value, @danger_level, @last_known_location, @id]
    #these are values
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    #values have now been 'filtered' and can go into sql
    #sql executes the update
    db.close()
  end



##########this was tryin to be an extension. It's not worked.

##########forget about this bit and go home


  # def delete_id(id_to_delete)
  #   db = PG.connect({dbname: 'bounty_db', host: 'localhost'})
  #   sql = "
  #   DELETE FROM bounties
  #   WHEN id = $1;
  #   "
  #   value = id_to_delete
  #   db.prepare('delete_id', sql)
  #   db.exec_prepared('delete_id', value)
  #   db.close()
  # end

end

require_relative('../db/sql_helper')

class City

  attr_reader :id
  attr_accessor :name, :country_id

  def initialize(details)
    @id = details["id"].to_i if details["id"]
    @name = details["name"]
    @country_id = details["country_id"]
  end

  def save
    sql = "INSERT INTO city(name, country_id) VALUES($1, $2)

    returning id"
    values = [@name, @country_id]
    result = SqlRunner.run(sql, values)
    @id = result.first()["id"].to_i
  end

  def update
    sql = "UPDATE city SET (name, country_id) = ($1, $2)
    WHERE ID = $3"
    values = [@name, @country_id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM city WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM city WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values).first()
    return City.new(result)
  end

  def self.delete_all
    sql = "DELETE FROM city"
    SqlRunner.run(sql)
  end

end

class DataSource < ActiveRecord::Base

  has_many :queries

  def database_type_enum
    ['postgresql', 'mysql']
  end

  def fetch query_body
  	case self.database_type

  	when 'mysql'

  		client = Mysql2::Client.new(:host => self.host, :username => self.user,
                            :password=> self.password, :database => self.database_name)

    when 'postgresql'
      client = PG::Connection.new(:host => self.host, :user => self.user,
                            :password=> self.password, :dbname => self.database_name)

  	when 'something'
  		raise "something is not a real database"
  	else
  		raise "unknown database"
		end

		client.query(query_body)
  end
end

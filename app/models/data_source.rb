class DataSource < ActiveRecord::Base
  attr_accessible :host, :name, :port, :database_type, :user, :password, :database_name

  has_many :queries

  def database_type_enum
    ['mysql']
  end

  def fetch query_body
  	case self.database_type

  	when 'mysql'

  		client = Mysql2::Client.new(:host => self.host, :username => self.user,
                            :password=> self.password, :database => self.database_name)

  	#	c = ActiveRecord::Base.establish_connection(
	#	  :adapter  => "mysql2",
	#	  :host     => self.host,
	#	  :username => self.user,
	#	  :password => self.password,
	#	  :database => self.database_name
	#	)

  		return client.query(query_body)

  	when 'something'
  		raise "something is not a real database"
  	else
  		raise "unknown database"
  	end
  end

end

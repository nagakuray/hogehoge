require 'pg'
require 'yaml'

dbconf = YAML.load_file("./database.yml")["db"]["development"]
connect =  PG::connect(dbconf)

begin
  results = connect.exec("SELECT current_date hoge")
  results.each{|result|
    p result["hoge"]
  }
ensure
  connect.finish
end

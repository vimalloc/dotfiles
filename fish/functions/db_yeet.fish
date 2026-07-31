function db_yeet --wraps='rake db:drop db:create db:schema:load db:seed' --description 'alias db_yeet=rake db:drop db:create db:schema:load db:seed'
  rake db:drop db:create db:schema:load db:seed $argv
        
end

function migrate --wraps='bin/rails db:migrate && bin/rails db:test:prepare' --description 'alias migrate=bin/rails db:migrate && bin/rails db:test:prepare'
  bin/rails db:migrate && bin/rails db:test:prepare $argv
        
end

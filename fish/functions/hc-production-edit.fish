function hc-production-edit --wraps='TERM=xterm-color heroku run -r heroku -- console --no-sandbox' --description 'alias hc-production-edit=TERM=xterm-color heroku run -r heroku -- console --no-sandbox'
  TERM=xterm-color heroku run -r heroku -- console --no-sandbox $argv
        
end

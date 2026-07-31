function hc-read --wraps='TERM=xterm-color heroku run -r heroku -- console --sandbox' --description 'alias hc-read=TERM=xterm-color heroku run -r heroku -- console --sandbox'
  TERM=xterm-color heroku run -r heroku -- console --sandbox $argv
        
end

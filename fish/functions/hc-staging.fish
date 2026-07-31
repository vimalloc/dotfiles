function hc-staging --wraps='TERM=xterm-color heroku run -r staging -- console --no-sandbox' --description 'alias hc-staging=TERM=xterm-color heroku run -r staging -- console --no-sandbox'
  TERM=xterm-color heroku run -r staging -- console --no-sandbox $argv
        
end

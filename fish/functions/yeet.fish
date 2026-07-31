function yeet --wraps='rake db:drop db:create db:schema:load db:seed && redis flushall && rake cache:clear && rm -rf node_modules && rake assets:clean assets:clobber && yarn && bundle install --redownload' --description 'alias yeet=rake db:drop db:create db:schema:load db:seed && redis flushall && rake cache:clear && rm -rf node_modules && rake assets:clean assets:clobber && yarn && bundle install --redownload'
  rake db:drop db:create db:schema:load db:seed && redis flushall && rake cache:clear && rm -rf node_modules && rake assets:clean assets:clobber && yarn && bundle install --redownload $argv
        
end

function ghpush
  set -l bookmark_name $(jj log --no-graph -r @ -T 'bookmarks')

  if not string length -q "$bookmark_name"
    echo "Can't push a bookmark if you're not on '@' and a bookmark does not exist there. Silly"
    return 1
  end

  jj git push --bookmark "$bookmark_name"
end

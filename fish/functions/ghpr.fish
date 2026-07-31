function ghpr
  set -l bookmark_name $(jj log --no-graph -r @ -T 'bookmarks')

  if not string length -q "$bookmark_name"
    echo "Attempting to create a pr not on a bookmark. Dont do that. Silly Lily"
    return 1
  end

  gh pr create --fill --draft --assignee "@me" --head "$bookmark_name" $argv
end

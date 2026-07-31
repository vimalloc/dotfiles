function lily_jj_prompt
  if not jj root > /dev/null 2>&1
    return 1
  end

  set -l bookmark_name $(jj log --no-graph -r @ -T 'bookmarks')
  set -l change_id_name $(jj log --no-graph -r @ -T 'change_id.short()')

  if string length -q "$bookmark_name"
    printf ' %s' $bookmark_name
  else
    printf ' %s' $change_id_name
  end
end

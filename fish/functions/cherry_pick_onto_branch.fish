function cherry_pick_onto_branch --description 'cherry_pick_onto_branch'
  set GIT_BRANCH $(git rev-parse --abbrev-ref HEAD)
  set GIT_COMMIT $(git rev-parse HEAD)

  git coi
  git pull
  git branch -D "$GIT_BRANCH"
  git co -b "$GIT_BRANCH"
  git cherry-pick "$GIT_COMMIT"

end

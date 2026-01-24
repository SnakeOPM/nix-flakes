# ~/.zsh/plugins/git-sync/git-sync.plugin.zsh
# Define the main function
mkrelprep() {
    # Handle -f flag
    case "$1" in
        -f)
            local force_push="-f"
            shift
            local bump_version="${1:-}"
            ;;
        *)
            local force_push="false"
            local bump_version="$1"
            ;;
    esac

    # Store current branch for later use
    local CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

    if [[ "$CURRENT_BRANCH" == "master" ]]; then
        echo "❌ You are on master. Aborting merge."
        return 1
    fi

    # Step 1: Pull origin master
    echo "Pulling origin master..."
    if ! git checkout master; then
        echo "Failed to checkout into master"
        return 1
    fi
    if ! git pull origin master; then
        echo "Failed to pull origin master"
        return 1
    fi

    # Step 2: Rebase current branch with origin master
    echo "Rebasing current branch with origin master..."
    if ! git checkout $CURRENT_BRANCH; then
        echo "Can't rebase in previous branch"
    fi
    if ! git rebase origin/master; then
        echo "Failed to rebase with origin master"
        git rebase --abort
        return 1
    fi

    # Step 3: Push changes
    if [[ -v force_push && "$force_push" == "-f" ]]; then
      echo "Pushing changes to remote..."
      if ! eval " git push origin $CURRENT_BRANCH -f"; then
          echo "Failed to push changes"
          return 1
      fi
    fi
    

    # Step 4: Checkout master
    echo "Checking out master branch..."
    if ! git checkout master; then
        echo "Failed to checkout master"
        return 1
    fi

    # Step 5: Merge with no-ff flag
    echo "Merging $CURRENT_BRANCH into master with --no-ff..."
    if ! git merge -m "Merge branch \"$CURRENT_BRANCH\"" --no-ff "$CURRENT_BRANCH"; then
        echo "Failed to merge $CURRENT_BRANCH into master"
        git merge --abort
        return 1
    fi

    # Step 6: Run bump with provided argument
    echo "Running bump with argument: ${bump_version:-'no version specified'}"
    if ! bump "$bump_version"; then
        echo "Failed to run bump command"
        return 1
    fi

    echo "✅ Successfully completed mkrelprep!"
}

# Usage examples:
# Standard usage:
# mkrelprep [options] <version>

# Options:
# -f | --force      Use force push
# -h | --help       Show this help message

# Example usage:
# mkrelprep patch -f
#!/bash/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# enable bash completion in interactive shells
if ! shopt -oq posix; then
 if [ -f /usr/share/bash-completion/bash_completion ]; then
   . /usr/share/bash-completion/bash_completion
 elif [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
 fi
fi

# redefine prompt_context to display devcontainer name
function prompt_context() {
  in_git_repo=$(git rev-parse --is-inside-work-tree 2>/dev/null)
  if [ -n "$in_git_repo" ]; then
    repo_path=$(git rev-parse --show-toplevel)
    repo_name=$(basename "$repo_path")
  else
    repo_name=''
  fi
  name="${DK_CONTAINER_NAME:-devcontainer}"
  version="${DK_CONTAINER_VERSION:-NOT_SET}"
  if [ "$version" != "NOT_SET" ]; then
    version="${version/0.0.0-/}"
    if [[ "$version" == local* ]]; then
      version="[DEV]"
    fi
    name="$name@$version"
  fi
  prompt_segment black default "$name"
  if [ -n "$repo_name" ]; then
    prompt_segment green default "$repo_name"
  fi
}

# Dir: current working directory
function prompt_dir {
  repo_path="$CONTAINER_WORKSPACE"
  current_path="${PWD/"$repo_path"/^}"
  if [ "$current_path" != '^' ]; then
    prompt_segment blue default "$current_path"
  fi
}

# no need to show python venv in prompt
unset OMB_PROMPT_SHOW_PYTHON_VENV

repo_name="${REPO_NAME:-}"
if [ -n "$CONTAINER_WORKSPACE" ]; then
  repo_name=$(basename "$CONTAINER_WORKSPACE")
  alias cd='HOME=$CONTAINER_WORKSPACE cd'
fi
export VIRTUAL_ENV="/opt/uv/${repo_name}"
if [ ! -d "$VIRTUAL_ENV" ]; then
  uv venv "$VIRTUAL_ENV"
fi
export UV_PROJECT_ENVIRONMENT="$VIRTUAL_ENV"
export PATH="$VIRTUAL_ENV/bin:$PATH"
. "$VIRTUAL_ENV/bin/activate"

if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  source "$HOME/.nvm/nvm.sh"
fi

path_add "$HOME/.local/bin"
path_add "$HOME/.composer/vendor/bin"
path_add "$HOME/go/bin"
path_add "$HOME/.cargo/bin"


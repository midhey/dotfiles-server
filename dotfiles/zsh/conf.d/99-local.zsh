for file in "$HOME"/.config/zsh/local/*.zsh(N); do
  [[ -r "$file" ]] && source "$file"
done


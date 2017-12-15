function colors
  sed -E -i .old "s/^colors:.+\$/colors: *$argv[1]/" ~/.config/alacritty/alacritty.yml
end

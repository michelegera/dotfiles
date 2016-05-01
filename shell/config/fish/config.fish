# Required if fish < 2.3
# https://github.com/fisherman/fisherman#1-what-is-the-required-fish-version
for file in ~/.config/fish/conf.d/*.fish
  source $file
end

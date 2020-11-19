# Alias Homebrew’s pip3

function pip --wraps=/usr/local/bin/pip3
  /usr/local/bin/pip3 $argv;
end

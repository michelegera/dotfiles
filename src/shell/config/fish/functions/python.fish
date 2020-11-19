# Alias Homebrew’s Python

function python --wraps=/usr/local/bin/python3
  /usr/local/bin/python3 $argv;
end

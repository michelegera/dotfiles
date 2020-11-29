function cp --wraps=cp
  command cp -iv $argv;
#             │└─ list copied files
#             └─ prompt before overwriting an existing file
end

function mv --wraps=mv
  command mv -iv $argv;
#             │└─ list copied files
#             └─ prompt before overwriting an existing file
end

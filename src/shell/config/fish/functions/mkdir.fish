function mkdir --wraps=mkdir
  command mkdir -pv $argv;
#                │└─ list created directories
#                └─ create intermediate directories
end

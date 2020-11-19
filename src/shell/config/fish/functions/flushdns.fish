function flushdns
  sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder;
end

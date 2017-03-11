function apply_cmd() {
  local cmd=$@

  osascript \
    -e 'tell application "Terminal"' \
      -e "do script \"$cmd\" in window 1 " \
      -e 'set terms to every window in application "Terminal"' \
      -e 'repeat with term in terms' \
        -e 'set tTabs to every tab in term' \
        -e 'repeat with tTab in tTabs' \
          -e 'if tTab is not busy then' \
            -e "do script \"$cmd\" in tTab" \
          -e 'end if' \
        -e 'end repeat' \
      -e 'end repeat' \
    -e 'end tell' 
}

apply_cmd $@

 #!/usr/bin/env ruby

if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

rubocop app/

bundle exec rake test

open coverage/index.html

$LOAD_PATH << "lib"
$LOAD_PATH << "models"

# require 'environment'
# Environment.environment = "test"

require 'wheels'

def menu
<<EOS
How_iRoll is a fun little app to help log your journies... on wheels.
If you are walking or flying you can walk or fly on to the next app buddy.
At any time type "opt" for available options
Ask yourself this first question and use the options above to answer...
Do you ever wonder...

How_iRoll?
EOS
end

def get_menu_selection
  puts menu
end

 #!/usr/bin/env ruby

def menu

<<EOS
How_iRoll is a fun little app to help log your journies... on wheels.
If youre walking or flying you can walk or fly on to the next app buddy.
At any type "opt" for available options or enter new options by typing
'enter'...  i.e. available options for our first question are: 'bike' or
'bicycle'; 'sd' or 'Sunday driver'; skate or 'skateboard'; 'moto' or
'motorcycle'; 'hid' or 'hidden options'.

Do you ever wonder...

How_iRoll?
EOS

end

def get_menu_selection
  puts menu
end

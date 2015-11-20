some_var = "false"
another_var = "nil"

case some_var
when "pink elephant"
  puts "Don't think about the pink elephant!"

when nil
  puts "Question mark in the method name?"

when false
  puts "Looks like this one should execute"

else
  puts "I guess nothing matched... But why?"
end

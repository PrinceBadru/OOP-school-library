def obtain_parent_permission
  puts 'Has parent permission? [Y / N]: '
  parent_permission = gets.chomp.to_s.capitalize

  case parent_permission
  when /^[Yy]/
    true
  when /^[Nn]/
    false
  else
    puts "Invalid choice. Please enter a valid option. (#{parent_permission})"
    obtain_parent_permission
  end
end

def get_user_input(prompt)
  puts prompt
  gets.chomp
end

def get_user_input_integer(prompt)
  get_user_input(prompt).to_i
end

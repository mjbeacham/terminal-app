require 'json'
require 'digest'
require 'colorize'

class Bus
  @@alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

end

# this is the main menu of the app
loop do
  puts '1. View available seats'
  puts '2. Reserve seats'
  puts '3. View help'
  puts '4. Exit'

  puts 'Please select (1-4): '
  choice = gets.chomp

  case choice
  when '1'
    puts 'Available seats here'
  when '2'
    puts 'Reverse seats here'
  when '3'
    puts 'Help details here'
  when '4'
    puts 'Thank you fopr using the bus seat allocation tool! Goodbye'
    break
  else
    puts 'Invalid choice. Please try again using only a number.'
  end
end

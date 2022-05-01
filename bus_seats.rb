require './bus'
require 'colorize'

$bus = Bus.load('bus.json')

# this is the main menu of the app
def main_menu
  loop do
    puts '1. View available seats'
    puts '2. Reserve seats'
    puts '3. Check ticket'
    puts '4. Exit'

    puts 'Please select (1-4): '
    choice = gets.chomp

    case choice
    when '1'
      $bus.draw
    when '2'
      booking_menu
    when '3'
      ticket_check
    when '4'
      puts 'Thank you for using the bus seat allocation tool! Goodbye'
      break
    when 'Top Secret'
      admin_reset
    else
      puts 'Invalid choice. Please try again using only a number.'
    end
  end
end

# method for booking available seats and writing the data to bus.JSON
def booking_menu
  loop do
    puts 'Please choose a seat(s)'
    $bus.draw
    seat_choice = gets.chomp.to_s
    booking_success = $bus.book(seat_choice.upcase)
    $bus.save('bus.json') if booking_success
    break
  end
end

# method for checking given ticket number against bus.JSON and outputting whether the ticket is valid and what your seat number is
def ticket_check
  loop do
    puts 'Please enter your ticket number'
    $bus.draw
    ticket_number = gets.chomp.to_s
    $bus.check(ticket_number.upcase)
    break
  end
end

# secret menu command, used to wipe all existing data in bus.JSON
def admin_reset
  $bus = Bus.new(8, 4, {})
  $bus.save('bus.json')
  puts 'Seat allocation has been reset'.green
end

main_menu
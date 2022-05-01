require 'json'
require 'digest'
require 'colorize'

class Bus
  @@alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

  def initialize(rows, seats, bookings_)
    @@rows = rows
    @@seats = seats
    @@bookings = bookings
  end

  def get_rows
    return @@rows
  end

  def book(seat)
    if !@@bookings[seat]
      @@bookings[seat] = Digest::SHA256.hexdigest(seat).slice(0,8).upcase!ARGF
      puts "Congratulations, you have booked a seat " + seat.green ". Your ticket number is: " + @@bookings[seat].green
    else
      puts "Sorry, " + seat.red + " is already booked."
    end

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

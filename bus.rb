require 'json'
require 'digest'
require 'colorize'

class Bus
  @@alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

  def initialize(rows, seats, bookings)
    @@rows = rows
    @@seats = seats
    @@bookings = bookings
  end

  def get_rows
    @@rows
  end

  def book(seat)
    seat_letter = seat[0]
    seat_row = seat[1].to_i
    seat_letter_index = @@alphabet.index(seat_letter)
    if seat_row < 1 || seat_row > @@rows || !seat_letter_index || seat_letter_index > @@seats - 1 || seat.length > 2
      puts 'Sorry, ' + seat.red + ' this seat is invalid'
      return false
    end
    if !@@bookings[seat]
      puts seat
      @@bookings[seat] = Digest::SHA256.hexdigest(seat).slice(0, 8).upcase
      puts 'Congratulations, you have booked seat ' + seat.green + '. Your ticket number is: ' + @@bookings[seat].green
      true
    else
      puts 'Sorry, ' + seat.red + ' is already booked.'
      false
    end
  end

  def check(ticket)
    booking = @@bookings.key(ticket)
    if booking
      puts 'You are booked in for seat ' + booking.green + '.'
      true
    else
      puts 'Sorry, booking not found.'
      false
    end
  end

  # Call this after updating to save the current bookings to JSON
  def save(filename)
    File.open(filename, 'w') do |f|
      f.write(JSON.pretty_generate({ 'rows' => @@rows, 'seats' => @@seats, 'bookings' => @@bookings }))
    end
  end

  # Load bookings from JSON
  def self.load(filename)
    bus_data = JSON.parse(File.read(filename))
    throw 'Invalid number of rows' unless bus_data['rows']
    throw 'Invalid number of seats' unless bus_data['seats']
    Bus.new(bus_data['rows'], bus_data['seats'], bus_data['bookings'] || {})
  end

  def draw
    half = @@seats / 2
    divider = '+'
    for x in 1..half do
      divider += '--+'
    end
    divider += '-+'
    for x in 1..half do
      divider += '--+'
    end
    puts divider
    for i in 1..@@rows do
      str = '|'
      count = 0
      for seat in 0..@@seats - 1 do
        count += 1
        seatname = @@alphabet[seat] + i.to_s
        str += if !@@bookings[seatname]
                 seatname.yellow + '|'
               else
                 'XX'.blue + '|'
               end
        str += '-|' if count == half
      end
      puts str
    end
    puts divider
  end
end

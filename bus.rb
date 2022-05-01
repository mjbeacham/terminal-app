require 'json'
require 'digest'
require 'colorize'


class Bus
    @@alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
    def initialize(rows, seats, bookings)
        @@rows = rows
        @@seats = seats
        @@bookings = bookings
    end

    def get_rows
        return @@rows
    end

    def book(seat)
        if !@@bookings[seat]
          puts seat
            @@bookings[seat] = Digest::SHA256.hexdigest(seat).slice(0,8).upcase
            puts "Congratulations, you have booked seat " + seat.green + ". Your ticket number is: " + @@bookings[seat].green
            return true
        else
            puts "Sorry, " + seat.red + " is already booked."
            return false
        end
    end

    def check(ticket)
        booking = @@bookings.key(ticket)
        if booking
            puts "You are booked in for seat " + booking.green + "."
            return true
        else
            puts "Sorry, booking not found."
            return false
        end
    end

    # Call this after updating to save the current bookings to JSON
    def save(filename)
        File.open(filename,"w") do |f|
            f.write(JSON.pretty_generate({"rows" => @@rows, "seats" => @@seats, "bookings" => @@bookings}))
        end
    end

    # Load bookings from JSON
    def self.load(filename)
        bus_data = JSON.parse(File.read(filename))
        if !bus_data['rows'] 
            throw "Invalid number of rows"
        end
        if !bus_data['seats'] 
            throw "Invalid number of seats"
        end
        return Bus.new(bus_data['rows'], bus_data['seats'], bus_data['bookings'] || {})
    end

    def draw()
        half = @@seats/2;
        divider = "+"
        for x in 1..half do
            divider+="--+"
        end
        divider+="-+"
        for x in 1..half do
            divider+="--+"
        end
        puts divider
        for i in 1..@@rows do
            str = "|"
            count = 0;
            for seat in 0..@@seats-1 do
                count+=1
                seatname = @@alphabet[seat] + i.to_s;
                if !@@bookings[seatname]
                    str+=seatname.yellow+"|"
                else 
                    str+="XX".blue + "|"
                end
                if count == half
                    str+="-|"
                end
            end
            puts str
        end
        puts divider
    end
end
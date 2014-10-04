require_relative 'cs_air_lib'

class CSAirUI

  # method to initialize the CS Air UI class
  def initialize

    # the source library for CS Air
    @ui_lib = CSAirLib.new

    #dictionary for number commands to info key
    @num_to_info_key = {
        1=> 'code',
        2=> 'name',
        3=> 'country',
        4=> 'continent',
        5=> 'timezone',
        6=> 'coordinates',
        7=> 'population',
        8=> 'region',
        9=> 'list of accessible cities'
    }

    # dictionary for ease of printing commands
    @num_to_detail = {
        1=> 'The longest single flight in the network',
        2=> 'The shortest single flight in the network',
        3=> 'The average distance of all the flights in the network',
        4=> 'The biggest city (by population) served by CSAir',
        5=> 'The smallest city (by population) served by CSAir',
        6=> 'The average size (by population) of all the cities served by CSAir',
        7=> 'A list of the continents served by CSAir and which cities are in them',
        8=> 'Identifying hub cities the cities that have the most direct connections',
    }

    # dictionary for num to command
    @num_to_command = {
        1=> 'exit',
        2=> 'list of all the cities that CS Air flies to.',
        3=> 'specific details about a city',
        4=> 'statistical details about CS Air',
        5=> 'visualizing graph'
    }

  end

  # helper method for main_run, produces UI for city specific details
  def city_specific_run

    puts 'You want city specific details'
    puts 'Type the name of the city that you want'
    city = gets.chomp

    # wait till you receive a correct input
    while not @ui_lib.query.city_to_code.has_key?(city)
      puts 'Please try again'
      city = gets.chomp
    end

    puts "You selected #{city}"
    puts "What information do you want about #{city}"

    city = @ui_lib.query.city_to_code[city] #changed the string to its code form

    @num_to_info_key.each {|num,infoKey| puts "Type #{num} for #{infoKey}"}
    command = gets.chomp.to_i

    while not @num_to_info_key.has_key?(command)
      puts 'Please try again'
      command = gets.chomp.to_i
    end

    if command == 9
      puts "#{@ui_lib.get_outgoing_routes(city)}"
    else
      puts "#{@ui_lib.get_city_info(city, @num_to_info_key[command])}"
    end

  end

  # helper method for main_run, produces UI for statistic details
  def statistic_run

    puts 'You want statistics about CS Air'

    # print out what to type in for each command
    @num_to_detail.each { |num, string| puts "Type #{num} for #{string}" }
    
    command = gets.chomp.to_i

    # wait till you receive correct input
    while not @num_to_detail.has_key?(command)
      puts 'Please try again'
      command = gets.chomp.to_i
    end
    
    case
      when command == 1
        puts "#{@ui_lib.longest_single_flight}"
      when command == 2
        puts "#{@ui_lib.shortest_single_flight}"
      when command == 3
        puts "#{@ui_lib.average_flight_length}"
      when command == 4
        puts "#{@ui_lib.biggest_population_city}"
      when command == 5
        puts "#{@ui_lib.smallest_population_city}"
      when command == 6
        puts "#{@ui_lib.average_population}"
      when command == 7
        @ui_lib.list_of_continents.each {|continent, list| puts "#{continent},#{list}"}
      when command == 8
        puts "#{@ui_lib.list_of_hubs}"
    end

  end


  # main loop of the UI
  def main_run

    reset = true #flag to now if you want to exit or not

    while reset

      puts 'Welcome to CS Air.'

      @num_to_command.each {|num,cmd| puts "Type #{num} for #{cmd}"}
      command = gets.chomp.to_i

      while not @num_to_command.has_key?(command)
        puts 'Please try again'
        command = gets.chomp.to_i
      end

      case
        when command == 1
          reset = false #user wants to exit
          next
        when command == 2
          @ui_lib.print_city_list #print out list of all the cities
          next
        when command == 3
          city_specific_run #city specific details
          next
        when command == 4
          statistic_run #CS Air statistic details
          next
        when command == 5
          system('open', @ui_lib.query.get_map_url)
          next
      end
    end
  end

end

ui = CSAirUI.new
ui.main_run
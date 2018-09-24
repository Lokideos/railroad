require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'passenger_train'

class RailroadUI
  RAILROAD_MAIN_MENU_OPTIONS = {
    1 => "Manage trains",
    2 => "Manage stations",
    3 => "Manage routes",
    4 => "Manage cars.",
    5 => "Exit the application."
  }

  TRAIN_UI_MENU_OPTIONS = {
    1 => "Add new train.",
    2 => "Increase train speed.",
    3 => "Show current train speed.",
    4 => "Decrease train speed.",
    5 => "Show attached cars.",
    6 => "Attach car.",
    7 => "Detach car.",
    8 => "Assign route.",
    9 => "Move on route.",
    10 => "Show nearby stations",
    11 => "Show all existing trains",
    12 => "Manage attached cars",
    13 => "Back to Railroad application main menu."
  }

  STATION_UI_MENU_OPTIONS = {
    1 => "Add new station.",
    2 => "Assign train to station.",
    3 => "Delete train from station.",
    4 => "Show trains on station.",
    5 => "Show trains on station by type.",
    6 => "Show existing stations.",
    7 => "Back to Railroad application main menu."
  }

  ROUTE_UI_MENU_OPTIONS = {
    1 => "Add new route.",
    2 => "Add station to route.",
    3 => "Delete station from route.",
    4 => "Show stations on route.",
    5 => "Show all existing routes.",
    6 => "Back to Railroad application main menu."
  }

  CAR_UI_MENU_OPTIONS = {
    1 => "Add car",
    2 => "Back to Railroad application main menu."
  }

  def self.show_menu
    loop do
      case RailroadUI.run_sub_menu(RAILROAD_MAIN_MENU_OPTIONS)

      #trains section
      when 1
        loop do
          puts
          case RailroadUI.run_sub_menu(TRAIN_UI_MENU_OPTIONS)
          when 1
            puts %q(
            In order to create new train
            you have to type in train's number,
            type, which have to be 'cargo' or 'passenger'
            and manufacturer (optional) in the respective order:
            )
            begin
              number = gets.chomp
              type = gets.chomp
              manufacturer = gets.chomp
              manufacturer = "Undefined" unless manufacturer != ""
              type == "passenger" ? PassengerTrain.new(number, manufacturer) : CargoTrain.new(number, manufacturer)
            rescue RuntimeError => e
              puts "There is an error with your data: #{e.message}."
            end
          when 2
            chosen_train = find_train

            #find a way to move nil check to private methods
            unless chosen_train
              puts
              puts "Train with this number does not exist."
              puts
              break
            end

            puts "Train's speed has been successfully increased by 10."
            chosen_train.increase_speed
          when 3
            chosen_train = find_train
            #find a way to move nil check to private methods
            unless chosen_train
              puts
              puts "Train with this number does not exist."
              puts
              break
            end

            print "Train's current speed:"
            puts chosen_train.speed
          when 4
            chosen_train = find_train
            #find a way to move nil check to private methods
            unless chosen_train
              puts
              puts "Train with this number does not exist."
              puts
              break
            end

            puts "Train's speed has been successfully decreased by 10."
            chosen_train.decrease_speed
          when 5
            chosen_train = find_train
            #find a way to move nil check to private methods
            unless chosen_train
              puts
              puts "Train with this number does not exist."
              puts
              break
            end

            puts "Train's current attached cars:"
            chosen_train.cars_to_block { |car| puts "#{car.number}: #{car.class}."}
          when 6
            chosen_train = find_train
            #find a way to move nil check to private methods
            unless chosen_train
              puts
              puts "Train with this number does not exist."
              puts
              break
            end

            puts "List of available cars:"
            Car.all.each { |car| puts "#{car.number}" }
            puts
            puts "Please type in number of car you want to operate with:"
            chosen_car = gets.chomp
            chosen_car = Car.all.find { |car| car.number == chosen_car }

            if chosen_train.train_stopped? && chosen_train.same_type_with_car?(chosen_car)
              puts "Car has been successfully attached to this train."
              chosen_train.attach_car(chosen_car)
            else
              puts "Speed of the train is too high for this operation or car you want to operate with does not exist."
            end
          when 7
            chosen_train = find_train
            #find a way to move nil check to private methods
            unless chosen_train
              puts
              puts "Train with this number does not exist."
              puts
              break
            end

            puts "List of available cars:"
            chosen_train.cars.each { |car| puts "#{car.number}"}
            puts
            puts "Please type in number of car you want to operate with:"
            chosen_car = gets.chomp
            chosen_car = chosen_train.cars.find { |car| car.number == chosen_car }
            if chosen_train.train_stopped? && chosen_train.same_type_with_car?(chosen_car)
              puts "Car has been successfully detached from this train."
              chosen_train.detach_car(chosen_car)
            else
              puts "Speed of the train is too high for this operation or car you want to operate with does not exist."
            end
          when 8
            chosen_train = find_train
            #find a way to move nil check to private methods
            unless chosen_train
              puts
              puts "Train with this number does not exist."
              puts
              break
            end

            puts "Please type in name of route you want to assign to this train."
            puts "List of existing routes:"
            Route.existing_routes.each { |route| puts route.name }
            chosen_route = gets.chomp
            chosen_route = Route.existing_routes.find { |route| route.name == chosen_route }
            if chosen_route.class.to_s == "Route"
              chosen_train.assign_route(chosen_route)
              puts "Route has been successfully assigned to this train."
            else
              puts "Route with this name does not exists."
            end
          when 9
            chosen_train = find_train
            #find a way to move nil check to private methods
            unless chosen_train
              puts
              puts "Train with this number does not exist."
              puts
              break
            end

            if chosen_train.route
              puts "Please type in direction in which you want to move on the current route."
              direction = gets.chomp
              chosen_train.move_forward_on_route if direction == "forward"
              chosen_train.move_back_on_route if direction == "back"
            else
              puts "Route has not been assigned to this train."
            end
          when 10
            chosen_train = find_train
            #find a way to move nil check to private methods
            unless chosen_train
              puts
              puts "Train with this number does not exist."
              puts
              break
            end

            if chosen_train.route
              puts "List of nearby stations on the route:"
              chosen_train.neighbors_station.each { |station| puts station.name }
            else
              puts "Route has not been assigned to this train."
            end
          when 11
            puts "List of trains created so far:"
            Train.all.each { |number, train| puts number }
            puts
          when 12
            chosen_train = find_train
            #find a way to move nil check to private methods
            unless chosen_train
              puts
              puts "Train with this number does not exist."
              puts
              break
            end

            puts "List of cars connected to this train:"
            chosen_train.cars_to_block { |car| puts "#{car.number}: #{car.class}."}
            puts
            puts "Type in number of car you want to operate with:"
            puts
            number = gets.chomp
            car = chosen_train.cars.find { |car| number == car.number }

            if car.nil?
              puts "Car with this number does not exist."
              break
            else
              if car.class.to_s == "PassengerCar"
                puts "Please type in 'take' if you want to take seat in car, 'show' if you want to see free places."
                choice = gets.chomp
                case choice
                when "take"
                  car.take_seat
                when "show"
                  puts car.free_seats
                else
                  puts "You've typed incorrect action."
                  break
                end
              else
                puts "Please type in 'load' if you want to load something in car, 'show' if you want to check free volume"
                choice = gets.chomp
                case choice
                when "load"
                  puts "Please type in volume of your goods:"
                  volume = gets.chomp.to_f
                  car.load(volume)
                when "show"
                  puts car.free_volume
                else
                  puts "You've typed incorrect action."
                  break
                end
              end
            end


          when 13
            puts
            break
          else
            RailroadUI.option_does_not_exist
          end
        end

      #stations section
      when 2
        loop do
          puts
          case RailroadUI.run_sub_menu(STATION_UI_MENU_OPTIONS)
          when 1
            begin
              puts "Please type in name of a station."
              name = gets.chomp
              Station.new(name)
            rescue RuntimeError => e
              puts "There is an error with your data: #{e.message}."
            end
          when 2
            chosen_station = find_station

            #find a way to move nil check to private methods
            unless chosen_station
              puts
              puts "Station with this name does not exist."
              puts
              break
            end

            puts "Please type in number of arriving train."
            number = gets.chomp
            chosen_train = Train.find(number)
            chosen_station.arrival_of_train(chosen_train)
          when 3
            chosen_station = find_station

            #find a way to move nil check to private methods
            unless chosen_station
              puts
              puts "Station with this name does not exist."
              puts
              break
            end

            puts "Please type in number of departuring train."
            number = gets.chomp
            chosen_train = chosen_station.trains.find { |train| train.number == number }
            chosen_station.departure_of_train(chosen_train) if chosen_train
          when 4
            chosen_station = find_station

            #find a way to move nil check to private methods
            unless chosen_station
              puts
              puts "Station with this name does not exist."
              puts
              break
            end

            puts "There are several trains arrived on the station now:"
            chosen_station.trains_to_block { |train| puts "#{train.number}: #{train.class}" }
          when 5
            chosen_station = find_station

            #find a way to move nil check to private methods
            unless chosen_station
              puts
              puts "Station with this name does not exist."
              puts
              break
            end

            puts "Now you will be given information about arrived on current station trains of specific type."
            puts "Please type in desired type of trains you want to check:"
            chosen_type = gets.chomp
            chosen_station.trains.each { |train| puts train.number if train.type == chosen_type }
          when 6
            puts "List of stations created so far:"
            Station.all.each { |station| puts station.name }
            puts
          when 7
            puts
            break
          else
            RailroadUI.option_does_not_exist
          end
        end

      #routes section
      when 3
        loop do
          puts
          case RailroadUI.run_sub_menu(ROUTE_UI_MENU_OPTIONS)
          when 1
            puts "List of existing stations:"
            RailroadUI.show_existing_stations
            puts %q(
            Please type in names of first station of the route and last station of the route 
            in the respective order.
            )
            begin
              first_station = gets.chomp
              second_station = gets.chomp
              first_station = Station.all.find { |station| station.name == first_station }
              second_station = Station.all.find { |station| station.name == second_station }
              if first_station.class.to_s == "Station" && second_station.class.to_s == "Station"
                Route.new(first_station, second_station)
                puts "Route has been succesfully created."
              else
                puts "You typed in wrong station names. Please try again."
              end
            rescue RuntimeError => e
              puts "There is an error in your data: #{e.message}."
            end
          when 2
            chosen_route = find_route

            #find a way to move nil check to private methods
            unless chosen_route
              puts
              puts "Route with this name does not exist."
              puts
              break
            end

            puts "List of existing stations:"
            RailroadUI.show_existing_stations
            puts "Please type in name of the station you want to add to the route."
            chosen_station = gets.chomp
            chosen_station = Station.all.find { |station| station.name == chosen_station }
            if chosen_station.class.to_s == "Station"
              puts "Station has been succesfully added to route."
              chosen_route.add_station(chosen_station)
            else
              puts "You typed in wrong station names. Please try again."
            end
          when 3
            chosen_route = find_route

            #find a way to move nil check to private methods
            unless chosen_route
              puts
              puts "Route with this name does not exist."
              puts
              break
            end

            RailroadUI.show_stations_on_route(chosen_route)
            puts "Please type in name of station you want to delete:"
            chosen_station = gets.chomp
            chosen_station = chosen_route.stations.find { |station| station.name == chosen_station }
            if chosen_station.class.to_s == "Station" 
              puts "Station has been succesfully deleted from the route."
              chosen_route.stations.each { |station| chosen_route.remove_station(chosen_station) }
            else
              puts "You typed in wrong station names. Please try again."
            end
          when 4
            chosen_route = find_route

            #find a way to move nil check to private methods
            unless chosen_route
              puts
              puts "Route with this name does not exist."
              puts
              break
            end

            RailroadUI.show_stations_on_route(chosen_route)
          when 5
            puts "List of existing routes:"
            Route.existing_routes.each { |route| puts route.name }
            puts
          when 6
            puts
            break
          else
            RailroadUI.option_does_not_exist
            puts
          end
        end

      #car section
      when 4
        loop do
          case RailroadUI.run_sub_menu(CAR_UI_MENU_OPTIONS)
          when 1
            begin
              puts "Please type in new car number, type and manufacturer in the respective order:"
              number = gets.chomp
              type = gets.chomp
              manufacturer = gets.chomp
              manufacturer = "Undefined" unless manufacturer != ""

              if type == "passenger"
                puts "Please type in maximum seats quantity for this car."
                max_seats = gets.chomp
                PassengerCar.new(number, manufacturer, max_seats)
              else
                puts "please type in maximum volume for this car."
                max_volume = gets.chomp
                CargoCar.new(number, manufacturer, max_volume)
              end
            rescue RuntimeError => e
              puts "There is an error with your data: #{e.message}."
            end
          when 2
            puts
            break
          else
            RailroadUI.option_does_not_exist
            puts
          end
        end

      when 5
        puts
        break
      else
        RailroadUI.option_does_not_exist
      end
    end
  end

  private

  def self.run_sub_menu(options)
    options.each do |key, value|
      puts "#{key}: #{value}"
    end

    puts "Please choose desired option:"
    gets.chomp.to_i
  end

  def self.option_does_not_exist
    puts "Such option does not exist"
    puts
  end

  def self.find_train
    puts "Please type in number of a train."
    number = gets.chomp
    chosen_train = Train.find(number)
  end

  def self.find_station
    puts "Please type in name of a station."
    name = gets.chomp
    chosen_station = Station.all.find { |station| station.name == name }
  end

  def self.show_existing_stations
    Station.all.each { |station| puts station.name }
  end

  def self.show_stations_on_route(chosen_route)
    puts "List of station existing on the route:"
    chosen_route.stations.each { |station| puts station.name }
  end

  def self.find_route
    puts "List of existing routes:"
    Route.existing_routes.each { |route| puts route.name }
    puts "Please type in desired route name."
    name = gets.chomp
    chosen_route = Route.existing_routes.find { |route| route.name == name }
  end
end
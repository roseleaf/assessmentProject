require "rest-client"
require "json"
require "ap"

class AssessmentClient

  HOST = "http://localhost:3000/"

  def run
    puts "----------------------------------------------"
    puts "Welcome to The API Client for Your Assessment"
    puts "----------------------------------------------"
    puts ""
    puts "To view customers, type 'customers'"
    puts "To create a new customer, type 'new + [first_name] + [last_name]' "
    puts "---------------------------------------"
    puts "To exit, type 'exit'"
    puts "---------------------------------------"
    command = ""

    while command != "exit"
      puts ""
      puts "enter command"
      command = gets.chomp
      puts ""
      command_array = command.split(" ")

      customer_id = nil

        if command_array[0] == "customers"
          index_customers
        elsif command_array[0] == "new"
          first_name = command_array[1]
          last_name = command_array[2]
          new_customer(first_name, last_name)
        elsif command == "exit"
          puts "Goodbye"
        end
    end
  end

  def request(path, params={}, method=:get)
    url = HOST + path + ".json"

    # "Send" method calls first argument as method on object, with other arguments as method arguments.
    response = RestClient.send(method, url, params)
    parse_request(response)
  end

  def parse_request(response)
    # OK Request, no content as response
    if response == ""
      true
    # JSON content
    else
      JSON.parse(response, symbolize_names: true)
    end
  end



  # CUSTOMER ACTIONS

  def index_customers
    path = "customers"
    response = request(path).to_s
    p response
  end

  def new_customer(first_name, last_name)
    path = "customers"
    params = {customer: {first_name: first_name, last_name: last_name}}
    request(path, params, :post)
    # output full list again
    index_customers
  end



end

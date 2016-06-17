# What classes do you need?

# Remember, there are four high-level responsibilities, each of which have multiple sub-responsibilities:
# 1. Gathering user input and taking the appropriate action (controller)
# 2. Displaying information to the user (view)
# 3. Reading and writing from the todo.txt file (model)
# 4. Manipulating the in-memory objects that model a real-life TODO list (domain-specific model)

# Note that (4) is where the essence of your application lives.
# Pretty much every application in the universe has some version of responsibilities (1), (2), and (3).
require 'csv'
	
class List
	
attr_reader :file
attr_accessor :list_array
	
	def initialize(file)
		@file = file
		@list_array = list_array
		@list_array = []
	
		CSV.foreach(File.path(@file)) do |row|
			@list_array << row
		end
	end
	
	def save
		  CSV.open(@file, "wb") do |csv|
		  	@list_array.each { |task| csv << task }
	     end
	end
	
	def add(new_todo)
		new_todo_array = []
		new_todo_array << new_todo
		@list_array << new_todo_array
		save
		puts "Appended '#{new_todo}' to your TODO list."
	end
	
	def delete(to_delete_todo)
		@list_array.each_with_index do |task, index|
			if index == to_delete_todo.to_i - 1
				puts "Deleted '#{task.first}' from your TODO list."
			end
		end
		@list_array.delete_at(to_delete_todo.to_i - 1)
		save
	end
	
	def to_s
		number = 1
		@list_array.each do |task|
			puts "#{number.to_s}. " + task.first
			number += 1
		end
	end
	
	
	end
	
	list = List.new('todo.csv')
	
	x = 0
	ARGV.each do |word|
		until x != 0
			if word == 'list'
			  list.to_s
			elsif word == 'add'
			  word_array = []
			  word_array << ARGV[1..-1]
			  list.add(word_array.join(" "))
			elsif word == 'delete'
			  list.delete(ARGV[1])
			else
				puts "Error! Invalid command."
			end
		x += 1
		end
	end

require 'pg'
require 'active_record'
require 'pry'


Dir["../models/*.rb"].each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "restaurant",
  host: "localhost" 
)

[
  {
    name: "Pizza",
    cuisine: "American",
    price: 10,
    allergens: "none",
  },
  {
    name: "Sushi",
    cuisine: "Japanese",
    price: 13,
    allergens: "none",
  },  
  {
    name: "Pasta",
    cuisine: "Italian",
    price: 12,
    allergens: "none",
  },
    {
    name: "Sandwich",
    cuisine: "American",
    price: 8,
    allergens: "none",
  },
].each do |food|
  Food.create( food )
end

[
  {
    table_number: 1,
    guests: 3,
    paid: false,
  },

  {
    table_number: 2,
    guests: 6,
    paid: false,
  },
   {
    table_number: 3,
    guests: 3,
    paid: false,
  },
   {
    table_number: 6,
    guests: 2,
    paid: false,
  },
].each do |party|
  Party.create( party )
end


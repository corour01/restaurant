Dir["models/*.rb"].each do |file|
  require_relative file
end


require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "restaurant",
  host: "localhost" 
)

class Restaurant < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get "/console" do
    Pry.start(binding)
    ""
  end

	get '/' do

		erb :'index'
	end

############## FOODS ROUTES ################

	get '/foods' do 
    @foods = Food.all
    erb :'foods/index'
  end

  get '/foods/new' do
    erb :'foods/new'
  end

  post '/foods' do 
    food = Food.create(params[:food])

    redirect to "foods/#{food.id}"
  end

  get '/foods/:id' do 
    food_id = params[:id]
    @food = Food.find(food_id)
    erb :'foods/show'
  end

  get '/foods/:id/edit' do
    @food = Food.find(params[:id])

    erb :'foods/edit'
  end

  patch '/foods/:id' do
    food = Food.find(params[:id])
    food.update(params[:food])

    redirect to "/foods/#{food.id}"
  end

  delete '/foods/:id' do
    food = Food.find(params[:id])
    food.destroy

    redirect to "/foods"
  end

############# Parties Routes ################  
	get '/parties' do 
    @parties = Party.all
    erb :'parties/index'
  end

  post '/parties' do 
    party = Party.create(params[:party])

    redirect to "/parties/#{party.id}"
  end

  get '/parties/new' do 
  	@available = Party.open_tables

    erb :'parties/new'
  end

  get '/parties/:id' do 
    party_id = params[:id]
    @party = Party.find(params[:id])
    @foods = @party.foods
    erb :'parties/show'
  end

  get '/parties/:id/edit' do 
    @party = Party.find(params[:id]) 
    @foods = Food.all
    erb :'parties/edit'
  end

  patch '/parties/:id' do
    party = Party.find(params[:id])
    party.update(params[:party])

    redirect to "/parties/#{party.id}"
  end

  # get '/parties/:party_id/order' do
  #   @party = Party.find(params[:party_id])
  #   @order = Order.find()
  #   erb :'parties/show'
  # end

  post '/parties/:party_id/order' do
    party = Party.find(params[:party_id])

    order = Order.create(params[:order])
    order.party_id = params[:party_id]
    order.food_id = params[:party][:food]
    order.save!
    
    redirect to "/parties/#{party.id}"
  end

  delete '/parties/:id' do
    party = Party.find(params[:id])
    party.destroy

    redirect to "/parties"
  end

  get '/parties/:id/receipt'  do
    @party = Party.find(params[:id])
    @foods = @party.foods
    erb :'parties/receipt'
    redirect to "/parties/:party_id"
  end

################### ORDERS ROUTES ####################

	get '/orders' do 
    @orders = Order.all
    erb :'orders/index'
  end

  post '/orders' do 
    Pry.start(binding)
    @order = Order.create(params[:order])

    redirect to 'orders/#{order.id}'
  end

  get '/orders/new' do 
    erb :'orders/new'
  end

  get '/orders/:id' do 
    order_id = params[:id]
    @order = Order.find(order_id)
    erb :'orders/show'
  end

  get '/orders/:id/edit' do
    @order = Order.find(params[:id])

    erb :'orders/edit'
  end

  patch '/orders/:id' do
    order = Order.find(params[:id])
    order.update(params[:order])

    redirect to "/orders/#{order.id}"
  end

  delete '/orders/:id' do
    order = Order.find(params[:id])
    order.destroy

    redirect to "/orders"
  end
end

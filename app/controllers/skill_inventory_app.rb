require_relative '../models/skill_inventory'

class SkillInventoryApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  set :method_override, true

  get '/' do
    erb :home
  end

  get '/skill_list' do
    @skills = SkillInventory.all
    erb :index
  end

  get '/new' do
    erb :new
  end

  post '/skill_list' do
    SkillInventory.add(params['skill'])
    redirect '/skill_list'
  end

  get '/edit/:id' do |id|
    @id = id
    erb :edit
  end

  get '/skill_list/:id' do |id|
    @skill = SkillInventory.find(id.to_i)
    erb :skill_page
  end

  put '/skill_list/:id' do |id|
    SkillInventory.update(id.to_i, params['skill'])
    redirect '/skill_list'
  end

end

get '/' do
    @search = CLIENT.search("#adopcion -rt").take(3)
  erb :index
end

get '/adoptar'do
  erb :adoptar
end
post '/adoptar' do
  erb :adoptar
end

get '/conocenos'do
  erb :conocenos
end
post '/conocenos' do
  erb :conocenos
end

get '/necesidades'do
  erb :necesidades
end
post '/necesidades' do
  erb :necesidades
end

post '/subir' do 
  @photo = Photo.new
  @photo.photo = params[:photo]
  @photo.user_id 	= session[:user_id]
  @photo.name_pet	= params[:namePet]
  @photo.age		= params[:age]
  @photo.especie	= params[:especie]
  @photo.race		= params[:race]
  @photo.coment		= params[:coment]
  @photo.save!

  redirect to "/users/#{session[:user_id]}"
end

get '/posibles_adopciones' do
  @lista_de = Photo.all
  erb :lista
end
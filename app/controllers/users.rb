before '/users/:id' do
  if session[:user_id]== nil
    puts session[:user_id]
    redirect to '/?error=true'
  end
end

get '/' do

  if params[:error]=='true'
    @error="No puedes acceder a esta session"
  end
end

get '/signup' do
  erb :'/signup'
end

post '/signup' do
  user = User.new(name: params[:nombre], email: params[:email])
  user.password=(params[:pass])
  if user.save
    session[:user_id] = user.id
    redirect to("users/#{user.id}")
  else
    redirect to ('/Error')
  end
end

get '/login' do
  erb :'login'
end

post '/login' do
  # user = params[:user]
  user = User.authenticate(params[:email], params[:pass])

  if user != nil
    session[:user_id] = user.id
    redirect to("/users/#{user.id}")
  else
    redirect to '/logout'
  end
end

get '/users/:id' do
  erb :profile
end

put "/users/:id" do
  user = User.find(params[:id])
  user = User.authenticate(user.email, params[:user]["password"])
  if user != nil
    user.password=(params[:user]["new_password"])
    user.save
    redirect to("/users/#{user.id}")
  else
    redirect to ('/Error')
  end
end

delete '/users/:id' do
  user = User.find(params[:id])
  user.destroy
  redirect to ('/logout')
end

get '/users/:id/edit_user' do
  @user = User.find(params[:id])
  erb :edit_user
end

get '/logout' do
  session.clear
  redirect to('/')
end

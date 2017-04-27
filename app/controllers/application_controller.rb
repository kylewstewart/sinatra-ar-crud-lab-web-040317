require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to ('/posts')
  end

  get '/posts' do
    @posts_all = Post.all

    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.new(params)
    @post.save

    redirect to ("/posts")
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])

    erb :show
  end

  get '/posts/:id/edit' do
      @post = Post.find(params[:id])

    erb :edit
  end

  patch '/posts/:id' do
    post = Post.find(params[:id])
    post.update(name: params[:name])
    post.update(content: params[:content])

    redirect to ("/posts/#{post.id}")
  end

  get '/posts/:id/delete' do
    @post = Post.find(params[:id])

    erb :delete
  end

  delete '/posts/:id/delete' do
    post = Post.find(params[:id])
    @name = post.name
    post.destroy

    erb :delete
  end

end

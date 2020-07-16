class ListsController < ApplicationController
  get '/lists' do
    
    
    if logged_in?
      @lists = List.all
      erb :'lists/lists'
    else
      redirect to '/login'
    end
  end

  get '/lists/new' do
    if logged_in?
      erb :'lists/create_list'
    else
      redirect to '/login'
    end
  end

  post '/lists' do
    if params[:content] == ""
      redirect to "/lists/new"
    else
      @list = current_user.lists.create(content: params[:content])
      redirect to "/lists"
    end
  end

  get '/lists/:id' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      erb :'lists/show_list'
    else
      redirect to '/login'
    end
  end

  get '/lists/:id/edit' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      if @list && @list.user == current_user
       erb :'lists/edit_list'
      else
        redirect to '/lists'
      end
    else
      redirect to '/login'
    end
  end

  patch '/lists/:id' do
    if params[:content] == ""
      redirect to "/lists/#{params[:id]}/edit"
    else
      @list = List.find_by_id(params[:id])
      @list.content = params[:content]
      @list.save
      redirect to "/lists"
    end
  end

  delete '/lists/:id/delete' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      if @list.user_id == current_user.id
        @list.delete
        redirect to '/lists'
      else
        redirect to '/lists'
      end
    else
      redirect to '/login'
    end
  end
end
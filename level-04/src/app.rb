require 'sinatra'

def get_todos
  @@todos ||= []
end

def add_todo(todo,date)
  get_todos().push(todo=>date)
end


def get_todo
  get_todos()[@id - 1]
end


get "/todos" do
  @todos = get_todos()
  erb :todos
end

get "/todos/:id" do
  @id = params[:id].to_i
  @todo = get_todo()
  erb :todo
end

post "/todos" do
  add_todo(params[:title],params[:date])
  redirect "/todos"
end

def update_todo(title)
  get_todos()[@id - 1] = {title=>get_todos()[@id-1][get_todos()[@id-1].keys[0]]}
end

put "/todos/:id" do
  @id = params[:id].to_i
  update_todo(params[:title])
  redirect "/todos"
end

def delete_todo
  get_todos().slice!(@id - 1)
end

delete "/todos/:id" do
  @id = params[:id].to_i
  delete_todo
  redirect "/todos"
end
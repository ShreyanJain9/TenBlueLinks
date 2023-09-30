get "/" do
  @title = "Home"
  erb :search
end

get "/results" do
  @query = URI.decode_www_form_component(params[:query])
  @title = "\"#{@query}\" Results"
  @engine = params[:engine]
  @results = search_with(params[:engine], QueryBuilder.new(@query, cookies[:where], cookies[:safesearch], (params[:page] || 0), 10))
  @pages = next_and_prev_page(request.url)
  erb :results
end

def search_with(name, query)
  Engines[name.to_sym][1].call(query)
end

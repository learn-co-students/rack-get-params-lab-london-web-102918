class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Cookies", "Oreos"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

  if @@cart.length == 0
    resp.write "Your cart is empty"
  else
    @@cart.each do |cart|
      resp.write "#{cart}\n"
    end
  end

    if 
      req.path.match(/add/)
    search_param = req.params["item"]
    if @@items.include?(search_param)
      @@cart << search_param
      resp.write "added #{search_param}"
    else
      resp.write "We don't have that item"
    end
    else
      resp.write "Path Not Found"
    end



    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end

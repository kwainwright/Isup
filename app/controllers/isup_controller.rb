class IsupController < ApplicationController
  
  def input
  end

  def result
     @url_string = params[:url]
    
    if @url_string.nil?
      redirect_to isup_path
      return
    end
    
    if !is_valid_url?(@url_string)
      @status = "URL_Format_Issue"
    else 
      if url_exist?(@url_string)
        @status = "Available"
      else
        @status = "Not_Available"
      end
    end
  
    require 'date'
    current_time = DateTime.now

    request = Request.new
    request.timestamp = current_time.strftime "%d/%m/%Y %H:%M"
    request.url = @url_string
    request.status = @status
    
    request.save
  end
  
  protected
  
  def is_valid_url?(url_str)
    url = url_str
    url.insert(0, "http://") unless(url.match(/^http\:\/\//))
    url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  end
  
  require "net/http"
   
  def url_exist?(url_str)
    
    url = url_str
    # check if http:// was in the url if not add it in there
    url.insert(0, "http://") unless(url.match(/^http\:\/\//))
 
    begin
      Timeout::timeout(5) do
        # Get the HTTP_RESPONSE from the site we are checking
        res = Net::HTTP.get_response(URI.parse(url.to_s))
        
        # Check the response code and send an email if the code is bad
        unless(res.code =~ /2|3\d{2}/ ) then
         false
        else
         true
        end
      end   
    rescue Timeout::Error, SocketError
      false
    end
  end
  
end

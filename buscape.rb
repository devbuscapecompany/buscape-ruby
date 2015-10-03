require 'httparty'
require 'uri'


class BuscaPe
  include HTTParty
  
  def initialize(application_id, sandbox = false, country = "BR")
    
    raise "You need to inform your :application_id" if application_id.nil?
    
    #@base_uri = "sandbox.buscape.com/service" unless options[:sandbox].nil? || !options[:sandbox]
    @env = (sandbox) ? 'sandbox' : 'bws'
    @application_id =application_id;
    @country = country
    
    
    @uris = {
      :categories => "findCategoryList",
      :products => "findProductList",
      :ratings => "viewUserRatings",
      :oferts => "findOfferList",
      :details => "viewProductDetails"
    }

    @params = {
      :category => "categoryId",
      :product => "productId",
      :top_products => "topProducts",
      :seller => "sellerId",
      :offer => "offerId",
      :keyword => "keyword"
    }

    @data = {}
  end
  
  private
  
  def self.method_missing(method, *args, &block)
    if @uris.map {|v, k| v }.include? method
        @data.merge!(args[0])
        fetch_api(method)
    else
        @data.merge!({method => args[0]})
        self
    end
  end
  
  def self.fetch_api(method)
    raise "Method '#{method}' doesn't exist!" if @uris[method].empty?
    
    @uris[method] = "viewSellerDetails" if method === :details && !@data[:seller].blank? && @data[:product].blank?
    
    #url = "http://#{@base_uri}/#{@uris[method]}/#{@application_id}/"
    url = "http://#{@env}.buscape.com/service/#{@uris[method]}/lomadee/#{@application_id}/#{@country}/"

    @data.each { |sym, value|
      url += ((url[-1, 1] == "/") ? "?" : "&") + "#{(@params[sym].blank?) ? sym.to_s : @params[sym]}=#{value}" 
    }
    
    uri_parser = URI::Parser.new
    
    response = self.class.get(uri_parser.escape(url))

    response.parsed_response["Result"] unless res.nil?
  end
end

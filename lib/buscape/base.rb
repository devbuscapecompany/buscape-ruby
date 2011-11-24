module Buscape
  class Base
    include HTTParty

    def initialize(application_id, sandbox = false)
      raise "You need to inform your :application_id" if application_id.nil?

      @env = (sandbox) ? 'sandbox' : 'bws'
        
      @application_id = application_id;

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
        :seller => "sellerId"
      }

      @data = {}
    end

    private

    def method_missing(method, *args, &block)
      if @uris.map {|v, k| v }.include? method
        fetch_api(method)
      else
        @data.merge!({method => args[0]})
        self
      end
    end

    def fetch_api(method)
      raise "Method '#{method}' doesn't exist!" if @uris[method].empty?

      @uris[method] = "viewSellerDetails" if method === :details && !@data[:seller].blank? && @data[:product].blank?

      url = "http://#{@env}.buscape.com/service/#{@uris[method]}/#{@application_id}/"

      @data.each { |sym, value|
        url += ((url[-1, 1] == "/") ? "?" : "&") + "#{(@params[sym].empty?) ? sym.to_s : @params[sym]}=#{value}" 
      }

      res = self.class.get(url)
      
      res.parsed_response["Result"] unless res.nil?
    end
  end
end
class LoanHero < ApplicationRecord
    require 'json'
    require 'hashie'
    require 'net/http'

    class << self
        def merchant_login(params = {})           
            begin        
                uri = URI.parse base_url
                data = params                ####### {email: "invisalign@loanhero.com", password: "$$!Lfgb5gOl", subdoman: "invisalign" }
                http = Net::HTTP.new(uri.host, uri.port)
                http.use_ssl = true
                request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
                request.body = data.to_json
                response = http.request(request)
                resp_obj = response_object response.body
                if response.code == "200"
                    return {status: response.code, body: resp_obj}
                else
                    return {status: response.code, message: response.body.msg }
                end
            rescue Exception => e
                logger.fatal("Error Occured ===> #{e.inspect}")
                return nil
            end 
        end

        def get_request 
            request = Net::HTTP.get(uri)
        end

        private

        def base_url
            "https://api.staging.loanherotest.com/v1/sessions"
        end

        def response_object response
            response_hash = JSON.parse response
            Hashie::Mash.new response_hash
        end
    end
end

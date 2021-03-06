module JWTear
  module Utils

    # Check latest version
    def latest_version
      begin
        current_version = JWTear::VERSION
        rubygem_api     = JSON.parse open("https://rubygems.org/api/v1/versions/jwtear.json").read
        remote_version  = rubygem_api.first["number"]
        latest          = remote_version.eql?(current_version)? true : false

        latest ? current_version : remote_version
      rescue Exception => e
        puts "[!] ".yellow  + " Couldn't check the latest version, please check internet connectivity."
        exit!
      end
    end

    # check token format
    def is_token?(token)
      begin
        token_size = token.split('.').size
        raise InvalidTokenError if token_size < 2
      rescue InvalidTokenError
        puts '[!] '.red + "Invalid token: #{token}"
        exit!
      end
    end
    
    def encode(data)
      Base64.urlsafe_encode64(data, padding: false) unless data.nil?
    end

    def decode(data)
      Base64.urlsafe_decode64(data)
    end

    # def encode_header_payload_signature(header, payload, signature)
    #   [header, payload, signature].map {|part| encode part}.join('.')
    # end

    # JWTear's logo
    def self.banner
      %Q{\n    888888 888       888 88888888888
      "88b 888   o   888     888
       888 888  d8b  888     888
       888 888 d888b 888     888   .d88b.   8888b.  888d888
       888 888d88888b888     888  d8P  Y8b     "88b 888P"
       888 88888P Y88888     888  88888888 .d888888 888
       88P 8888P   Y8888     888  Y8b.     888  888 888
       888 888P     Y888     888   "Y8888  "Y888888 888
     .d88P                                       v#{JWTear::VERSION}
   .d88P"
  888P"    }
    end
  end
end
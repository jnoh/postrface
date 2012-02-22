require 'base64'
require 'openssl'
class Auth::OauthsController < ApplicationController
      
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end
      
  def callback
    provider = params[:provider]

    if @user = current_user
      begin
        create_auth(provider)
        redirect_to verification_me_settings_path, :notice => "Linked #{provider.titleize}!"
      rescue
        redirect_to verification_me_settings_path, :alert => "Failed to link #{provider.titleize}!"
      end

      session[:oauth_return_to_url] = nil

    end
  end

  def deauthorize

  end

  private
  
    def create_auth(provider)
      provider = provider.to_sym
      @provider = Config.send(provider)
      @provider.process_callback(params,session)
      # @token = @provider.process_callback(params,session).token
      
      @user_hash = @provider.get_user_hash
      
      if @user.authentications.connected?(provider.to_s)
        @user.update_social(provider, {:uid => @user_hash[:uid], :token => access_token})
      else
        @user.add_social({
          :provider => provider, 
          :uid => @user_hash[:uid],
          :token => @token})
      end
    end

    def parse_facebook_request(str, app_secret)
      string = str.split(".") # splits our signed request
      encodedsig = string[0] # signature
      payload = string[1] # payload

      sig = base64_url_decode(encodedsig)
      data = JSON.parse(base64_url_decode(payload))

      if(data["algorithm"] != "HMAC-SHA256") 
        puts "Expected HMAC-SHA256, got something else."
        return nil
      end

      hash = OpenSSL::HMAC.digest('sha256', app_secret, payload)
      if(sig != hash)
        puts "Bad signed JSON signature"
        return nil
      end

      return data
    end

    def base64_url_decode(str)
      str += '=' * (4 - str.length.modulo(4))
      #puts str
      Base64.decode64(str.gsub("-", "+").gsub("_", "/"))
    end
end

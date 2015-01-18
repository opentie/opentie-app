# coding: utf-8
class OpenidConnecter
  attr_accessor :default_option
  
  DEFAULT_OPTION = {
    name: :undefined,
    scope: [:openid, :email, :profile, :address],
    response_type: :code,
    client_options: {
      port: 443,
      scheme: "https",
      host: "myprovider.com",
      identifier: OPENID["OP_CLIENT_ID"],
      secret: OPENID["OP_SECRET_KEY"],
      redirect_uri: "http://myapp.com/users/auth/openid_connect/callback",
    }
  }
  
  def initialize(option={})
    raise "argment is not Hash." unless option.class.eql? Hash
    @default_option = DEFAULT_OPTION
    @default_option.merge!(option)
  end
  
  def get_redirect_url
    @connecter = OmniAuth::Strategies::OpenIDConnect.new @default_option
    @connecter.request_phase
    # 運用でカバー
  end

  def compacting_return_data(*return_param)
    @connecter.callback_phase
    # あとで
  end
end

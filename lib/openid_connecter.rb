# coding: utf-8
class OpenidConnecter
  attr_accessor :default_option
  
  DEFAULT_OPTION = {
    name: :novs_op,
    scope: [:openid, :email, :profile, :address, :phone],
    response_type: :code,
    client_options: {
      port: 443,
      scheme: "https",
      host: "connect-op.herokuapp.com",
      identifier: OPENID["OP_CLIENT_ID"],
      secret: OPENID["OP_SECRET_KEY"],
      redirect_uri: "https://everysick.gehirn.ne.jp/api/v1/login/call_back",
    }
  }
  
  def initialize(option={})
    raise "argment is not Hash." unless option.class.eql? Hash
    @default_option = DEFAULT_OPTION.merge(option)
  end
  
  def get_redirect_url
    @connecter = OmniAuth::Strategies::OpenIDConnect.new(:openid_connect, @default_option)
    @connecter.request_phase
  end

  def compacting_return_data(*return_param)
    @connecter.callback_phase
    # あとで
  end
end

class LoginService

  PROVIDERS = [
      GOOGLE = "google_oauth2"
  ]


  class AuthenticationError < RuntimeError; end

  def self.from_omniauth(auth_hash)
    uid = auth_hash.uid
    provider = auth_hash.provider

    raise AuthenticationError.new unless PROVIDERS.include?(provider)
    raise AuthenticationError.new("Sign in is only allowed from these domains: #{allowed_domains.join(" ")}") unless allowed_domain?(auth_hash)

    User.find_or_create_by!(uid: uid, provider: provider) do |new_user|
      new_user.uid = uid
      new_user.provider = provider
      info = auth_hash.info || {}
      new_user.email = info.email
      new_user.password = Devise.friendly_token[0,20]
      new_user.first_name = info.first_name
      new_user.last_name = info.last_name
      new_user.image = info.image
    end
  end

  private

  def self.allowed_domain?(auth_hash)
    email_warning?(auth_hash.info.email)
    domain = auth_hash.extra.try(:raw_info).try(:hd)
    allowed_domains.include?(domain)
  end

  def self.email_warning?(email_address)
    if(email_address.blank?)
      Rails.logger.warn "email is blank on log in"
    else
      domain = email_address.split("@").last.strip
      Rails.logger.warn "email domain doesn't match configured domains : #{domain}" unless allowed_domains.include?(domain)
    end
  end

  def self.allowed_domains
    ENV['GOOGLE_OAUTH_DOMAINS'].split(',').map { |d| d.strip }
  end
end

class Identity < ApplicationRecord
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

   def self.find_for(auth)

    find_by(provider: auth.provider, uid: auth.uid)
  end


  def self.format_data(object)
    if object.is_a?(Hash)
      object = object.clone
      object.each do |key, value|
        object[key] = format_data(value)
      end
      OpenStruct.new(object)
    else
      object
    end
  end

  #api for social login
  def self.find_and_init_for(auth)
    auth_provider = self.find_or_initialize_by(uid: auth.uid, provider: auth.provider)

    auth_provider.user = User.find_or_initialize_by(email: auth.info.email) do |user|
      user.password = Devise.friendly_token[0,20]
      user.password_sent = true
      user.confirmed_at = Time.now
      user.skip_confirmation!
      user.save!
      auth_provider.user_id = user.id
      auth_provider.save!

      # if auth.info.first_name.nil?
      #   user.first_name = auth.info.name
      # else
      #   user.first_name = auth.info.first_name
      #   user.last_name = auth.info.last_name
      # end
    end
    return auth_provider
  end


  def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end
end

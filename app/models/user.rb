class User < ActiveRecord::Base
  has_many :tasks
  has_secure_password

  def slug
    self.username.to_s.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.detect {|user| user.slug == slug}
  end

end

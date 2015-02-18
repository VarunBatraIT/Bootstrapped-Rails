class User < ActiveRecord::Base
  rolify :before_add => :before_add_method
  #resourcify
  def self.all_roles
    all_roles = %w[admin user]
  end
  def before_add_method(role)
    # do something before it gets added
  end

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.add_role(:user)
  end

  def admin?
    (self.id > 0 && self.is_admin? )
  end

  def user?
    !(self.id > 0 && self.is_admin? )
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable


end

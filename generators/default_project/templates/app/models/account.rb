require 'digest/sha1'

class Account < ActiveRecord::Base
    
    acts_as_acl :account

    # Virtual attribute for the unencrypted password
    attr_accessor :password
    
    # Set default values for acts_as_state machine fields
    defaults :state => 'pending'

    validates_presence_of     :login, :email
    validates_presence_of     :password,                   :if => :password_required?
    validates_presence_of     :password_confirmation,      :if => :password_required?
    validates_length_of       :password, :within => 4..40, :if => :password_required?
    validates_confirmation_of :password,                   :if => :password_required?
    validates_length_of       :login,    :within => 3..40
    validates_length_of       :email,    :within => 3..100
    validates_uniqueness_of   :login, :email, :case_sensitive => false
    before_save :encrypt_password
  
    # prevents a user from submitting a crafted form that bypasses activation
    # anything else you want your user to change should be added here.
    attr_accessible :login, :email, :password, :password_confirmation

    acts_as_state_machine :initial => :pending
    state :pending
    state :active    
    state :suspended
    state :deleted, :enter => :do_delete

    event :register do
        transitions :from => :pending, :to => :active, :guard => Proc.new {|u| !u.crypted_password.blank? || !u.password.blank? }
    end
    
    event :suspend do
        transitions :from => [:pending, :active], :to => :suspended
    end
  
    event :delete do
        transitions :from => [:pending, :active, :suspended], :to => :deleted
    end

    event :unsuspend do
        transitions :from => :suspended, :to => :active
    end

    # Authenticates a account by their login name and unencrypted password.
    # Returns the account or nil.
    def self.authenticate(login, password)
        u = find_in_state :first, :active, :conditions => {:login => login} # need to get the salt
        u && u.authenticated?(password) ? u : nil
    end

    # Encrypts some data with the salt.
    def self.encrypt(password, salt)
        Digest::SHA1.hexdigest("--#{salt}--#{password}--")
    end

    # Encrypts the password with the account salt
    def encrypt(password)
        self.class.encrypt(password, salt)
    end

    def authenticated?(password)
        crypted_password == encrypt(password)
    end

    def remember_token?
        remember_token_expires_at && Time.now.utc < remember_token_expires_at 
    end

    # These create and unset the fields required for remembering accounts
    # between browser closes
    def remember_me
        remember_me_for 2.weeks
    end

    def remember_me_for(time)
        remember_me_until time.from_now.utc
    end

    def remember_me_until(time)
        self.remember_token_expires_at = time
        self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
        save(false)
    end

    def forget_me
        self.remember_token_expires_at = nil
        self.remember_token            = nil
        save(false)
    end


    protected
    
    # before filter
    def encrypt_password
        return if password.blank?
        self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
        self.crypted_password = encrypt(password)
    end
      
    def password_required?
        crypted_password.blank? || !password.blank?
    end
    
    def do_delete
        self.deleted_at = Time.now.utc
    end

end

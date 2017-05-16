class UsersController < ApiController
  before_action :require_login

  # This is protected by API token
  def index
   users = User.all
   users = build_user_obj(users)
   render json: users
  end

  def create
    error = false
    message = "Validation failed for input."
    user = User.new
    user.email = params["user"]["email"]
    user.password = params["user"]["password"]
    user.password_confirmation = params["user"]["password_confirmation"]
    user.name =  params["user"]["username"]
    if user.save!
      user_info = UserInfo.new 
      user_info.user_id = user.id 
      user_info.firstname = params["user"]["firstname"]
      user_info.lastname = params["user"]["lastname"]
      user_info.gender = params["user"]["gender"]
      user_info.address = params["user"]["address"]
      user_info.pincode = params["user"]["pincode"]
      user_info.phone = params["user"]["phone"]
      p user_info
      if user_info.save!
	message = "User created successfully with ID: #{user.id}"
      end
    end
    
    #user = User.new(params['user'])
    render json: {error: error, message: message}
  end
  
  def update
  end

  def show
   user_info = {
        id: current_user.id,
        name: current_user.name,
        email: current_user.email,
        created_at: current_user.created_at
   }
   render json: user_info
  end
  
  def build_user_obj users
    p users
    users_arr = []
    user_hash = Hash.new
    users.each do |user|
      user_hash['id'] = user.id
      user_hash['username'] = user.name
      user_hash['firstname'] = user.user_info.firstname
      user_hash['lastname'] = user.user_info.lastname
      user_hash['email'] = user.email
      user_hash['gender'] = user.user_info.gender
      user_hash['address'] = user.user_info.address
      user_hash['pincode'] = user.user_info.pincode
      user_hash['phone'] = user.user_info.phone
      users_arr << user_hash
    end
    return users_arr
  end
  
end

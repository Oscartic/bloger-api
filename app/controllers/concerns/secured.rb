module Secured
  def authenticate_user!
    #Bearer XXXX
    token_regex = /Bearer (\w+)/
    # read auth Header
    headers = request.headers
    # check it if valid
    if headers['Authorization'].present? && headers['Authorization'].match(token_regex)
      token = headers['Authorization'].match(token_regex)[1]
      # verify if it corresponds to the user
      if(Current.user = User.find_by_auth_token(token))
        return
      end
    end
    render json: {error: 'Unauthorized' }, status: :unauthorized
  end
end
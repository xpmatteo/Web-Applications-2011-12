class UserRepository
  def initialize()
    @users = []
  end

  def add(user)
    @users << user
  end
end
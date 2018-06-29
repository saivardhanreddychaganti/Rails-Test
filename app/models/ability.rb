class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role? 'superAdmin' 
      can :manage, :all 
    elsif user.role? 'participant' 
      can [ :index, :create] , [Task]
    end 
  end
end

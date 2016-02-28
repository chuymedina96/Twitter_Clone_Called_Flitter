class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
        has_many :posts, dependent: :destory #this code right here makes sure that if a user deletes their account, all post associated with the account get deleted as well
        has_many :active_relationship, class_name: "Realtionship", foreign_key: "follower_id", dependent: :destroy
        has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
        
        
        has_many :following, through: :active_relationships, source: followed
        has_many :followers, through: :active_relationships, source: follower
        
        
        #helper methods
        
        # follow another user
        def follow(other)
          active_relationship.create(followed_id: other.id)
        end
        
        def unfollow(other)
          active_relationship.create(followed_id: other.id).destroy
        end
        
        def following?(other)
          following.include?(other)
        end
        
        
end

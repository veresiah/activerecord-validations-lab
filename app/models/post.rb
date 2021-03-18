class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 250 }
    validates :summary, presence: true, length: { maximum: 250 }
    validates :category, presence: true, inclusion: { in: %w(Fiction Non-Fiction) }    
    validate :clickbait?

    CLICKBAIT_PHRASES = [  
        /Won't Believe/i,
        /Secret/i,
        /Top [0-9]*/i,
        /Guess/i
    ]

    def clickbait?
        if CLICKBAIT_PHRASES.none? { |p| p.match title }
           errors.add(:title, "must be clickbait")
        end
    end 
end
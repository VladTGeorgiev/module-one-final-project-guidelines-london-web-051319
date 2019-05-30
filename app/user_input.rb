class Input
    attr_reader :user_id
    attr_accessor :article_id

    def initialize(user_id)
        @user_id = user_id
    end
end

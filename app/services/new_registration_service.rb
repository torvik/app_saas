class NewRegistrationService

	def initialize(params)
		@user = params[:user]
		@account = params[:account]
	end

	def self.call(params)
		new(params).perform
	end

	private 

	attr_reader :user, :account

	def perform
		begin 
			account_create
			send_welcome_email
			notify_slack
		rescue ActiveRecord::RecordInvalid => exception
			OpenStruct.new(
			  success?: false, user: user, account: account, error: exception.message
			)
		else
		  OpenStruct.new(success?: true, user: user, account: account, error: nil)
		end
	end

	def account_create
		post_account_setup if account.save!
	end

	def post_account_setup
		user.account_id = account.id
		user.save!
		user.add_role :admin, account
	end

	def send_welcome_email
		## NO OP
		WelcomeEmailMailer.welcome_email(user).deliver_later
	end

	def notify_slack
		SlackNotificationJob.perform_later(@user)
		# notifier = Slack::Notifier.new(
		# 	"https://hooks.slack.com/services/89ypfhuiwquhfwfwef908wefoij"
		# )
		# notifier.ping(
		# 	"A New User has appeared! #{account.name} - #{user.name}\
		# 	 || ENV: #{Rails.env}"
		#  )
	end
end


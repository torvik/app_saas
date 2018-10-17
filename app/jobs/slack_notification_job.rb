class SlackNotificationJob < ApplicationJob
  queue_as :notifications

  def perform(user)
  	notifier = Slack::Notifier.new("https://hooks.slack.com/services/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"
  	)
  	notifier.ping "A new user has appeared!|
  	#{user.account.name} - #{user.name} || ENV: #{Rails.env}"
  end
end

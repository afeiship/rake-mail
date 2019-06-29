require "json"
require_relative "./utils"
include Utils

pkg = JSON.load File.open "./package.json"

# main task list:
namespace :mail do
  # build & serve:
  desc "deliver to somebody"
  task :deliver, [:name, :content] do |task, args|
    args.with_defaults(
      name: MAIL_CONFIG["mail"][:name],
      content: `git log --pretty=format:"%an: %s" -#{MAIL_CONFIG["mail"][:size]}`,
    )
    send_mail({ name: args[:name], content: args[:content] })
  end
end

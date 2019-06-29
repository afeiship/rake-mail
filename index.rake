require "json"
require "./utils"
include Utils

pkg = JSON.load File.open "./package.json"

# main task list:
namespace :mail do
  # build & serve:
  desc "deliver to somebody"
  task :deliver, [:name, :content] do |task, args|
    args.with_defaults(
      name: pkg["name"],
      content: pkg["description"],
    )
    send_mail({ name: args[:name], content: args[:content] })
  end
end

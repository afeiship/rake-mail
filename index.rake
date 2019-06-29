require "json"
require_relative "./utils"
include Utils

pkg = JSON.load File.open "./package.json"

# main task list:
namespace :mail do
  # build & serve:
  desc "deliver to somebody"
  task :deliver, [:name, :content] do |task, args|
    is_dev = pkg["version"].include?("alpha")
    prefix = is_dev ? "🐛🐛🐛" : "🐶🐶🐶"

    args.with_defaults(
      name: MAIL_CONFIG["mail"][:name],
      pkg: pkg,
      content: `git log --pretty=format:"%an: %s" -#{MAIL_CONFIG["mail"][:size]}`,
      is_dev: is_dev,
      prefix: prefix,
    )
    send_mail({
      name: args[:name],
      content: args[:content],
      pkg: args[:pkg],
      prefix: prefix,
      is_dev: is_dev,
    })
  end
end

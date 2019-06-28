require "./utils"

include Utils

# main task list:
namespace :mail do
  # build & serve:
  desc "deliver to somebody"
  task :deliver do
    send_mail({ name: "xiaoming" })
  end
end

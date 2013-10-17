unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano-vpmframe requires Capistrano 2+"
end

Capistrano::Configuration.instance.load do

namespace :credentials do

  desc "Upload database credentials to the shared directory"
  task :upload_db_cred, :roles => :app do
    run "mkdir -p #{shared_path}/config"
    upload("./config/database.yml", "#{shared_path}/config/database.yml")
  end

  desc "Upload S3 credentials to the shared directory"
  task :upload_s3_cred, :roles => :app do
    run "mkdir -p #{shared_path}/config"
    upload("./config/s3.yml", "#{shared_path}/config/s3.yml")
  end

  desc "Symlink database credentials to the current release directory"
  task :symlink_db_cred, :roles => :app do
    run "#{try_sudo} ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

end

end

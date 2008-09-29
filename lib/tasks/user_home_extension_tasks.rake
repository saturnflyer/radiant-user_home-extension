namespace :radiant do
  namespace :extensions do
    namespace :user_home do
      
      desc "Runs the migration of the User Home extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          UserHomeExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          UserHomeExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the User Home to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from UserHomeExtension"
        Dir[UserHomeExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(UserHomeExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end

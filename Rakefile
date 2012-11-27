BASENAME = File.basename(Dir.getwd)

USER = "lenni"
HOST = "lenni.info"
PATH = "www/#{BASENAME}"

task :default => ["deploy"]

desc "Deploys the content of this folder minus the .git directory"
task :deploy do
  sh "jekyll"
  puts "rsyncing... "
  sh "rsync -rC _site/ #{USER}@#{HOST}:#{PATH}"
  html = `ls -l _posts/|grep html|wc -l`.strip
  md = `ls -l _posts/|grep md|wc -l`.strip
  puts ""
  puts "HTML:     #{html}"
  puts "Markdown: #{md}"
end

task :server do
  sh "jekyll --auto --server"
end

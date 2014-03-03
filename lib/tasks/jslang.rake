
desc "create a static javascript translation file with each language available as a JSON object"
task :jslang => :environment do
  languages = %w(en cy)
  langfilejs = "app/assets/javascripts/translations/"
  namespace = "MAS"
  languages.each do |lang|
    file=File.new(langfilejs+"#{lang}.js","w")
    langfile=YAML::load(File.open("config/locales/#{lang}.yml"))
    json=JSON.dump(langfile[lang]['js'])
    file.write("define([],function(){return "+json+"});\n")
    file.close
  end
end

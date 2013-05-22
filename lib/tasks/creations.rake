namespace :creations do
  task calculate: :environment do
    creation_entry_regexp = /\[([\w\W]+)\] Model created: '([\w\W]+)'/
    log_path = File.join(Rails.root, "log", "development.log")
    date_to_calculate = Date.today
    result = Hash.new{|hash, key| hash[key] = 0}

    File.open(log_path, "r") do |f|
      f.each_line do |line|
        if line =~ creation_entry_regexp
          creation_time = Date.parse($1)
          model_name = $2.strip
          if creation_time == date_to_calculate
            result[model_name] += 1
          end
        end
      end
    end

    puts "Statistics for: #{date_to_calculate}"
    result.each_pair do |key, value|
      puts "  #{key}: #{value}"
    end
  end
end

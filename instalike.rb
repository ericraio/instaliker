require 'rubygems'
require 'instagram'

# configure instagram gem, get token by registering app and following client-side authentication on http://instagram.com/developer/
Instagram.configure do |config|
  config.access_token = ENV['ACCESS_TOKEN']
end

# define tags to grab pictures to like from
selected_tags = %w{
  supranation 
  supra 
  sd_supras 
  supras 
  mkiv 
  2jz 
  turbo 
  boost 
  greddy 
  tein 
  hks 
  lowered 
  jdm 
  2jznoshit 
  trust 
  usdm 
  toyota 
  cars 
  scion 
  lexus 
  japanese 
  carporn 
  wheels
  volks 
  supragram 
  trd
}

# loop through each tag
selected_tags.shuffle.each do |tag|
  
  #get 60 most recent photos from tag
  photos = Instagram.tag_recent_media(tag, {:count => 60})
  
  error_count = 0 
  
    photos.each do |photo|
      
      # like each photo 
      puts "starting liking #{tag} - #{photo.id}"
      begin
        Instagram.like_media(photo.id)
        puts "completed liking #{photo.id}"
      rescue Exception => e  
        error_count = error_count + 1
        puts e.message 
        if error_count%2 == 0   
          puts 'Error! Retry has failed, waiting 60 min'
          sleep 3600
        end 
      end
    end
end 

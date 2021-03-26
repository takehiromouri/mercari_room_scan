require 'google/cloud/vision'
require 'base64'

class VisionHandler
  def initialize
    Google::Cloud::Vision.configure do |config|
      config.credentials = JSON.parse(ENV['VISION_CREDENTIALS'])
    end  
  end

  def detect_objects(image)
    arr = []

    client = Google::Cloud::Vision.image_annotator    
    response = client.label_detection image: image

    response.responses.each do |res| 
      res.label_annotations.each do |label|
        arr.push(label.description) if label.score > 0.9
      end
    end

    return arr
  end
end


# handler = VisionHandler.new
# handler.detect_objects("https://www.mydomaine.com/thmb/KWYFPjZMCuhABZNIM5F-o-eiwlM=/735x0/cdn.cliqueinc.com__cache__posts__212361__-2030968-1483470364.700x0c-8571e60cad7b42a981ab29ae10b5c153-1c3248487c784cd2994c5a3ba02f7115.jpg")

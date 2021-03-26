require 'google/cloud/vision'

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
        arr.push(label.description) if label.score > 0.85
      end
    end

    return arr
  end
end
